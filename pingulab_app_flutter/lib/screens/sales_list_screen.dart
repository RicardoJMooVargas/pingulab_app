import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'sale_details_screen.dart';

class SalesListScreen extends StatefulWidget {
  const SalesListScreen({Key? key}) : super(key: key);

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen> {
  late Future<List<Sale>> _salesFuture;
  SaleStatus? _filterStatus;
  PaymentStatus? _filterPaymentStatus;
  int? _filterCustomerId;
  String? _filterCustomerName;
  final TextEditingController _searchController = TextEditingController();
  List<Sale> _allSales = [];
  List<Sale> _filteredSales = [];
  List<Customer> _customers = [];
  Map<int, Customer> _customerMap = {};
  Map<int, String?> _quoteImagesMap = {};

  @override
  void initState() {
    super.initState();
    _loadCustomers();
    _loadSales();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCustomers() async {
    try {
      final customers = await client.catalogs.getCustomers();
      setState(() {
        _customers = customers;
        _customerMap = {for (var c in customers) c.id!: c};
      });
    } catch (e) {
      debugPrint('Error loading customers: $e');
    }
  }

  void _loadSales() {
    setState(() {
      _salesFuture = client.sales.getAllSales(
        status: _filterStatus,
        paymentStatus: _filterPaymentStatus,
      ).then((sales) async {
        _allSales = sales;
        // Cargar imágenes de cotizaciones
        await _loadQuoteImages(sales);
        _applyFilters();
        return _filteredSales;
      });
    });
  }

  Future<void> _loadQuoteImages(List<Sale> sales) async {
    final quoteIds = sales.map((s) => s.quoteId).toSet();
    for (var quoteId in quoteIds) {
      if (!_quoteImagesMap.containsKey(quoteId)) {
        try {
          final quoteDetails = await client.quote.getQuoteDetails(quoteId);
          _quoteImagesMap[quoteId] = quoteDetails?.quote.imageUrl;
        } catch (e) {
          debugPrint('Error loading quote image for quote $quoteId: $e');
          _quoteImagesMap[quoteId] = null;
        }
      }
    }
  }

  void _applyFilters() {
    List<Sale> filtered = List.from(_allSales);

    // Filtrar por cliente
    if (_filterCustomerId != null) {
      filtered = filtered.where((sale) => sale.customerId == _filterCustomerId).toList();
    }

    // Filtrar por búsqueda de texto
    final searchQuery = _searchController.text.toLowerCase().trim();
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((sale) {
        final customerName = (sale.customerName ?? '').toLowerCase();
        final saleId = 'venta #${sale.id}';
        final quoteId = 'cotización #${sale.quoteId}';
        
        return customerName.contains(searchQuery) ||
               saleId.contains(searchQuery) ||
               quoteId.contains(searchQuery);
      }).toList();
    }

    setState(() {
      _filteredSales = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por cliente, venta o cotización...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _applyFilters();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                _applyFilters();
              },
            ),
          ),
          // Filtros activos
          if (_filterStatus != null || _filterPaymentStatus != null || _filterCustomerId != null)
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.deepPurple.shade50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text('Filtros: '),
                    if (_filterStatus != null) ...[
                      Chip(
                        label: Text(_getSaleStatusLabel(_filterStatus!)),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          setState(() {
                            _filterStatus = null;
                            _loadSales();
                          });
                        },
                      ),
                      const SizedBox(width: 4),
                    ],
                    if (_filterPaymentStatus != null) ...[
                      Chip(
                        label: Text(_getPaymentStatusLabel(_filterPaymentStatus!)),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          setState(() {
                            _filterPaymentStatus = null;
                            _loadSales();
                          });
                        },
                      ),
                      const SizedBox(width: 4),
                    ],
                    if (_filterCustomerId != null) ...[
                      Chip(
                        label: Text('Cliente: $_filterCustomerName'),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          setState(() {
                            _filterCustomerId = null;
                            _filterCustomerName = null;
                            _applyFilters();
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          Expanded(
            child: FutureBuilder<List<Sale>>(
              future: _salesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final sales = snapshot.data ?? [];

                if (sales.isEmpty) {
                  return const Center(
                    child: Text('No hay ventas registradas'),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    _loadSales();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: sales.length,
                    itemBuilder: (context, index) {
                      final sale = sales[index];
                      return _buildSaleCard(sale);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaleCard(Sale sale) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    
    // Obtener información del cliente
    final customer = sale.customerId != null ? _customerMap[sale.customerId] : null;
    final displayName = customer?.apodo ?? sale.customerName ?? 'Sin cliente';
    
    // Obtener imagen de la cotización
    final quoteImage = _quoteImagesMap[sale.quoteId];

    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      elevation: 2,
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SaleDetailsScreen(saleId: sale.id!),
            ),
          );
          if (result == true) {
            _loadSales();
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 600;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: isDesktop && quoteImage != null
                  ? _buildDesktopLayout(sale, dateFormat, currencyFormat, displayName, customer, quoteImage)
                  : _buildMobileLayout(sale, dateFormat, currencyFormat, displayName, customer, quoteImage),
            );
          }
        ),
      ),
    );
  }

  Widget _buildMobileLayout(Sale sale, DateFormat dateFormat, NumberFormat currencyFormat, String displayName, Customer? customer, String? quoteImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (quoteImage != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.memory(
              base64Decode(quoteImage),
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.error_outline, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
        ],
        _buildSaleContent(sale, dateFormat, currencyFormat, displayName, customer),
      ],
    );
  }

  Widget _buildDesktopLayout(Sale sale, DateFormat dateFormat, NumberFormat currencyFormat, String displayName, Customer? customer, String quoteImage) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            base64Decode(quoteImage),
            width: 150,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 150,
                height: 150,
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(Icons.error_outline, color: Colors.grey),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSaleContent(sale, dateFormat, currencyFormat, displayName, customer),
        ),
      ],
    );
  }

  Widget _buildSaleContent(Sale sale, DateFormat dateFormat, NumberFormat currencyFormat, String displayName, Customer? customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, size: 16, color: Colors.deepPurple),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                displayName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Venta #${sale.id} • Cotización #${sale.quoteId}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        if (customer != null && sale.customerName != null && sale.customerName != customer.apodo) ...[
                          const SizedBox(height: 2),
                          Text(
                            sale.customerName!,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currencyFormat.format(sale.totalAmount),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text(
                        dateFormat.format(sale.created),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildStatusChip(
                      _getSaleStatusLabel(sale.saleStatus),
                      _getSaleStatusColor(sale.saleStatus),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatusChip(
                      _getPaymentStatusLabel(sale.paymentStatus),
                      _getPaymentStatusColor(sale.paymentStatus),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.account_balance_wallet, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Pagado: ${currencyFormat.format(sale.paidAmount)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.monetization_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Pendiente: ${currencyFormat.format(sale.pendingAmount)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
              if (sale.scheduledDeliveryDate != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: sale.scheduledDeliveryDate!.isBefore(DateTime.now()) &&
                              sale.saleStatus != SaleStatus.ENTREGADO
                          ? Colors.red
                          : Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Entrega: ${dateFormat.format(sale.scheduledDeliveryDate!)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: sale.scheduledDeliveryDate!.isBefore(DateTime.now()) &&
                                sale.saleStatus != SaleStatus.ENTREGADO
                            ? Colors.red
                            : Colors.grey[700],
                        fontWeight: sale.scheduledDeliveryDate!.isBefore(DateTime.now()) &&
                                sale.saleStatus != SaleStatus.ENTREGADO
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color: color.withOpacity(0.9),
          fontWeight: FontWeight.bold,
        ),
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

  String _getPaymentStatusLabel(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.PENDIENTE:
        return 'PENDIENTE';
      case PaymentStatus.PARCIAL:
        return 'PARCIAL';
      case PaymentStatus.PAGADO:
        return 'PAGADO';
    }
  }

  Color _getPaymentStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.PENDIENTE:
        return Colors.red;
      case PaymentStatus.PARCIAL:
        return Colors.orange;
      case PaymentStatus.PAGADO:
        return Colors.green;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        SaleStatus? tempFilterStatus = _filterStatus;
        PaymentStatus? tempFilterPaymentStatus = _filterPaymentStatus;
        int? tempFilterCustomerId = _filterCustomerId;
        String? tempFilterCustomerName = _filterCustomerName;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Filtrar Ventas'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cliente:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int?>(
                      value: tempFilterCustomerId,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      hint: const Text('Todos los clientes'),
                      items: [
                        const DropdownMenuItem<int?>(
                          value: null,
                          child: Text('Todos los clientes'),
                        ),
                        ..._customers.map((customer) {
                          return DropdownMenuItem<int?>(
                            value: customer.id,
                            child: Text(customer.apodo),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          tempFilterCustomerId = value;
                          if (value != null) {
                            final customer = _customers.firstWhere((c) => c.id == value);
                            tempFilterCustomerName = customer.apodo;
                          } else {
                            tempFilterCustomerName = null;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('Estado de Venta:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('Todos'),
                          selected: tempFilterStatus == null,
                          onSelected: (selected) {
                            setDialogState(() {
                              tempFilterStatus = null;
                            });
                          },
                        ),
                        ...SaleStatus.values.map((status) {
                          return ChoiceChip(
                            label: Text(_getSaleStatusLabel(status)),
                            selected: tempFilterStatus == status,
                            onSelected: (selected) {
                              setDialogState(() {
                                tempFilterStatus = selected ? status : null;
                              });
                            },
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Estado de Pago:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('Todos'),
                          selected: tempFilterPaymentStatus == null,
                          onSelected: (selected) {
                            setDialogState(() {
                              tempFilterPaymentStatus = null;
                            });
                          },
                        ),
                        ...PaymentStatus.values.map((status) {
                          return ChoiceChip(
                            label: Text(_getPaymentStatusLabel(status)),
                            selected: tempFilterPaymentStatus == status,
                            onSelected: (selected) {
                              setDialogState(() {
                                tempFilterPaymentStatus = selected ? status : null;
                              });
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filterStatus = tempFilterStatus;
                      _filterPaymentStatus = tempFilterPaymentStatus;
                      _filterCustomerId = tempFilterCustomerId;
                      _filterCustomerName = tempFilterCustomerName;
                    });
                    _loadSales();
                    Navigator.pop(context);
                  },
                  child: const Text('Aplicar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
