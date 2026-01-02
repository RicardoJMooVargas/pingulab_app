import 'package:flutter/material.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import '../main.dart';

class CatalogsScreen extends StatefulWidget {
  const CatalogsScreen({Key? key}) : super(key: key);

  @override
  State<CatalogsScreen> createState() => _CatalogsScreenState();
}

class _CatalogsScreenState extends State<CatalogsScreen> {
  int _selectedIndex = 0;

  final List<String> _tabs = [
    'Filamentos',
    'Impresoras',
    'Envíos',
    'Clientes',
    'Tarifas Eléctricas',
    'Suministros Extra',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Catálogos'),
      ),
      body: Row(
        children: [
          // Sidebar de navegación
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: _tabs
                .map((tab) => NavigationRailDestination(
                      icon: _getIcon(tab, false),
                      selectedIcon: _getIcon(tab, true),
                      label: Text(tab),
                    ))
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Contenido principal
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Icon _getIcon(String tab, bool selected) {
    IconData iconData;
    switch (tab) {
      case 'Filamentos':
        iconData = Icons.layers;
        break;
      case 'Impresoras':
        iconData = Icons.print;
        break;
      case 'Envíos':
        iconData = Icons.local_shipping;
        break;
      case 'Clientes':
        iconData = Icons.people;
        break;
      case 'Tarifas Eléctricas':
        iconData = Icons.bolt;
        break;
      case 'Suministros Extra':
        iconData = Icons.inventory;
        break;
      default:
        iconData = Icons.category;
    }
    return Icon(iconData);
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const FilamentsTab();
      case 1:
        return const PrintersTab();
      case 2:
        return const ShippingsTab();
      case 3:
        return const CustomersTab();
      case 4:
        return const ElectricityRatesTab();
      case 5:
        return const ExtraSuppliesTab();
      default:
        return const Center(child: Text('Seleccione una categoría'));
    }
  }
}

// ========== FILAMENTS TAB ==========

class FilamentsTab extends StatefulWidget {
  const FilamentsTab({Key? key}) : super(key: key);

  @override
  State<FilamentsTab> createState() => _FilamentsTabState();
}

class _FilamentsTabState extends State<FilamentsTab> {
  List<Filament> _filaments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFilaments();
  }

