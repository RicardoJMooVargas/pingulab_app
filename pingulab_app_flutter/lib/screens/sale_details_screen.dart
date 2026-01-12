import 'package:flutter/material.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import '../main.dart';

class SaleDetailsScreen extends StatefulWidget {
  final int saleId;

  const SaleDetailsScreen({
    Key? key,
    required this.saleId,
  }) : super(key: key);

  @override
  State<SaleDetailsScreen> createState() => _SaleDetailsScreenState();
}

class _SaleDetailsScreenState extends State<SaleDetailsScreen> {
  Sale? _sale;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSale();
  }

  Future<void> _loadSale() async {
    try {
      final sale = await client.sales.getSaleById(widget.saleId);
      setState(() {
        _sale = sale;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar venta: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venta #${widget.saleId}'),
        backgroundColor: Colors.deepPurple,
        actions: [
          if (_sale != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _sale == null
              ? const Center(child: Text('Venta no encontrada'))
              : _buildSaleDetails(),
    );
  }

  Widget _buildSaleDetails() {
    final sale = _sale!;
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Customer Info Card
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Text(
                        sale.customerName ?? 'Sin nombre',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  _buildDetailRow(
                    'Cotización',
                    'ID: ${sale.quoteId}',
                    Icons.description,
                  ),
                  if (sale.quoteVersionId != null)
                    _buildDetailRow(
                      'Versión',
                      'ID: ${sale.quoteVersionId}',
                      Icons.history,
                    ),
                  _buildDetailRow(
                    'Fecha de Venta',
                    dateFormat.format(sale.created),
                    Icons.calendar_today,
                  ),
                ],
              ),
            ),
          ),

          // Status Cards
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Estados',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Text('Estado de Venta: '),
                      const Spacer(),
                      DropdownButton<SaleStatus>(
                        value: sale.saleStatus,
                        items: SaleStatus.values.map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Text(_getSaleStatusLabel(status)),
                          );
                        }).toList(),
                        onChanged: (newStatus) {
                          if (newStatus != null) {
                            _updateSaleStatus(newStatus);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Estado de Pago: '),
                      const Spacer(),
                      DropdownButton<PaymentStatus>(
                        value: sale.paymentStatus,
                        items: PaymentStatus.values.map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Text(_getPaymentStatusLabel(status)),
                          );
                        }).toList(),
                        onChanged: (newStatus) {
                          if (newStatus != null) {
                            _showPaymentDialog(newStatus);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Payment Info Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Información de Pago',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  _buildAmountRow(
                    'Total',
                    sale.totalAmount,
                    currencyFormat,
                    color: Colors.deepPurple,
                    bold: true,
                  ),
                  const SizedBox(height: 8),
                  _buildAmountRow(
                    'Pagado',
                    sale.paidAmount,
                    currencyFormat,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 8),
                  _buildAmountRow(
                    'Pendiente',
                    sale.pendingAmount,
                    currencyFormat,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Delivery Info Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Programación de Entrega',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: _showDeliveryDialog,
                        tooltip: 'Editar entrega',
                      ),
                    ],
                  ),
                  const Divider(),
                  if (sale.scheduledDeliveryDate != null)
                    _buildDetailRow(
                      'Entrega Programada',
                      dateFormat.format(sale.scheduledDeliveryDate!),
                      Icons.schedule,
                      color: sale.scheduledDeliveryDate!.isBefore(DateTime.now()) &&
                              sale.saleStatus != SaleStatus.ENTREGADO
                          ? Colors.red
                          : null,
                    )
                  else
                    const Text('No programada'),
                  if (sale.actualDeliveryDate != null) ...[
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      'Entrega Real',
                      dateFormat.format(sale.actualDeliveryDate!),
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ],
                  if (sale.reminderDate != null) ...[
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      'Recordatorio',
                      dateFormat.format(sale.reminderDate!),
                      Icons.notifications,
                      color: sale.reminderSent ? Colors.green : Colors.orange,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Notes Card
          if (sale.notes != null && sale.notes!.isNotEmpty)
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Text(sale.notes!),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(
    String label,
    double amount,
    NumberFormat format, {
    Color? color,
    bool bold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: bold ? 16 : 14,
          ),
        ),
        Text(
          format.format(amount),
          style: TextStyle(
            color: color,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: bold ? 18 : 16,
          ),
        ),
      ],
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

  Future<void> _updateSaleStatus(SaleStatus newStatus) async {
    try {
      final updated = await client.sales.updateSaleStatus(
        widget.saleId,
        newStatus,
      );
      setState(() {
        _sale = updated;
      });
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

  void _showPaymentDialog(PaymentStatus newStatus) {
    final amountController = TextEditingController(
      text: _sale!.paidAmount.toStringAsFixed(2),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Actualizar Pago'),
          content: TextField(
            controller: amountController,
            decoration: const InputDecoration(
              labelText: 'Monto Pagado',
              prefixText: '\$ ',
            ),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final amount = double.tryParse(amountController.text);
                if (amount != null) {
                  try {
                    final updated = await client.sales.updatePaymentStatus(
                      widget.saleId,
                      newStatus,
                      paidAmount: amount,
                    );
                    setState(() {
                      _sale = updated;
                    });
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pago actualizado')),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showDeliveryDialog() {
    DateTime? scheduledDate = _sale!.scheduledDeliveryDate;
    DateTime? reminderDate = _sale!.reminderDate;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Programar Entrega'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Fecha de Entrega'),
                    subtitle: Text(
                      scheduledDate != null
                          ? DateFormat('dd/MM/yyyy HH:mm').format(scheduledDate!)
                          : 'No programada',
                    ),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: scheduledDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(scheduledDate ?? DateTime.now()),
                        );
                        if (time != null) {
                          setDialogState(() {
                            scheduledDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                          });
                        }
                      }
                    },
                  ),
                  ListTile(
                    title: const Text('Fecha de Recordatorio'),
                    subtitle: Text(
                      reminderDate != null
                          ? DateFormat('dd/MM/yyyy HH:mm').format(reminderDate!)
                          : 'Sin recordatorio',
                    ),
                    trailing: const Icon(Icons.notifications),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: reminderDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(reminderDate ?? DateTime.now()),
                        );
                        if (time != null) {
                          setDialogState(() {
                            reminderDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final updated = await client.sales.updateDeliverySchedule(
                        widget.saleId,
                        scheduledDeliveryDate: scheduledDate,
                        reminderDate: reminderDate,
                      );
                      setState(() {
                        _sale = updated;
                      });
                      if (mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Entrega actualizada')),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Venta'),
          content: const Text('¿Está seguro de que desea eliminar esta venta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                try {
                  await client.sales.deleteSale(widget.saleId);
                  if (mounted) {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context, true); // Close screen and refresh
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Venta eliminada')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                }
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}
