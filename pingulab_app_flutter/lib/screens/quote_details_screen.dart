import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../main.dart';
import 'quote_form_screen.dart';
import 'quote_versions_screen.dart';
import 'sale_details_screen.dart';

class QuoteDetailsScreen extends StatefulWidget {
  final int quoteId;

  const QuoteDetailsScreen({super.key, required this.quoteId});

  @override
  State<QuoteDetailsScreen> createState() => _QuoteDetailsScreenState();
}

class _QuoteDetailsScreenState extends State<QuoteDetailsScreen> {
  QuoteDetails? _quoteDetails;
  bool _isLoading = true;
  String? _error;
  List<Sale>? _sales;

  @override
  void initState() {
    super.initState();
    _loadSales();
    _loadQuoteDetails();
  }

  Future<void> _loadQuoteDetails() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final details = await client.quote.getQuoteDetails(widget.quoteId);
      debugPrint('Loaded quote details: $details');
      setState(() {
        _quoteDetails = details;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }
Future<void> _loadSales() async {
    try {
      final sales = await client.sales.getSalesByQuoteId(widget.quoteId);
      setState(() {
        _sales = sales;
      });
    } catch (e) {
      debugPrint('Error loading sales: $e');
    }
  }

  
  Color _getStatusColor(QuoteStatus status) {
    switch (status) {
      case QuoteStatus.PENDIENTE:
        return Colors.orange;
      case QuoteStatus.PROCESO:
        return Colors.blue;
      case QuoteStatus.FINALIZADO:
        return Colors.green;
      case QuoteStatus.CANCELADO:
        return Colors.red;
    }
  }

  String _getStatusText(QuoteStatus status) {
    switch (status) {
      case QuoteStatus.PENDIENTE:
        return 'Pendiente';
      case QuoteStatus.PROCESO:
        return 'En Proceso';
      case QuoteStatus.FINALIZADO:
        return 'Finalizado';
      case QuoteStatus.CANCELADO:
        return 'Cancelado';
    }
  }

  Future<void> _updateStatus(QuoteStatus newStatus) async {
    try {
      await client.quote.updateQuoteStatus(widget.quoteId, newStatus);
      _loadQuoteDetails();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Estado actualizado')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _deleteQuote() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content:
            const Text('¿Estás seguro de que deseas eliminar esta cotización?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await client.quote.deleteQuote(widget.quoteId);
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cotización eliminada')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  Future<void> _convertToSale() async {
    if (_quoteDetails == null) return;

    final quote = _quoteDetails!.quote;
    
    // Cargar la lista de clientes disponibles
    List<Customer> customers = [];
    try {
      customers = await client.catalogs.getCustomers();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error cargando clientes: $e')),
        );
      }
      return;
    }

    // Cargar versiones de la cotización
    List<QuoteVersion> versions = [];
    try {
      versions = await client.quoteVersion.getQuoteVersions(widget.quoteId);
    } catch (e) {
      debugPrint('Error loading versions: $e');
    }

    final customerNameController = TextEditingController(text: quote.name);
    final notesController = TextEditingController();
    DateTime? scheduledDate;
    int? selectedCustomerId = quote.customerId;
    int? selectedVersionId;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            // Buscar la versión seleccionada
            QuoteVersion? selectedVersion;
            if (selectedVersionId != null) {
              try {
                selectedVersion = versions.firstWhere((v) => v.id == selectedVersionId);
              } catch (e) {
                selectedVersion = null;
              }
            }

            return AlertDialog(
              title: const Text('Convertir a Venta'),
              content: SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mostrar imagen si existe
                      if (quote.imageUrl != null) ...[
                        Container(
                          constraints: const BoxConstraints(maxHeight: 200),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.memory(
                              base64Decode(quote.imageUrl!),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  color: Colors.grey[200],
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error_outline, color: Colors.red, size: 16),
                                      SizedBox(width: 8),
                                      Text('Error al cargar imagen', style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      
                      // Información de precio
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
                        ),
                        child: Column(
                          children: [
                            if (quote.quantity > 1) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Precio por pieza:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '\$${(selectedVersion?.total ?? quote.total / quote.quantity).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Divider(height: 8),
                              const SizedBox(height: 4),
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  quote.quantity > 1 ? 'Total (${quote.quantity} piezas):' : 'Total:',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${(selectedVersion?.total ?? quote.total).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Selector de Cliente
                      const Text(
                        'Cliente',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int?>(
                        value: selectedCustomerId,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Seleccionar cliente',
                          prefixIcon: Icon(Icons.person),
                        ),
                        items: customers.map((customer) {
                          return DropdownMenuItem<int?>(
                            value: customer.id,
                            child: Text(customer.apodo),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setDialogState(() {
                            selectedCustomerId = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Nombre personalizado del cliente (opcional)
                      TextField(
                        controller: customerNameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre para la venta (opcional)',
                          hintText: 'Ej: Juan Pérez - Lote A',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.edit),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Selector de Versión (si hay versiones disponibles)
                      if (versions.isNotEmpty) ...[
                        const Text(
                          'Versión de Cotización',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<int?>(
                          value: selectedVersionId,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Usar cotización original',
                            prefixIcon: Icon(Icons.layers),
                          ),
                          items: [
                            const DropdownMenuItem<int?>(
                              value: null,
                              child: Text('Cotización Original'),
                            ),
                            ...versions.map((version) {
                              return DropdownMenuItem<int?>(
                                value: version.id,
                                child: Text(
                                  version.versionName != null
                                      ? '${version.versionName} (v${version.versionNumber})${version.isPrimary ? ' ⭐' : ''}'
                                      : 'Versión ${version.versionNumber}${version.isPrimary ? ' ⭐' : ''}',
                                ),
                              );
                            }).toList(),
                          ],
                          onChanged: (value) {
                            setDialogState(() {
                              selectedVersionId = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                      
                      // Notas
                      TextField(
                        controller: notesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Notas',
                          hintText: 'Información adicional para esta venta...',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.notes),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Programar Entrega
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Programar Entrega'),
                        subtitle: Text(
                          scheduledDate != null
                              ? 'Fecha: ${scheduledDate!.day}/${scheduledDate!.month}/${scheduledDate!.year}'
                              : 'Sin fecha programada',
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            setDialogState(() {
                              scheduledDate = date;
                            });
                          }
                        },
                      ),
                      
                      // Información de la versión seleccionada
                      if (selectedVersion != null) ...[
                        const Divider(),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.withOpacity(0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Detalles de la Versión',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Peso: ${selectedVersion.pieceWeightGrams}g'),
                              Text('Horas de impresión: ${selectedVersion.printHours}hrs'),
                              Text('Cantidad: ${selectedVersion.quantity}'),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: selectedCustomerId == null
                      ? null
                      : () => Navigator.pop(context, true),
                  child: const Text('Crear Venta'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == true) {
      try {
        final sale = await client.sales.convertQuoteToSale(
          widget.quoteId,
          quoteVersionId: selectedVersionId,
          customerId: selectedCustomerId,
          customerName: customerNameController.text.isEmpty
              ? null
              : customerNameController.text,
          scheduledDeliveryDate: scheduledDate,
          notes: notesController.text.isEmpty ? null : notesController.text,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Venta creada exitosamente')),
          );
          
          // Navigate to sale details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SaleDetailsScreen(saleId: sale.id!),
            ),
          );

          _loadSales();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ Error: $e')),
          );
        }
      }
    }
  }

  Future<void> _generatePdf() async {
    if (_quoteDetails == null) return;

    final quote = _quoteDetails!.quote;
    final filaments = _quoteDetails!.filamentDetails ?? [];
    final supplies = _quoteDetails!.supplyDetails ?? [];
    final customer = _quoteDetails!.customer;
    final printer = _quoteDetails!.printer;
    final shipping = _quoteDetails!.shipping;

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          // Header
          pw.Header(
            level: 0,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'COTIZACIÓN #${widget.quoteId}',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.teal,
                  ),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: pw.BoxDecoration(
                    color: _getPdfStatusColor(quote.status),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text(
                    _getStatusText(quote.status),
                    style: const pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Nombre del proyecto
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(4),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Nombre del Proyecto',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  quote.name,
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Total
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: PdfColors.teal50,
              borderRadius: pw.BorderRadius.circular(4),
            ),
            child: pw.Column(
              children: [
                if (quote.quantity > 1) ...[
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Precio por pieza',
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        '\$${(quote.total / quote.quantity).toStringAsFixed(2)}',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.teal700,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Divider(color: PdfColors.teal200),
                  pw.SizedBox(height: 8),
                ],
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      quote.quantity > 1 ? 'TOTAL (${quote.quantity} piezas)' : 'TOTAL',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '\$${quote.total.toStringAsFixed(2)}',
                      style: pw.TextStyle(
                        fontSize: 28,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.teal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Detalles de impresión
          _buildPdfSection('Detalles de Impresión', [
            _buildPdfRow('Cantidad', '${quote.quantity} ${quote.quantity == 1 ? 'pieza' : 'piezas'}'),
            if (customer != null) ...[
              _buildPdfRow('Cliente', customer.apodo),
              if (customer.nombre != null || customer.apellido != null)
                _buildPdfRow(
                  'Nombre completo',
                  [customer.nombre, customer.apellido]
                      .where((e) => e != null && e.isNotEmpty)
                      .join(' '),
                ),
              if (customer.numero != null)
                _buildPdfRow('Teléfono', customer.numero!),
              if (customer.direccion != null)
                _buildPdfRow('Dirección', customer.direccion!),
              pw.Divider(),
            ],
            _buildPdfRow('Gramos', '${quote.pieceWeightGrams}g'),
            _buildPdfRow('Horas de impresión', '${quote.printHours}hrs'),
            if (quote.measurements != null)
              _buildPdfRow('Medidas', quote.measurements!),
            if (printer != null)
              _buildPdfRow('Impresora', printer.name),
          ]),

          // Filamentos
          if (filaments.isNotEmpty) ...[
            pw.SizedBox(height: 16),
            _buildPdfSection(
              'Filamentos Utilizados',
              filaments.map((detail) {
                return _buildPdfRow(
                  '${detail.filament.name} (${detail.filament.brand})',
                  '${detail.gramsUsed}g - \$${detail.cost.toStringAsFixed(2)}',
                );
              }).toList(),
            ),
          ],

          // Insumos
          if (supplies.isNotEmpty) ...[
            pw.SizedBox(height: 16),
            _buildPdfSection(
              'Insumos Extra',
              supplies.map((detail) {
                return _buildPdfRow(
                  detail.supply.name,
                  '${detail.quantity} x \$${detail.cost.toStringAsFixed(2)}',
                );
              }).toList(),
            ),
          ],

          // Desglose de costos
          pw.SizedBox(height: 16),
          _buildPdfSection('Desglose de Costos', [
            _buildPdfRow(
              'Filamento',
              '\$${quote.filamentCost.toStringAsFixed(2)}',
            ),
            _buildPdfRow(
              'Electricidad',
              '\$${quote.electricityCost.toStringAsFixed(2)}',
            ),
            _buildPdfRow(
              'Insumos',
              '\$${quote.suppliesCost.toStringAsFixed(2)}',
            ),
            if (quote.postProcessingCost != null)
              _buildPdfRow(
                'Post-procesado',
                '\$${quote.postProcessingCost!.toStringAsFixed(2)}',
              ),
            pw.Divider(),
            _buildPdfRow(
              'Subtotal',
              '\$${quote.subtotal.toStringAsFixed(2)}',
              bold: true,
            ),
            _buildPdfRow(
              'Margen (${(quote.marginPercent * 100).toStringAsFixed(0)}%)',
              '\$${(quote.subtotal * quote.marginPercent).toStringAsFixed(2)}',
            ),
            if (shipping != null)
              _buildPdfRow(
                'Envío (${shipping.shippingType})',
                '\$${quote.shippingCost!.toStringAsFixed(2)}',
              ),
          ]),

          // Imagen si existe
          if (quote.imageUrl != null) ...[
            pw.SizedBox(height: 20),
            pw.Text(
              'Imagen del Proyecto',
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Container(
              constraints: const pw.BoxConstraints(maxHeight: 300),
              child: pw.Image(
                pw.MemoryImage(base64Decode(quote.imageUrl!)),
                fit: pw.BoxFit.contain,
              ),
            ),
          ],
        ],
      ),
    );

    // Mostrar el PDF
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'cotizacion_${widget.quoteId}_${quote.name.replaceAll(' ', '_')}.pdf',
    );
  }

  PdfColor _getPdfStatusColor(QuoteStatus status) {
    switch (status) {
      case QuoteStatus.PENDIENTE:
        return PdfColors.orange;
      case QuoteStatus.PROCESO:
        return PdfColors.blue;
      case QuoteStatus.FINALIZADO:
        return PdfColors.green;
      case QuoteStatus.CANCELADO:
        return PdfColors.red;
    }
  }

  pw.Widget _buildPdfSection(String title, List<pw.Widget> children) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  pw.Widget _buildPdfRow(String label, String value, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(
            child: pw.Text(
              label,
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey700,
                fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
              ),
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotización #${widget.quoteId}'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Versiones',
            onPressed: _quoteDetails == null
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuoteVersionsScreen(
                          quoteId: widget.quoteId,
                          quoteName: _quoteDetails!.quote.name,
                        ),
                      ),
                    );
                  },
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Generar PDF',
            onPressed: _quoteDetails == null ? null : _generatePdf,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _quoteDetails == null
                ? null
                : () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuoteFormScreen(
                          quoteId: widget.quoteId,
                        ),
                      ),
                    );
                    _loadQuoteDetails();
                  },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteQuote,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _quoteDetails != null
          ? FloatingActionButton.extended(
              onPressed: _convertToSale,
              backgroundColor: Colors.deepPurple,
              icon: const Icon(Icons.add_shopping_cart),
              label: Text(_sales != null && _sales!.isNotEmpty ? 'Nueva Venta' : 'Crear Venta'),
            )
          : null,
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadQuoteDetails,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (_quoteDetails == null) {
      return const Center(child: Text('No se encontró la cotización'));
    }

    final quote = _quoteDetails!.quote;
    final filaments = _quoteDetails!.filamentDetails ?? [];
    final supplies = _quoteDetails!.supplyDetails ?? [];
    final customer = _quoteDetails!.customer;
    final printer = _quoteDetails!.printer;
    final shipping = _quoteDetails!.shipping;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Card
          Card(
            color: _getStatusColor(quote.status).withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estado: ${_getStatusText(quote.status)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getStatusColor(quote.status),
                    ),
                  ),
                  PopupMenuButton<QuoteStatus>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: _updateStatus,
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: QuoteStatus.PENDIENTE,
                        child: Text('Pendiente'),
                      ),
                      const PopupMenuItem(
                        value: QuoteStatus.PROCESO,
                        child: Text('En Proceso'),
                      ),
                      const PopupMenuItem(
                        value: QuoteStatus.FINALIZADO,
                        child: Text('Finalizado'),
                      ),
                      const PopupMenuItem(
                        value: QuoteStatus.CANCELADO,
                        child: Text('Cancelado'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Nombre Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.label, color: Colors.teal),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nombre',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          quote.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Total Card
          Card(
            color: Colors.teal.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (quote.quantity > 1) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Precio por pieza',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${(quote.total / quote.quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        quote.quantity > 1 ? 'TOTAL (${quote.quantity} piezas)' : 'TOTAL',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${quote.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Print Details
          _buildSection(
            'Detalles de Impresión',
            [
              _buildDetailRow('Cantidad', '${quote.quantity} ${quote.quantity == 1 ? 'pieza' : 'piezas'}'),
              if (customer != null) ...[
                _buildDetailRow('Cliente', customer.apodo),
                if (customer.nombre != null || customer.apellido != null)
                  _buildDetailRow(
                    'Nombre completo',
                    [customer.nombre, customer.apellido]
                        .where((e) => e != null && e.isNotEmpty)
                        .join(' '),
                  ),
                if (customer.numero != null)
                  _buildDetailRow('Teléfono', customer.numero!),
                if (customer.direccion != null)
                  _buildDetailRow('Dirección', customer.direccion!),
                const Divider(),
              ],
              _buildDetailRow('Gramos', '${quote.pieceWeightGrams}g'),
              _buildDetailRow('Horas de impresión', '${quote.printHours}hrs'),
              if (quote.measurements != null)
                _buildDetailRow('Medidas', quote.measurements!),
              if (printer != null) _buildDetailRow('Impresora', printer.name),
            ],
          ),

          // Filaments
          if (filaments.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildSection(
              'Filamentos Utilizados',
              filaments.map((detail) {
                return _buildDetailRow(
                  '${detail.filament.name} (${detail.filament.brand})',
                  '${detail.gramsUsed}g - \$${detail.cost.toStringAsFixed(2)}',
                );
              }).toList(),
            ),
          ],

          // Supplies
          if (supplies.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildSection(
              'Insumos Extra',
              supplies.map((detail) {
                return _buildDetailRow(
                  detail.supply.name,
                  '${detail.quantity} x \$${detail.cost.toStringAsFixed(2)}',
                );
              }).toList(),
            ),
          ],

          // Costs Breakdown
          const SizedBox(height: 16),
          _buildSection(
            'Desglose de Costos',
            [
              _buildDetailRow(
                'Filamento',
                '\$${quote.filamentCost.toStringAsFixed(2)}',
              ),
              _buildDetailRow(
                'Electricidad',
                '\$${quote.electricityCost.toStringAsFixed(2)}',
              ),
              _buildDetailRow(
                'Insumos',
                '\$${quote.suppliesCost.toStringAsFixed(2)}',
              ),
              if (quote.postProcessingCost != null)
                _buildDetailRow(
                  'Post-procesado',
                  '\$${quote.postProcessingCost!.toStringAsFixed(2)}',
                ),
              const Divider(),
              _buildDetailRow(
                'Subtotal',
                '\$${quote.subtotal.toStringAsFixed(2)}',
                bold: true,
              ),
              _buildDetailRow(
                'Margen (${(quote.marginPercent * 100).toStringAsFixed(0)}%)',
                '\$${(quote.subtotal * quote.marginPercent).toStringAsFixed(2)}',
              ),
              if (shipping != null)
                _buildDetailRow(
                  'Envío (${shipping.shippingType})',
                  '\$${quote.shippingCost!.toStringAsFixed(2)}',
                ),
            ],
          ),

          // Sales Section
          if (_sales != null && _sales!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Card(
              color: Colors.deepPurple.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.shopping_cart, color: Colors.deepPurple),
                        const SizedBox(width: 8),
                        Text(
                          'Ventas Realizadas (${_sales!.length})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    ..._sales!.map((sale) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _getSaleStatusColor(sale.saleStatus),
                            child: Text(
                              '#${sale.id}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          title: Text(
                            sale.customerName ?? 'Sin cliente',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text('Total: \$${sale.totalAmount.toStringAsFixed(2)}'),
                              Text(
                                _getSaleStatusLabel(sale.saleStatus),
                                style: TextStyle(
                                  color: _getSaleStatusColor(sale.saleStatus),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SaleDetailsScreen(saleId: sale.id!),
                              ),
                            );
                            _loadSales();
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],

          if (quote.imageUrl != null) ...[
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Imagen',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        base64Decode(quote.imageUrl!),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            color: Colors.grey[200],
                            child: const Row(
                              children: [
                                Icon(Icons.error_outline, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Error al cargar imagen'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getSaleStatusLabel(SaleStatus status) {
    switch (status) {
      case SaleStatus.IMPRIMIENDO:
        return 'IMPRIMIENDO';
      case SaleStatus.PENDIENTE_ENTREGA:
        return 'PENDIENTE ENTREGA';
      case SaleStatus.ENTREGADO:
        return 'ENTREGADO';
      case SaleStatus.CANCELADO:
        return 'CANCELADO';
    }
  }

  Color _getSaleStatusColor(SaleStatus status) {
    switch (status) {
      case SaleStatus.IMPRIMIENDO:
        return Colors.blue;
      case SaleStatus.PENDIENTE_ENTREGA:
        return Colors.orange;
      case SaleStatus.ENTREGADO:
        return Colors.green;
      case SaleStatus.CANCELADO:
        return Colors.red;
    }
  }
}
