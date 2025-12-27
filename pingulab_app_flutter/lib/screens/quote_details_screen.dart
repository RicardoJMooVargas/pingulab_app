import 'package:flutter/material.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import '../main.dart';
import 'quote_form_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _loadQuoteDetails();
  }

  Future<void> _loadQuoteDetails() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final details = await client.quote.getQuoteDetails(widget.quoteId);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotización #${widget.quoteId}'),
        backgroundColor: Colors.teal,
        actions: [
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

          // Total Card
          Card(
            color: Colors.teal.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOTAL',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            ),
          ),
          const SizedBox(height: 24),

          // Print Details
          _buildSection(
            'Detalles de Impresión',
            [
              _buildDetailRow('Gramos', '${quote.gramsPrinted}g'),
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
                    const SizedBox(height: 8),
                    Text(quote.imageUrl!),
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
}
