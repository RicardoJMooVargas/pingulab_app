import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:pingulab_app_client/pingulab_app_client.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/create_quote_req.module.dart';
import '../services/auth_service.dart';

class QuoteFormScreen extends StatefulWidget {
  final int? quoteId;

  const QuoteFormScreen({super.key, this.quoteId});

  @override
  State<QuoteFormScreen> createState() => _QuoteFormScreenState();
}

class _QuoteFormScreenState extends State<QuoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isLoadingData = true;

  // Controllers
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _pieceWeightGramsController = TextEditingController();
  final _printHoursController = TextEditingController();
  final _printHoursOnlyController = TextEditingController();
  final _printMinutesController = TextEditingController();
  final _postProcessingCostController = TextEditingController();
  final _measurementsController = TextEditingController();
  final _marginPercentController = TextEditingController(text: '0.30');

  // Time input mode
  bool _useHoursMinutesFormat = false;

  // Imagen
  Uint8List? _selectedImage;

  int? _selectedCustomerId;
  String? _selectedCustomerName;
  int? _selectedPrinterId;
  int? _selectedShippingId;
  int? _selectedCategoryId;
  QuoteStatus _selectedStatus = QuoteStatus.PENDIENTE;

  // Data
  List<Printer>? _printers;
  List<Filament>? _filaments;
  List<FilamentCatalogItem>? _filamentCatalogItems;
  List<ExtraSupply>? _supplies;
  List<Shipping>? _shippings;
  List<QuoteCategory>? _categories;

  // Selected
  final Map<int, double> _selectedFilaments = {};
  final Map<int, int> _selectedSupplies = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final printers = await client.resources.getAllPrinters();
      final filaments = await client.resources.getAllFilaments();
      final filamentCatalogItems =
          await client.resources.getFilamentCatalogItems(onlyActive: true);
      final supplies = await client.resources.getAllExtraSupplies();
      final shippings = await client.resources.getAllShippings();
      final categories = await client.resources.getActiveQuoteCategories();

      setState(() {
        _printers = printers;
        _filaments = filaments;
        _filamentCatalogItems = filamentCatalogItems;
        _supplies = supplies;
        _shippings = shippings;
        _categories = categories;
        _shippings = shippings;
        _isLoadingData = false;
      });

      if (widget.quoteId != null) {
        await _loadQuoteData();
      }
    } catch (e) {
      setState(() => _isLoadingData = false);
    }
  }

  Future<void> _loadQuoteData() async {
    final details = await client.quote.getQuoteDetails(widget.quoteId!);
    if (details == null) return;

    final quote = details.quote;

    setState(() {
      _nameController.text = quote.name;
      _quantityController.text = quote.quantity.toString();
      _pieceWeightGramsController.text = quote.pieceWeightGrams.toString();
      _printHoursController.text = quote.printHours.toString();

      // Initialize hours/minutes from decimal
      final totalHours = quote.printHours;
      final hours = totalHours.floor();
      final minutes = ((totalHours - hours) * 60).round();
      _printHoursOnlyController.text = hours.toString();
      _printMinutesController.text = minutes.toString();

      _postProcessingCostController.text =
          quote.postProcessingCost?.toString() ?? '';
      _measurementsController.text = quote.measurements ?? '';
      _marginPercentController.text = quote.marginPercent.toString();
      _selectedCustomerId = quote.customerId;
      if (details.customer != null) {
        _selectedCustomerName = details.customer!.apodo;
      }
      _selectedPrinterId = quote.printerId;
      _selectedShippingId = quote.shippingId;
      _selectedCategoryId = quote.categoryId;
      _selectedStatus = quote.status;

      // Cargar imagen existente
      if (quote.imageUrl != null) {
        try {
          _selectedImage = base64Decode(quote.imageUrl!);
          debugPrint(
              '✅ Imagen cargada desde la cotización: ${(_selectedImage!.length / 1024).toStringAsFixed(2)} KB');
        } catch (e) {
          debugPrint('❌ Error al decodificar imagen: $e');
        }
      }

      if (details.filamentDetails != null) {
        for (var d in details.filamentDetails!) {
          _selectedFilaments[d.filament.id!] = d.gramsUsed;
        }
      }

      if (details.supplyDetails != null) {
        for (var d in details.supplyDetails!) {
          _selectedSupplies[d.supply.id!] = d.quantity;
        }
      }
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();

      // Mostrar tamaño original
      debugPrint(
          '📸 Imagen original: ${bytes.length} bytes (${(bytes.length / 1024).toStringAsFixed(2)} KB)');

      // Comprimir la imagen para que no exceda el límite del servidor (512 KB)
      final compressedBytes = await _compressImage(bytes);

      // Mostrar tamaño comprimido
      debugPrint(
          '✅ Imagen comprimida: ${compressedBytes.length} bytes (${(compressedBytes.length / 1024).toStringAsFixed(2)} KB)');

      _selectedImage = compressedBytes;
      setState(() {});

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Imagen cargada: ${(compressedBytes.length / 1024).toStringAsFixed(0)} KB'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  /// Convert hours and minutes to decimal hours
  double _getDecimalHours() {
    if (_useHoursMinutesFormat) {
      final hours = int.tryParse(_printHoursOnlyController.text) ?? 0;
      final minutes = int.tryParse(_printMinutesController.text) ?? 0;
      return hours + (minutes / 60.0);
    } else {
      return double.tryParse(_printHoursController.text) ?? 0.0;
    }
  }

  /// Update controllers when switching between input modes
  void _toggleTimeInputMode() {
    setState(() {
      if (_useHoursMinutesFormat) {
        // Switching from hours/minutes to decimal
        final decimalHours = _getDecimalHours();
        _printHoursController.text = decimalHours.toStringAsFixed(2);
        _useHoursMinutesFormat = false;
      } else {
        // Switching from decimal to hours/minutes
        final decimalHours = double.tryParse(_printHoursController.text) ?? 0.0;
        final hours = decimalHours.floor();
        final minutes = ((decimalHours - hours) * 60).round();
        _printHoursOnlyController.text = hours.toString();
        _printMinutesController.text = minutes.toString();
        _useHoursMinutesFormat = true;
      }
    });
  }

  /// Update decimal display when hours or minutes change
  void _updateDecimalFromHoursMinutes() {
    setState(() {});
  }

  /// Format decimal hours to "Xh Ymin" string
  String _formatDecimalToHoursMinutes(double decimalHours) {
    final hours = decimalHours.floor();
    final minutes = ((decimalHours - hours) * 60).round();
    return '≈ ${hours}h ${minutes}min';
  }

  Future<Uint8List> _compressImage(Uint8List bytes) async {
    try {
      // Decodificar la imagen
      img.Image? image = img.decodeImage(bytes);
      if (image == null) {
        debugPrint('⚠️ No se pudo decodificar la imagen');
        return bytes;
      }

      debugPrint('📐 Dimensiones originales: ${image.width}x${image.height}');

      // Calcular el tamaño máximo permitido (400 KB para mayor margen)
      const int maxSizeBytes = 400 * 1024;

      // Si la imagen ya es pequeña, devolverla sin comprimir
      if (bytes.length <= maxSizeBytes) {
        debugPrint('✓ Imagen ya es pequeña, no se comprime');
        return bytes;
      }

      // Redimensionar la imagen si es muy grande
      // Empezar con 1600px para reducir más el tamaño
      int maxDimension = 1600;
      if (image.width > maxDimension || image.height > maxDimension) {
        if (image.width > image.height) {
          image = img.copyResize(image, width: maxDimension);
        } else {
          image = img.copyResize(image, height: maxDimension);
        }
        debugPrint('📐 Redimensionada a: ${image.width}x${image.height}');
      }

      // Comprimir la imagen con calidad decreciente hasta alcanzar el tamaño deseado
      int quality = 80;
      Uint8List? compressed;

      while (quality > 5) {
        compressed = Uint8List.fromList(
          img.encodeJpg(image, quality: quality),
        );

        debugPrint(
            '🔄 Calidad $quality%: ${compressed.length} bytes (${(compressed.length / 1024).toStringAsFixed(2)} KB)');

        if (compressed.length <= maxSizeBytes || quality <= 10) {
          break;
        }

        quality -= 10;
      }

      return compressed ?? bytes;
    } catch (e) {
      debugPrint('❌ Error al comprimir imagen: $e');
      return bytes;
    }
  }

  Future<void> _saveQuote() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedFilaments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona al menos un filamento')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = context.read<AuthService>();
      final userId = authService.userId;

      if (userId == null) {
        throw Exception('No hay usuario autenticado');
      }

      final model = CreateQuoteReqModel(
        name: _nameController.text,
        quantity: int.parse(_quantityController.text),
        pieceWeightGrams: double.parse(_pieceWeightGramsController.text),
        printHours: _getDecimalHours(),
        postProcessingCost: _postProcessingCostController.text.isEmpty
            ? null
            : double.parse(_postProcessingCostController.text),
        measurements: _measurementsController.text.isEmpty
            ? null
            : _measurementsController.text,
        marginPercent: double.parse(_marginPercentController.text),
        customerId: _selectedCustomerId,
        printerId: _selectedPrinterId,
        shippingId: _selectedShippingId,
        categoryId: _selectedCategoryId,
        status: _selectedStatus,
        imageBytes: _selectedImage,
        filamentUsages: _selectedFilaments,
        supplyUsages: _selectedSupplies,
      );

      // Convertir imagen a base64 si existe
      String? imageBase64;
      if (_selectedImage != null) {
        imageBase64 = base64Encode(_selectedImage!);
      }

      final input = await model.toQuoteInput(imageBase64: imageBase64);

      if (widget.quoteId == null) {
        await client.quote.createQuote(input, userId: userId);
      } else {
        await client.quote.updateQuote(widget.quoteId!, input, userId: userId);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.quoteId == null
                ? 'Cotización creada'
                : 'Cotización actualizada'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  double _estimatedRequiredFilamentGrams() {
    final gramsPerPiece =
        double.tryParse(_pieceWeightGramsController.text) ?? 0;
    final quantity = int.tryParse(_quantityController.text) ?? 1;
    return (gramsPerPiece * quantity).clamp(0, double.infinity).toDouble();
  }

  String _selectionReasonLabel(String reason) {
    switch (reason) {
      case 'preferred':
        return 'Preferido por el usuario';
      case 'most_available_with_stock':
        return 'Mayor stock suficiente';
      case 'most_available_same_catalog':
        return 'Mayor stock por material/color';
      case 'last_used_same_catalog':
        return 'Ultimo rollo usado';
      case 'same_color_fallback':
        return 'Fallback por mismo color';
      default:
        return 'Sin sugerencia exacta';
    }
  }

  Future<void> _showSuggestFilamentDialog() async {
    final catalogItems = _filamentCatalogItems ?? [];
    if (catalogItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay catalogo de filamentos activo')),
      );
      return;
    }

    int? selectedCatalogId = catalogItems.first.id;
    final gramsController = TextEditingController();
    final estimated = _estimatedRequiredFilamentGrams();
    if (estimated > 0) {
      gramsController.text = estimated.toStringAsFixed(0);
    }

    bool isSuggesting = false;
    Map<String, dynamic>? suggestion;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          final selectedCatalog = catalogItems
              .where((c) => c.id == selectedCatalogId)
              .cast<FilamentCatalogItem?>()
              .firstWhere((c) => c != null, orElse: () => null);

          final requiredGrams = double.tryParse(gramsController.text);
          final selectedFilamentId = suggestion?['selectedFilamentId'] as int?;
          final selectionReason = suggestion?['selectionReason'] as String?;
          final hasAvailableStock = suggestion?['hasAvailableStock'] as bool?;
          final selectedRemaining =
              (suggestion?['selectedRemainingGrams'] as num?)?.toDouble();

          final selectedFilament = selectedFilamentId == null
              ? null
              : _filaments?.where((f) => f.id == selectedFilamentId).firstWhere(
                    (_) => true,
                    orElse: () => Filament(
                      id: selectedFilamentId,
                      name: 'Filamento #$selectedFilamentId',
                      brand: '-',
                      materialType: selectedCatalog?.materialType ?? '-',
                      color: selectedCatalog?.color ?? '-',
                      spoolWeightKg: 0,
                      spoolCost: 0,
                      remainingGrams: selectedRemaining ?? 0,
                    ),
                  );

          return AlertDialog(
            title: const Text('Sugerir filamento automaticamente'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<int>(
                    value: selectedCatalogId,
                    decoration: const InputDecoration(
                      labelText: 'Catalogo (material + color)',
                      border: OutlineInputBorder(),
                    ),
                    items: catalogItems
                        .where((c) => c.id != null)
                        .map(
                          (c) => DropdownMenuItem<int>(
                            value: c.id,
                            child: Text('${c.materialType} - ${c.color}'),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setDialogState(() {
                        selectedCatalogId = value;
                        suggestion = null;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: gramsController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Gramos requeridos',
                      border: const OutlineInputBorder(),
                      suffixText: 'g',
                      helperText: estimated > 0
                          ? 'Estimado automatico: ${estimated.toStringAsFixed(0)}g'
                          : null,
                    ),
                    onChanged: (_) => setDialogState(() {}),
                  ),
                  const SizedBox(height: 12),
                  if (selectedCatalog != null)
                    Text(
                      'Material: ${selectedCatalog.materialType} | Color: ${selectedCatalog.color}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  if (suggestion != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (hasAvailableStock ?? false)
                            ? Colors.green.withOpacity(0.08)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: (hasAvailableStock ?? false)
                              ? Colors.green.withOpacity(0.3)
                              : Colors.orange.withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedFilamentId == null
                                ? 'No se encontro un rollo sugerido'
                                : 'Sugerencia: ${selectedFilament?.name ?? 'Filamento #$selectedFilamentId'}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (selectedFilamentId != null)
                            Text('Marca: ${selectedFilament?.brand ?? '-'}'),
                          if (selectionReason != null)
                            Text(
                                'Motivo: ${_selectionReasonLabel(selectionReason)}'),
                          if (selectedRemaining != null)
                            Text(
                              'Stock actual: ${selectedRemaining.toStringAsFixed(1)}g',
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: isSuggesting
                    ? null
                    : () async {
                        if (selectedCatalog == null) {
                          return;
                        }

                        final gramsRequired =
                            double.tryParse(gramsController.text.trim());
                        if (gramsRequired == null || gramsRequired <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Ingresa gramos requeridos validos'),
                            ),
                          );
                          return;
                        }

                        setDialogState(() {
                          isSuggesting = true;
                        });

                        try {
                          final raw = await client.resources
                              .suggestFilamentForRequirement(
                            selectedCatalog.materialType,
                            selectedCatalog.color,
                            gramsRequired,
                          );

                          final decoded = jsonDecode(raw);
                          if (decoded is Map<String, dynamic>) {
                            setDialogState(() {
                              suggestion = decoded;
                            });
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error sugiriendo: $e')),
                            );
                          }
                        } finally {
                          setDialogState(() {
                            isSuggesting = false;
                          });
                        }
                      },
                child: Text(isSuggesting ? 'Analizando...' : 'Sugerir'),
              ),
              ElevatedButton(
                onPressed: selectedFilamentId == null || requiredGrams == null
                    ? null
                    : () {
                        setState(() {
                          _selectedFilaments[selectedFilamentId] =
                              requiredGrams;
                        });

                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Filamento sugerido agregado (${requiredGrams.toStringAsFixed(1)}g)',
                            ),
                          ),
                        );
                      },
                child: const Text('Usar sugerencia'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.quoteId == null ? 'Nueva Cotización' : 'Editar Cotización'),
        backgroundColor: Colors.teal,
      ),
      body: _isLoadingData
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _section('Información Básica'),

                  _field(_nameController, 'Nombre de la cotización *', true,
                      hint: 'Ej: Pieza para cliente X'),

                  _field(_quantityController, 'Cantidad *', true,
                      isNumeric: true, hint: 'Número de piezas'),

                  // Peso con conversión a kg
                  _field(_pieceWeightGramsController, 'Peso de la pieza', false,
                      isNumeric: true, suffix: 'g'),
                  if (_pieceWeightGramsController.text.isNotEmpty &&
                      double.tryParse(_pieceWeightGramsController.text) != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 12),
                      child: Text(
                        '≈ ${(double.parse(_pieceWeightGramsController.text) / 1000).toStringAsFixed(3)} kg',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),

                  // Print hours input with mode toggle
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Horas de impresión *',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Decimal',
                            style: TextStyle(
                              fontSize: 12,
                              color: !_useHoursMinutesFormat
                                  ? Colors.teal
                                  : Colors.grey,
                            ),
                          ),
                          Switch(
                            value: _useHoursMinutesFormat,
                            onChanged: (value) => _toggleTimeInputMode(),
                            activeColor: Colors.teal,
                          ),
                          Text(
                            'H:M',
                            style: TextStyle(
                              fontSize: 12,
                              color: _useHoursMinutesFormat
                                  ? Colors.teal
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  if (_useHoursMinutesFormat) ...[
                    // Hours and Minutes input
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _printHoursOnlyController,
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Requerido';
                              }
                              if (int.tryParse(v) == null) {
                                return 'Número inválido';
                              }
                              return null;
                            },
                            onChanged: (_) => _updateDecimalFromHoursMinutes(),
                            decoration: const InputDecoration(
                              labelText: 'Horas',
                              suffixText: 'h',
                              border: OutlineInputBorder(),
                              hintText: '0',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _printMinutesController,
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Requerido';
                              }
                              final minutes = int.tryParse(v);
                              if (minutes == null) {
                                return 'Número inválido';
                              }
                              if (minutes < 0 || minutes >= 60) {
                                return '0-59';
                              }
                              return null;
                            },
                            onChanged: (_) => _updateDecimalFromHoursMinutes(),
                            decoration: const InputDecoration(
                              labelText: 'Minutos',
                              suffixText: 'min',
                              border: OutlineInputBorder(),
                              hintText: '0',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 8, bottom: 12),
                      child: Text(
                        '≈ ${_getDecimalHours().toStringAsFixed(2)} horas',
                        style: TextStyle(
                          color: Colors.teal[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ] else ...[
                    // Decimal input
                    _field(_printHoursController, 'Horas', true,
                        isNumeric: true, suffix: 'hrs'),
                    if (_printHoursController.text.isNotEmpty &&
                        double.tryParse(_printHoursController.text) != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 12),
                        child: Text(
                          _formatDecimalToHoursMinutes(
                              double.parse(_printHoursController.text)),
                          style: TextStyle(
                            color: Colors.teal[700],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],

                  _field(_measurementsController, 'Medidas', false,
                      suffix: 'cm', hint: 'Ej: 10 x 20 x 5'),
                  _field(_postProcessingCostController,
                      'Costo de post-procesado', false,
                      isNumeric: true, suffix: '\$'),

                  const SizedBox(height: 12),

                  // Preview de imagen
                  if (_selectedImage != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                _selectedImage!,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton.icon(
                              onPressed: () =>
                                  setState(() => _selectedImage = null),
                              icon: const Icon(Icons.delete, size: 18),
                              label: const Text('Eliminar imagen'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: Text(_selectedImage == null
                        ? 'Seleccionar imagen'
                        : 'Cambiar imagen'),
                  ),

                  const SizedBox(height: 24),
                  _section('Cliente'),

                  // Customer search field
                  if (_selectedCustomerId != null &&
                      _selectedCustomerName != null) ...[
                    Card(
                      color: Colors.teal.withOpacity(0.1),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(_selectedCustomerName!),
                        trailing: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => setState(() {
                            _selectedCustomerId = null;
                            _selectedCustomerName = null;
                          }),
                        ),
                      ),
                    ),
                  ] else ...[
                    OutlinedButton.icon(
                      onPressed: _showCustomerSearchDialog,
                      icon: const Icon(Icons.search),
                      label: const Text('Buscar cliente'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),
                  _section('Impresora'),
                  DropdownButtonFormField<int>(
                    value: _selectedPrinterId,
                    decoration: const InputDecoration(
                      labelText: 'Seleccionar impresora',
                      border: OutlineInputBorder(),
                    ),
                    items: _printers
                            ?.map((p) => DropdownMenuItem(
                                  value: p.id,
                                  child: Text(p.name),
                                ))
                            .toList() ??
                        [],
                    onChanged: (v) => setState(() => _selectedPrinterId = v),
                  ),

                  const SizedBox(height: 24),
                  _section('Categoría'),
                  DropdownButtonFormField<int>(
                    value: _selectedCategoryId,
                    decoration: const InputDecoration(
                      labelText: 'Seleccionar categoría',
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Sin categoría'),
                    items: _categories
                            ?.map((c) => DropdownMenuItem(
                                  value: c.id,
                                  child: Row(
                                    children: [
                                      if (c.icon != null) ...[
                                        Text(c.icon!,
                                            style:
                                                const TextStyle(fontSize: 18)),
                                        const SizedBox(width: 8),
                                      ],
                                      Text(c.name),
                                    ],
                                  ),
                                ))
                            .toList() ??
                        [],
                    onChanged: (v) => setState(() => _selectedCategoryId = v),
                  ),

                  const SizedBox(height: 24),
                  _section('Filamentos'),
                  _filamentSection(),

                  const SizedBox(height: 24),
                  _section('Insumos'),
                  _supplySection(),

                  const SizedBox(height: 24),
                  _section('Envío y Estado'),
                  DropdownButtonFormField<int>(
                    value: _selectedShippingId,
                    decoration: const InputDecoration(
                      labelText: 'Envío',
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('Local - \$0.0'),
                    items: _shippings
                            ?.map((s) => DropdownMenuItem(
                                  value: s.id,
                                  child: Text(
                                      '${s.shippingType} - \$${s.cost.toStringAsFixed(2)}'),
                                ))
                            .toList() ??
                        [],
                    onChanged: (v) => setState(() => _selectedShippingId = v),
                  ),
                  const SizedBox(height: 12),
                  _field(_marginPercentController, 'Margen *', true,
                      isNumeric: true, hint: '0.30 = 30%'),
                  DropdownButtonFormField<QuoteStatus>(
                    value: _selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Estado',
                      border: OutlineInputBorder(),
                    ),
                    items: QuoteStatus.values
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s.name),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedStatus = v!),
                  ),

                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveQuote,
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _section(String t) => Text(t,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));

  Widget _field(TextEditingController c, String l, bool required,
      {bool isNumeric = false,
      String? suffix,
      String? hint,
      int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        maxLines: maxLines,
        keyboardType: isNumeric
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: (v) {
          if (required && (v == null || v.isEmpty)) {
            return 'Campo requerido';
          }
          if (isNumeric && v != null && v.isNotEmpty) {
            if (double.tryParse(v) == null) {
              return 'Ingrese un número válido';
            }
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: l,
          suffixText: suffix,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _filamentSection() => Column(
        children: [
          if ((_filamentCatalogItems ?? []).isNotEmpty) ...[
            OutlinedButton.icon(
              onPressed: _showSuggestFilamentDialog,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Sugerir filamento automaticamente'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 8),
          ],
          ..._selectedFilaments.entries.map((e) {
            final filament = _filaments?.firstWhere((f) => f.id == e.key);
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    '${e.value.toStringAsFixed(0)}g',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                title: Text(filament?.name ?? 'Filamento ID ${e.key}'),
                subtitle: Text(
                  '${e.value}g ≈ ${(e.value / 1000).toStringAsFixed(3)} kg',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      setState(() => _selectedFilaments.remove(e.key)),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _showAddFilamentDialog,
            icon: const Icon(Icons.add),
            label: const Text('Agregar filamento'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ],
      );

  Widget _supplySection() => Column(
        children: [
          ..._selectedSupplies.entries.map((e) {
            final supply = _supplies?.firstWhere((s) => s.id == e.key);
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    '${e.value}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(supply?.name ?? 'Insumo ID ${e.key}'),
                subtitle: Text(
                  'Cantidad: ${e.value}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      setState(() => _selectedSupplies.remove(e.key)),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _showAddSupplyDialog,
            icon: const Icon(Icons.add),
            label: const Text('Agregar insumo'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
          ),
        ],
      );

  // --- Diálogos (sin cambios de lógica) ---

  Future<void> _showAddFilamentDialog() async {
    int? id;
    final grams = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) {
          final selectedFilament =
              id != null ? _filaments?.firstWhere((f) => f.id == id) : null;
          final gramsValue = double.tryParse(grams.text);

          return AlertDialog(
            title: const Text('Agregar filamento'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Seleccionar filamento',
                      border: OutlineInputBorder(),
                    ),
                    items: _filaments
                            ?.where(
                                (f) => !_selectedFilaments.containsKey(f.id))
                            .map((f) => DropdownMenuItem(
                                  value: f.id,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: _parseColor(f.color),
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${f.name} (${f.brand})',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ))
                            .toList() ??
                        [],
                    onChanged: (v) => setDialogState(() => id = v),
                  ),
                  if (selectedFilament != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Info del rollo:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Peso: ${selectedFilament.spoolWeightKg} kg (${(selectedFilament.spoolWeightKg * 1000).toStringAsFixed(0)}g)',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                          ),
                          Text(
                            'Costo: \$${selectedFilament.spoolCost.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                          ),
                          Text(
                            'Stock restante: ${selectedFilament.remainingGrams.toStringAsFixed(1)}g',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  TextField(
                    controller: grams,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Gramos a usar',
                      suffixText: 'g',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: 150',
                    ),
                    onChanged: (_) => setDialogState(() {}),
                  ),
                  if (gramsValue != null && gramsValue > 0) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        '≈ ${(gramsValue / 1000).toStringAsFixed(3)} kg',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),
                    if (selectedFilament != null &&
                        gramsValue > selectedFilament.remainingGrams)
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 4),
                        child: Text(
                          'El consumo supera el stock actual; se autocorregira al vender.',
                          style: TextStyle(
                            color: Colors.orange[800],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (id != null && grams.text.isNotEmpty) {
                    final value = double.tryParse(grams.text);
                    if (value != null && value > 0) {
                      setState(() => _selectedFilaments[id!] = value);
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Agregar'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showAddSupplyDialog() async {
    int? id;
    final qty = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) {
          final selectedSupply =
              id != null ? _supplies?.firstWhere((s) => s.id == id) : null;

          return AlertDialog(
            title: const Text('Agregar insumo'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Seleccionar insumo',
                      border: OutlineInputBorder(),
                    ),
                    items: _supplies
                            ?.where((s) => !_selectedSupplies.containsKey(s.id))
                            .map((s) => DropdownMenuItem(
                                  value: s.id,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(s.name),
                                      Text(
                                        'Costo: \$${s.cost.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList() ??
                        [],
                    onChanged: (v) => setDialogState(() => id = v),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: qty,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Cantidad',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: 3',
                    ),
                    onChanged: (_) => setDialogState(() {}),
                  ),
                  if (selectedSupply != null && qty.text.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total:'),
                          Text(
                            '\$${(selectedSupply.cost * (int.tryParse(qty.text) ?? 0)).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (id != null && qty.text.isNotEmpty) {
                    final value = int.tryParse(qty.text);
                    if (value != null && value > 0) {
                      setState(() => _selectedSupplies[id!] = value);
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Agregar'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showCustomerSearchDialog() async {
    final searchController = TextEditingController();
    List<Customer> searchResults = [];
    bool isSearching = false;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Buscar cliente'),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: 'Buscar por apodo o nombre',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Escribe para buscar...',
                    ),
                    onChanged: (query) async {
                      if (query.length < 2) {
                        setDialogState(() {
                          searchResults = [];
                        });
                        return;
                      }

                      setDialogState(() => isSearching = true);

                      try {
                        final results =
                            await client.customer.searchCustomers(query);
                        setDialogState(() {
                          searchResults = results;
                          isSearching = false;
                        });
                      } catch (e) {
                        setDialogState(() => isSearching = false);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  if (isSearching)
                    const CircularProgressIndicator()
                  else if (searchResults.isEmpty &&
                      searchController.text.length >= 2)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No se encontraron clientes'),
                    )
                  else if (searchResults.isNotEmpty)
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final customer = searchResults[index];
                          final fullName = [
                            customer.nombre,
                            customer.apellido,
                          ].where((e) => e != null && e.isNotEmpty).join(' ');

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal,
                              child: Text(
                                customer.apodo[0].toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(customer.apodo),
                            subtitle: fullName.isNotEmpty
                                ? Text(fullName)
                                : (customer.numero != null
                                    ? Text(customer.numero!)
                                    : null),
                            onTap: () {
                              setState(() {
                                _selectedCustomerId = customer.id;
                                _selectedCustomerName = customer.apodo;
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Parse hex color string to Color object
  Color _parseColor(String hexColor) {
    try {
      String hex = hexColor.replaceAll('#', '');
      if (hex.length == 6) {
        hex = 'FF$hex'; // Add alpha if not present
      }
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return Colors.grey; // Default color if parsing fails
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _pieceWeightGramsController.dispose();
    _printHoursController.dispose();
    _printHoursOnlyController.dispose();
    _printMinutesController.dispose();
    _postProcessingCostController.dispose();
    _measurementsController.dispose();
    _marginPercentController.dispose();
    super.dispose();
  }
}