  Future<void> _loadFilaments() async {
    setState(() => _isLoading = true);
    try {
      final filaments = await client.catalogs.getFilaments();
      setState(() {
        _filaments = filaments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar filamentos: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filamentos (${_filaments.length})',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ElevatedButton.icon(
                onPressed: () => _showFilamentDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Agregar Filamento'),
              ),
            ],
          ),
        ),
        Expanded(
          child: _filaments.isEmpty
              ? const Center(child: Text('No hay filamentos registrados'))
              : ListView.builder(
                  itemCount: _filaments.length,
                  itemBuilder: (context, index) {
                    final filament = _filaments[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _parseColor(filament.color),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        title: Text(filament.name),
                        subtitle: Text(
                            '${filament.brand} - ${filament.materialType} - ${filament.spoolWeightKg}kg - \$${filament.spoolCost.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showFilamentDialog(filament: filament),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteFilament(filament),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Color _parseColor(String colorString) {
    try {
      String hex = colorString.replaceAll('#', '');
      if (hex.length == 6) {
        return Color(int.parse('FF$hex', radix: 16));
      }
    } catch (e) {
      // Fallback color
    }
    return Colors.grey;
  }

  Future<void> _showFilamentDialog({Filament? filament}) async {
    final isEdit = filament != null;
    final nameController = TextEditingController(text: filament?.name ?? '');
    final brandController = TextEditingController(text: filament?.brand ?? '');
    final materialController =
        TextEditingController(text: filament?.materialType ?? '');
    final colorController =
        TextEditingController(text: filament?.color ?? '#808080');
    final weightController = TextEditingController(
        text: filament?.spoolWeightKg.toString() ?? '1.0');
    final costController =
        TextEditingController(text: filament?.spoolCost.toString() ?? '0.0');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'Editar Filamento' : 'Nuevo Filamento'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: brandController,
                decoration: const InputDecoration(labelText: 'Marca'),
              ),
              TextField(
                controller: materialController,
                decoration: const InputDecoration(labelText: 'Material'),
              ),
              TextField(
                controller: colorController,
                decoration: const InputDecoration(
                    labelText: 'Color (hex)', hintText: '#FF0000'),
              ),
              TextField(
                controller: weightController,
                decoration:
                    const InputDecoration(labelText: 'Peso del rollo (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: costController,
                decoration:
                    const InputDecoration(labelText: 'Costo del rollo (\$)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(isEdit ? 'Guardar' : 'Crear'),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        if (isEdit) {
          await client.catalogs.updateFilament(
            filament!.id!,
            nameController.text,
            brandController.text,
            materialController.text,
            colorController.text,
            double.parse(weightController.text),
            double.parse(costController.text),
          );
        } else {
          await client.catalogs.createFilament(
            nameController.text,
            brandController.text,
            materialController.text,
            colorController.text,
            double.parse(weightController.text),
            double.parse(costController.text),
          );
        }
        _loadFilaments();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(isEdit
                    ? 'Filamento actualizado'
                    : 'Filamento creado')),
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

  Future<void> _deleteFilament(Filament filament) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Eliminar el filamento "${filament.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await client.catalogs.deleteFilament(filament.id!);
        _loadFilaments();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Filamento eliminado')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }
}

// ========== PRINTERS TAB ==========

class PrintersTab extends StatefulWidget {
  const PrintersTab({Key? key}) : super(key: key);

  @override
  State<PrintersTab> createState() => _PrintersTabState();
}

class _PrintersTabState extends State<PrintersTab> {
  List<Printer> _printers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrinters();
  }

  Future<void> _loadPrinters() async {
    setState(() => _isLoading = true);
    try {
      final printers = await client.catalogs.getPrinters();
      setState(() {
        _printers = printers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar impresoras: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Impresoras (${_printers.length})',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ElevatedButton.icon(
                onPressed: () => _showPrinterDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Agregar Impresora'),
              ),
            ],
          ),
        ),
        Expanded(
          child: _printers.isEmpty
              ? const Center(child: Text('No hay impresoras registradas'))
              : ListView.builder(
                  itemCount: _printers.length,
                  itemBuilder: (context, index) {
                    final printer = _printers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.print, size: 40),
                        title: Text(printer.name),
                        subtitle: Text(
                            '${printer.powerConsumptionWatts}W - Costo: \$${printer.purchaseCost.toStringAsFixed(2)} - ${printer.available ? "Disponible" : "No disponible"}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showPrinterDialog(printer: printer),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deletePrinter(printer),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _showPrinterDialog({Printer? printer}) async {
    final isEdit = printer != null;
    final nameController = TextEditingController(text: printer?.name ?? '');
    final powerController = TextEditingController(
        text: printer?.powerConsumptionWatts.toString() ?? '0');
    final costController = TextEditingController(
        text: printer?.purchaseCost.toString() ?? '0.0');
    bool available = printer?.available ?? true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEdit ? 'Editar Impresora' : 'Nueva Impresora'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: powerController,
                  decoration: const InputDecoration(
                      labelText: 'Consumo de energía (W)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: costController,
                  decoration:
                      const InputDecoration(labelText: 'Costo de compra (\$)'),
                  keyboardType: TextInputType.number,
                ),
                SwitchListTile(
                  title: const Text('Disponible'),
                  value: available,
                  onChanged: (value) {
                    setDialogState(() {
                      available = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(isEdit ? 'Guardar' : 'Crear'),
            ),
          ],
        ),
      ),
    );

    if (result == true) {
      try {
        if (isEdit) {
          await client.catalogs.updatePrinter(
            printer!.id!,
            nameController.text,
            int.parse(powerController.text),
            double.parse(costController.text),
            available,
          );
        } else {
          await client.catalogs.createPrinter(
            nameController.text,
            int.parse(powerController.text),
            double.parse(costController.text),
            available,
          );
        }
        _loadPrinters();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    isEdit ? 'Impresora actualizada' : 'Impresora creada')),
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

  Future<void> _deletePrinter(Printer printer) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Eliminar la impresora "${printer.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await client.catalogs.deletePrinter(printer.id!);
        _loadPrinters();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Impresora eliminada')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }
}

// ========== SHIPPINGS TAB ==========

class ShippingsTab extends StatefulWidget {
  const ShippingsTab({Key? key}) : super(key: key);

  @override
  State<ShippingsTab> createState() => _ShippingsTabState();
}

class _ShippingsTabState extends State<ShippingsTab> {
  List<Shipping> _shippings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadShippings();
  }

  Future<void> _loadShippings() async {
    setState(() => _isLoading = true);
    try {
      final shippings = await client.catalogs.getShippings();
      setState(() {
        _shippings = shippings;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar envíos: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Métodos de Envío (${_shippings.length})',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ElevatedButton.icon(
                onPressed: () => _showShippingDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Agregar Envío'),
              ),
            ],
          ),
        ),
        Expanded(
          child: _shippings.isEmpty
              ? const Center(child: Text('No hay métodos de envío registrados'))
              : ListView.builder(
                  itemCount: _shippings.length,
                  itemBuilder: (context, index) {
                    final shipping = _shippings[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading:
                            const Icon(Icons.local_shipping, size: 40),
                        title: Text(shipping.shippingType),
                        subtitle: Text(
                            '${shipping.carrierName} - \$${shipping.cost.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showShippingDialog(shipping: shipping),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteShipping(shipping),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _showShippingDialog({Shipping? shipping}) async {
    final isEdit = shipping != null;
    final typeController =
        TextEditingController(text: shipping?.shippingType ?? '');
    final carrierController =
        TextEditingController(text: shipping?.carrierName ?? '');
    final costController =
        TextEditingController(text: shipping?.cost.toString() ?? '0.0');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'Editar Envío' : 'Nuevo Envío'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: typeController,
              decoration:
                  const InputDecoration(labelText: 'Tipo de envío'),
            ),
            TextField(
              controller: carrierController,
              decoration: const InputDecoration(labelText: 'Transportista'),
            ),
            TextField(
              controller: costController,
              decoration: const InputDecoration(labelText: 'Costo (\$)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(isEdit ? 'Guardar' : 'Crear'),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        if (isEdit) {
          await client.catalogs.updateShipping(
            shipping!.id!,
            typeController.text,
            carrierController.text,
            double.parse(costController.text),
          );
        } else {
          await client.catalogs.createShipping(
            typeController.text,
            carrierController.text,
            double.parse(costController.text),
          );
        }
        _loadShippings();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(isEdit ? 'Envío actualizado' : 'Envío creado')),
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

  Future<void> _deleteShipping(Shipping shipping) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Eliminar el envío "${shipping.shippingType}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await client.catalogs.deleteShipping(shipping.id!);
        _loadShippings();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Envío eliminado')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }
}

// ========== CUSTOMERS TAB ==========

class CustomersTab extends StatefulWidget {
  const CustomersTab({Key? key}) : super(key: key);

  @override
  State<CustomersTab> createState() => _CustomersTabState();
}

class _CustomersTabState extends State<CustomersTab> {
  List<Customer> _customers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    setState(() => _isLoading = true);
    try {
      final customers = await client.catalogs.getCustomers();
      setState(() {
        _customers = customers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar clientes: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Clientes (${_customers.length})',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ElevatedButton.icon(
                onPressed: () => _showCustomerDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Agregar Cliente'),
              ),
            ],
          ),
        ),
        Expanded(
          child: _customers.isEmpty
              ? const Center(child: Text('No hay clientes registrados'))
              : ListView.builder(
                  itemCount: _customers.length,
                  itemBuilder: (context, index) {
                    final customer = _customers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.person, size: 40),
                        title: Text(customer.apodo),
                        subtitle: Text(
                            '${customer.nombre ?? ""} ${customer.apellido ?? ""}\n${customer.numero ?? "Sin teléfono"}'
                                .trim()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showCustomerDialog(customer: customer),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteCustomer(customer),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _showCustomerDialog({Customer? customer}) async {
    final isEdit = customer != null;
    final apodoController =
        TextEditingController(text: customer?.apodo ?? '');
    final nombreController =
        TextEditingController(text: customer?.nombre ?? '');
    final apellidoController =
        TextEditingController(text: customer?.apellido ?? '');
    final numeroController =
        TextEditingController(text: customer?.numero ?? '');
    final direccionController =
        TextEditingController(text: customer?.direccion ?? '');
    final notesController =
        TextEditingController(text: customer?.notes ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'Editar Cliente' : 'Nuevo Cliente'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: apodoController,
                decoration:
                    const InputDecoration(labelText: 'Apodo (requerido)'),
              ),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: numeroController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
              ),
              TextField(
                controller: direccionController,
                decoration: const InputDecoration(labelText: 'Dirección'),
              ),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notas'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(isEdit ? 'Guardar' : 'Crear'),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        if (isEdit) {
          await client.catalogs.updateCustomer(
            customer!.id!,
            apodoController.text,
            nombre: nombreController.text.isEmpty
                ? null
                : nombreController.text,
            apellido: apellidoController.text.isEmpty
                ? null
                : apellidoController.text,
            numero: numeroController.text.isEmpty
                ? null
                : numeroController.text,
            direccion: direccionController.text.isEmpty
                ? null
                : direccionController.text,
            notes: notesController.text.isEmpty
                ? null
                : notesController.text,
          );
        } else {
          await client.catalogs.createCustomer(
            apodoController.text,
            nombre: nombreController.text.isEmpty
                ? null
                : nombreController.text,
            apellido: apellidoController.text.isEmpty
                ? null
                : apellidoController.text,
            numero: numeroController.text.isEmpty
                ? null
                : numeroController.text,
            direccion: direccionController.text.isEmpty
                ? null
                : direccionController.text,
            notes: notesController.text.isEmpty
                ? null
                : notesController.text,
          );
        }
        _loadCustomers();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    isEdit ? 'Cliente actualizado' : 'Cliente creado')),
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

  Future<void> _deleteCustomer(Customer customer) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Eliminar el cliente "${customer.apodo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await client.catalogs.deleteCustomer(customer.id!);
        _loadCustomers();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cliente eliminado')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }
}

// ========== ELECTRICITY RATES TAB ==========

class ElectricityRatesTab extends StatefulWidget {
  const ElectricityRatesTab({Key? key}) : super(key: key);

  @override
  State<ElectricityRatesTab> createState() => _ElectricityRatesTabState();
}

class _ElectricityRatesTabState extends State<ElectricityRatesTab> {
  List<ElectricityRate> _rates = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRates();
  }

  Future<void> _loadRates() async {
    setState(() => _isLoading = true);
    try {
      final rates = await client.catalogs.getElectricityRates();
      setState(() {
        _rates = rates;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar tarifas: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tarifas Eléctricas (${_rates.length})',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ElevatedButton.icon(
                onPressed: () => _showRateDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Agregar Tarifa'),
              ),
            ],
          ),
        ),
        Expanded(
          child: _rates.isEmpty
              ? const Center(
                  child: Text('No hay tarifas eléctricas registradas'))
              : ListView.builder(
                  itemCount: _rates.length,
                  itemBuilder: (context, index) {
                    final rate = _rates[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      color: rate.active
                          ? Colors.green.shade50
                          : null,
                      child: ListTile(
                        leading: Icon(
                          rate.active ? Icons.bolt : Icons.bolt_outlined,
                          size: 40,
                          color: rate.active ? Colors.green : null,
                        ),
                        title: Text(
                            '\$${rate.costPerKwh.toStringAsFixed(4)} por kWh'),
                        subtitle: Text(rate.active ? 'ACTIVA' : 'Inactiva'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showRateDialog(rate: rate),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteRate(rate),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _showRateDialog({ElectricityRate? rate}) async {
    final isEdit = rate != null;
    final costController =
        TextEditingController(text: rate?.costPerKwh.toString() ?? '0.0');
    bool active = rate?.active ?? false;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEdit ? 'Editar Tarifa' : 'Nueva Tarifa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: costController,
                decoration:
                    const InputDecoration(labelText: 'Costo por kWh (\$)'),
                keyboardType: TextInputType.number,
              ),
              SwitchListTile(
                title: const Text('Activa'),
                subtitle: const Text(
                    'Solo una tarifa puede estar activa a la vez'),
                value: active,
                onChanged: (value) {
                  setDialogState(() {
                    active = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(isEdit ? 'Guardar' : 'Crear'),
            ),
          ],
        ),
      ),
    );

    if (result == true) {
      try {
        if (isEdit) {
          await client.catalogs.updateElectricityRate(
            rate!.id!,
            double.parse(costController.text),
            active,
          );
        } else {
          await client.catalogs.createElectricityRate(
            double.parse(costController.text),
            active,
          );
        }
        _loadRates();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    isEdit ? 'Tarifa actualizada' : 'Tarifa creada')),
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

  Future<void> _deleteRate(ElectricityRate rate) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Eliminar esta tarifa eléctrica?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await client.catalogs.deleteElectricityRate(rate.id!);
        _loadRates();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tarifa eliminada')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }
}

// ========== EXTRA SUPPLIES TAB ==========

class ExtraSuppliesTab extends StatefulWidget {
  const ExtraSuppliesTab({Key? key}) : super(key: key);

  @override
  State<ExtraSuppliesTab> createState() => _ExtraSuppliesTabState();
}

class _ExtraSuppliesTabState extends State<ExtraSuppliesTab> {
  List<ExtraSupply> _supplies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSupplies();
  }

  Future<void> _loadSupplies() async {
    setState(() => _isLoading = true);
    try {
      final supplies = await client.catalogs.getExtraSupplies();
      setState(() {
        _supplies = supplies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar suministros: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Suministros Extra (${_supplies.length})',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ElevatedButton.icon(
                onPressed: () => _showSupplyDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Agregar Suministro'),
              ),
            ],
          ),
        ),
        Expanded(
          child: _supplies.isEmpty
              ? const Center(child: Text('No hay suministros registrados'))
              : ListView.builder(
                  itemCount: _supplies.length,
                  itemBuilder: (context, index) {
                    final supply = _supplies[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.inventory, size: 40),
                        title: Text(supply.name),
                        subtitle: Text('\$${supply.cost.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showSupplyDialog(supply: supply),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteSupply(supply),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _showSupplyDialog({ExtraSupply? supply}) async {
    final isEdit = supply != null;
    final nameController = TextEditingController(text: supply?.name ?? '');
    final costController =
        TextEditingController(text: supply?.cost.toString() ?? '0.0');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'Editar Suministro' : 'Nuevo Suministro'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: costController,
              decoration: const InputDecoration(labelText: 'Costo (\$)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(isEdit ? 'Guardar' : 'Crear'),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        if (isEdit) {
          await client.catalogs.updateExtraSupply(
            supply!.id!,
            nameController.text,
            double.parse(costController.text),
          );
        } else {
          await client.catalogs.createExtraSupply(
            nameController.text,
            double.parse(costController.text),
          );
        }
        _loadSupplies();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(isEdit
                    ? 'Suministro actualizado'
                    : 'Suministro creado')),
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

  Future<void> _deleteSupply(ExtraSupply supply) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Eliminar el suministro "${supply.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await client.catalogs.deleteExtraSupply(supply.id!);
        _loadSupplies();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Suministro eliminado')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar: $e')),
          );
        }
      }
    }
  }
}
