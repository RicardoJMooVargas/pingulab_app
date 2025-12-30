import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import '../main.dart';
import '../models/create_quote_req.module.dart';

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
  final _pieceWeightGramsController = TextEditingController();
  final _printHoursController = TextEditingController();
  final _postProcessingCostController = TextEditingController();
  final _measurementsController = TextEditingController();
  final _marginPercentController = TextEditingController(text: '0.30');

  // Imagen
  Uint8List? _selectedImage;

  int? _selectedCustomerId;
  String? _selectedCustomerName;
  int? _selectedPrinterId;
  int? _selectedShippingId;
  QuoteStatus _selectedStatus = QuoteStatus.PENDIENTE;

  // Data
  List<Printer>? _printers;
  List<Filament>? _filaments;
  List<ExtraSupply>? _supplies;
  List<Shipping>? _shippings;

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
      final supplies = await client.resources.getAllExtraSupplies();
      final shippings = await client.resources.getAllShippings();

      setState(() {
        _printers = printers;
        _filaments = filaments;
        _supplies = supplies;
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
      _pieceWeightGramsController.text = quote.pieceWeightGrams.toString();
      _printHoursController.text = quote.printHours.toString();
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
      _selectedStatus = quote.status;

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
      _selectedImage = await file.readAsBytes();
      setState(() {});
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
      final model = CreateQuoteReqModel(
        name: _nameController.text,
        pieceWeightGrams: double.parse(_pieceWeightGramsController.text),
        printHours: double.parse(_printHoursController.text),
        postProcessingCost: _postProcessingCostController.text.isEmpty
            ? null
            : double.parse(_postProcessingCostController.text),
        measurements:
            _measurementsController.text.isEmpty ? null : _measurementsController.text,
        marginPercent: double.parse(_marginPercentController.text),
        customerId: _selectedCustomerId,
        printerId: _selectedPrinterId,
        shippingId: _selectedShippingId,
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
        await client.quote.createQuote(input);
      } else {
        await client.quote.updateQuote(widget.quoteId!, input);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.quoteId == null ? 'Nueva Cotización' : 'Editar Cotización'),
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
                  
                  _field(_printHoursController, 'Horas de impresión *', true,
                      isNumeric: true, suffix: 'hrs'),
                  _field(_measurementsController, 'Medidas', false,
                      suffix: 'cm', hint: 'Ej: 10 x 20 x 5'),
                  _field(_postProcessingCostController, 'Costo de post-procesado', false,
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
                              onPressed: () => setState(() => _selectedImage = null),
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
                    label: Text(
                        _selectedImage == null ? 'Seleccionar imagen' : 'Cambiar imagen'),
                  ),

                  const SizedBox(height: 24),
                  _section('Cliente'),
                  
                  // Customer search field
                  if (_selectedCustomerId != null && _selectedCustomerName != null) ...[
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
                                  child: Text('${s.shippingType} - \$${s.cost.toStringAsFixed(2)}'),
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

  Widget _section(String t) =>
      Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));

  Widget _field(
      TextEditingController c, String l, bool required,
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
                            ?.where((f) => !_selectedFilaments.containsKey(f.id))
                            .map((f) => DropdownMenuItem(
                                  value: f.id,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(f.name),
                                      Text(
                                        '${f.brand} - ${f.materialType}',
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
                            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                          ),
                          Text(
                            'Costo: \$${selectedFilament.spoolCost.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  const SizedBox(height: 16),
                  TextField(
                    controller: grams,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        final results = await client.customer.searchCustomers(query);
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
                  else if (searchResults.isEmpty && searchController.text.length >= 2)
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

  @override
  void dispose() {
    _nameController.dispose();
    _pieceWeightGramsController.dispose();
    _printHoursController.dispose();
    _postProcessingCostController.dispose();
    _measurementsController.dispose();
    _marginPercentController.dispose();
    super.dispose();
  }
}
