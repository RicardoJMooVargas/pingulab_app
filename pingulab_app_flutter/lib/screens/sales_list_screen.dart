import 'package:flutter/material.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
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

  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  void _loadSales() {
    setState(() {
      _salesFuture = client.sales.getAllSales(
        status: _filterStatus,
        paymentStatus: _filterPaymentStatus,
      );
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
          if (_filterStatus != null || _filterPaymentStatus != null)
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.deepPurple.shade50,
              child: Row(
                children: [
                  const Text('Filtros activos: '),
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
                  ],
                ],
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sale.customerName ?? 'Sin nombre',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Venta #${sale.id}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
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
          ),
        ),
      ),
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

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Filtrar Ventas'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
