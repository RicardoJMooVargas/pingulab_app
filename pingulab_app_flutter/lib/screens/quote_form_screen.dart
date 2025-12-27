import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import '../main.dart';

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

  // Form fields
  final _gramsPrintedController = TextEditingController();
  final _printHoursController = TextEditingController();
  final _postProcessingCostController = TextEditingController();
  final _measurementsController = TextEditingController();
  final _marginPercentController = TextEditingController(text: '0.30');
  final _imageUrlController = TextEditingController();

  int? _selectedPrinterId;
  int? _selectedShippingId;
  QuoteStatus _selectedStatus = QuoteStatus.PENDIENTE;

  // Available options
  List<Printer>? _printers;
  List<Filament>? _filaments;
  List<ExtraSupply>? _supplies;
  List<Shipping>? _shippings;

  // Selected items
  final Map<int, double> _selectedFilaments = {}; // filamentId -> grams
  final Map<int, int> _selectedSupplies = {}; // supplyId -> quantity

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoadingData = true);

    try {
      // Load all available options from database
      final printers = await _loadPrinters();
      final filaments = await _loadFilaments();
      final supplies = await _loadSupplies();
      final shippings = await _loadShippings();

      setState(() {
        _printers = printers;
        _filaments = filaments;
        _supplies = supplies;
        _shippings = shippings;
        _isLoadingData = false;
      });

      // If editing, load quote data
      if (widget.quoteId != null) {
        await _loadQuoteData();
      }
    } catch (e) {
      setState(() => _isLoadingData = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error cargando datos: $e')),
        );
      }
    }
  }

  Future<List<Printer>> _loadPrinters() async {
    try {
      return await client.resources.getAllPrinters();
    } catch (e) {
      print('Error loading printers: $e');
      return [];
    }
  }

  Future<List<Filament>> _loadFilaments() async {
    try {
      return await client.resources.getAllFilaments();
    } catch (e) {
      print('Error loading filaments: $e');
      return [];
    }
  }

  Future<List<ExtraSupply>> _loadSupplies() async {
    try {
      return await client.resources.getAllExtraSupplies();
    } catch (e) {
      print('Error loading supplies: $e');
      return [];
    }
  }

  Future<List<Shipping>> _loadShippings() async {
    try {
      return await client.resources.getAllShippings();
    } catch (e) {
      print('Error loading shippings: $e');
      return [];
    }
  }

  Future<void> _loadQuoteData() async {
    // Load existing quote data for editing
    final details = await client.quote.getQuoteDetails(widget.quoteId!);
    if (details == null) return;
    
    final quote = details.quote;

    setState(() {
      _gramsPrintedController.text = quote.gramsPrinted.toString();
      _printHoursController.text = quote.printHours.toString();
      _postProcessingCostController.text =
          quote.postProcessingCost?.toString() ?? '';
      _measurementsController.text = quote.measurements ?? '';
      _marginPercentController.text = quote.marginPercent.toString();
      _imageUrlController.text = quote.imageUrl ?? '';
      _selectedPrinterId = quote.printerId;
      _selectedShippingId = quote.shippingId;
      _selectedStatus = quote.status;

      // Load filaments
      if (details.filamentDetails != null) {
        for (var detail in details.filamentDetails!) {
          _selectedFilaments[detail.filament.id!] = detail.gramsUsed;
        }
      }

      // Load supplies
      if (details.supplyDetails != null) {
        for (var detail in details.supplyDetails!) {
          _selectedSupplies[detail.supply.id!] = detail.quantity;
        }
      }
    });
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
      final input = QuoteInput(
        gramsPrinted: double.parse(_gramsPrintedController.text),
        printHours: double.parse(_printHoursController.text),
        postProcessingCost: _postProcessingCostController.text.isEmpty
            ? null
            : double.parse(_postProcessingCostController.text),
        measurements: _measurementsController.text.isEmpty
            ? null
            : _measurementsController.text,
        marginPercent: double.parse(_marginPercentController.text),
        imageUrl:
            _imageUrlController.text.isEmpty ? null : _imageUrlController.text,
        status: _selectedStatus,
        printerId: _selectedPrinterId,
        shippingId: _selectedShippingId,
        filamentUsages: _selectedFilaments.entries
            .map((e) => FilamentUsage(filamentId: e.key, gramsUsed: e.value))
            .toList(),
        supplyUsages: _selectedSupplies.entries
            .map((e) => SupplyUsage(extraSupplyId: e.key, quantity: e.value))
            .toList(),
      );

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
                  : 'Cotización actualizada')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
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
                  // Basic Info Section
                  _buildSectionTitle('Información Básica'),
                  _buildTextField(
                    controller: _gramsPrintedController,
                    label: 'Gramos a imprimir',
                    keyboardType: TextInputType.number,
                    suffix: 'g',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _printHoursController,
                    label: 'Horas de impresión',
                    keyboardType: TextInputType.number,
                    suffix: 'hrs',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _measurementsController,
                    label: 'Medidas (opcional)',
                    hint: 'Ej: 10x10x5 cm',
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _postProcessingCostController,
                    label: 'Costo de post-procesado (opcional)',
                    keyboardType: TextInputType.number,
                    prefix: '\$',
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _imageUrlController,
                    label: 'URL de imagen (opcional)',
                    hint: 'https://...',
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle('Impresora'),
                  DropdownButtonFormField<int>(
                    value: _selectedPrinterId,
                    decoration: const InputDecoration(
                      labelText: 'Seleccionar impresora',
                      border: OutlineInputBorder(),
                    ),
                    items: _printers?.map((p) {
                          return DropdownMenuItem(
                            value: p.id,
                            child: Text('${p.name} (${p.powerConsumptionWatts}W)'),
                          );
                        }).toList() ??
                        [],
                    onChanged: (value) =>
                        setState(() => _selectedPrinterId = value),
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle('Filamentos'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          if (_selectedFilaments.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No hay filamentos seleccionados'),
                            )
                          else
                            ..._selectedFilaments.entries.map((entry) {
                              final filament = _filaments
                                  ?.firstWhere((f) => f.id == entry.key);
                              if (filament == null) return const SizedBox();
                              
                              final gramsUsed = entry.value;
                              final totalGrams = filament.spoolWeightKg * 1000;
                              final percentage = (gramsUsed / totalGrams * 100);
                              final estimatedCost = (gramsUsed / totalGrams) * filament.spoolCost;
                              
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  title: Text('${filament.name} (${filament.brand})'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Usando: ${gramsUsed}g de ${totalGrams.toInt()}g (${percentage.toStringAsFixed(1)}%)'),
                                      Text('Costo estimado: \$${estimatedCost.toStringAsFixed(2)}', 
                                        style: const TextStyle(fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        _selectedFilaments.remove(entry.key);
                                      });
                                    },
                                  ),
                                ),
                              );
                            }),
                          const SizedBox(height: 8),
                          if (_filaments != null && _filaments!.isNotEmpty)
                            ElevatedButton.icon(
                              onPressed: () => _showAddFilamentDialog(),
                              icon: const Icon(Icons.add),
                              label: const Text('Agregar filamento'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle('Insumos Extra'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          if (_selectedSupplies.isEmpty)
                            const Text('No hay insumos seleccionados')
                          else
                            ..._selectedSupplies.entries.map((entry) {
                              final supply = _supplies
                                  ?.firstWhere((s) => s.id == entry.key);
                              return ListTile(
                                title: Text(supply?.name ?? 'Desconocido'),
                                subtitle: Text('Cantidad: ${entry.value}'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _selectedSupplies.remove(entry.key);
                                    });
                                  },
                                ),
                              );
                            }),
                          if (_supplies != null && _supplies!.isNotEmpty)
                            ElevatedButton.icon(
                              onPressed: () => _showAddSupplyDialog(),
                              icon: const Icon(Icons.add),
                              label: const Text('Agregar insumo'),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle('Envío y Márgenes'),
                  DropdownButtonFormField<int>(
                    value: _selectedShippingId,
                    decoration: const InputDecoration(
                      labelText: 'Método de envío (opcional)',
                      border: OutlineInputBorder(),
                    ),
                    items: _shippings?.map((s) {
                          return DropdownMenuItem(
                            value: s.id,
                            child: Text('${s.shippingType} - \$${s.cost}'),
                          );
                        }).toList() ??
                        [],
                    onChanged: (value) =>
                        setState(() => _selectedShippingId = value),
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _marginPercentController,
                    label: 'Margen de ganancia',
                    keyboardType: TextInputType.number,
                    hint: '0.30 para 30%',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<QuoteStatus>(
                    value: _selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Estado',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: QuoteStatus.PENDIENTE,
                        child: Text('Pendiente'),
                      ),
                      DropdownMenuItem(
                        value: QuoteStatus.PROCESO,
                        child: Text('En Proceso'),
                      ),
                      DropdownMenuItem(
                        value: QuoteStatus.FINALIZADO,
                        child: Text('Finalizado'),
                      ),
                      DropdownMenuItem(
                        value: QuoteStatus.CANCELADO,
                        child: Text('Cancelado'),
                      ),
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedStatus = value!),
                  ),

                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveQuote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            widget.quoteId == null ? 'Crear Cotización' : 'Guardar Cambios',
                            style: const TextStyle(fontSize: 16),
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    String? prefix,
    String? suffix,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixText: prefix,
        suffixText: suffix,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Future<void> _showAddFilamentDialog() async {
    int? selectedFilamentId;
    Filament? selectedFilament;
    final gramsController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Agregar Filamento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Filamento'),
                items: _filaments
                        ?.where((f) => !_selectedFilaments.containsKey(f.id))
                        .map((f) => DropdownMenuItem(
                              value: f.id,
                              child: Text('${f.name} - ${f.brand}'),
                            ))
                        .toList() ??
                    [],
                onChanged: (value) {
                  setDialogState(() {
                    selectedFilamentId = value;
                    selectedFilament = _filaments?.firstWhere((f) => f.id == value);
                  });
                },
              ),
              if (selectedFilament != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rollo: ${selectedFilament!.spoolWeightKg} kg (${selectedFilament!.spoolWeightKg * 1000}g)',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Costo rollo: \$${selectedFilament!.spoolCost.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Material: ${selectedFilament!.materialType}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              TextField(
                controller: gramsController,
                decoration: const InputDecoration(
                  labelText: 'Gramos a usar en esta impresión',
                  suffixText: 'g',
                  helperText: 'Cantidad de filamento que consumirá',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (selectedFilamentId != null &&
                    gramsController.text.isNotEmpty) {
                  setState(() {
                    _selectedFilaments[selectedFilamentId!] =
                        double.parse(gramsController.text);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddSupplyDialog() async {
    int? selectedSupplyId;
    final quantityController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Insumo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Insumo'),
              items: _supplies
                      ?.where((s) => !_selectedSupplies.containsKey(s.id))
                      .map((s) => DropdownMenuItem(
                            value: s.id,
                            child: Text('${s.name} - \$${s.cost}'),
                          ))
                      .toList() ??
                  [],
              onChanged: (value) => selectedSupplyId = value,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (selectedSupplyId != null &&
                  quantityController.text.isNotEmpty) {
                setState(() {
                  _selectedSupplies[selectedSupplyId!] =
                      int.parse(quantityController.text);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _gramsPrintedController.dispose();
    _printHoursController.dispose();
    _postProcessingCostController.dispose();
    _measurementsController.dispose();
    _marginPercentController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
