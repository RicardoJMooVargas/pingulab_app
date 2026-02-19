import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint for managing sales operations.
/// Handles conversion from quotes to sales, status tracking, and payment management.
class SalesEndpoint extends Endpoint {
  /// Get all sales with optional filtering by status
  Future<List<Sale>> getAllSales(
    Session session, {
    SaleStatus? status,
    PaymentStatus? paymentStatus,
  }) async {
    final sales = await Sale.db.find(session);
    
    var filtered = sales;
    
    if (status != null) {
      filtered = filtered.where((s) => s.saleStatus == status).toList();
    }

    if (paymentStatus != null) {
      filtered = filtered.where((s) => s.paymentStatus == paymentStatus).toList();
    }

    // Sort by date descending
    filtered.sort((a, b) => b.created.compareTo(a.created));

    return filtered;
  }

  /// Get a specific sale by ID
  Future<Sale?> getSaleById(Session session, int saleId) async {
    return await Sale.db.findById(session, saleId);
  }

  /// Get sales by quote ID
  Future<List<Sale>> getSalesByQuoteId(Session session, int quoteId) async {
    final sales = await Sale.db.find(session);
    final filtered = sales.where((s) => s.quoteId == quoteId).toList();
    filtered.sort((a, b) => b.created.compareTo(a.created));
    return filtered;
  }

  /// Convert a quote to a sale
  Future<Sale> convertQuoteToSale(
    Session session,
    int quoteId, {
    int? quoteVersionId,
    int? customerId,
    SaleStatus? initialStatus,
    PaymentStatus? initialPaymentStatus,
    double? paidAmount,
    DateTime? scheduledDeliveryDate,
    String? customerName,
    String? notes,
  }) async {
    // Verify quote exists
    final quote = await Quote.db.findById(session, quoteId);
    if (quote == null) {
      throw Exception('Quote not found with id: $quoteId');
    }

    // If version specified, verify it exists
    if (quoteVersionId != null) {
      final version = await QuoteVersion.db.findById(session, quoteVersionId);
      if (version == null || version.quoteId != quoteId) {
        throw Exception(
            'Quote version $quoteVersionId not found for quote $quoteId');
      }
    }

    // Calculate amounts (use quote.total)
    final totalAmount = quote.total;
    final paid = paidAmount ?? 0.0;
    final pending = totalAmount - paid;

    // Use customerId from parameter or from quote
    final finalCustomerId = customerId ?? quote.customerId;

    // Create the sale
    final sale = Sale(
      quoteId: quoteId,
      quoteVersionId: quoteVersionId,
      customerId: finalCustomerId,
      saleStatus: initialStatus ?? SaleStatus.IMPRIMIENDO,
      paymentStatus: initialPaymentStatus ?? PaymentStatus.PENDIENTE,
      totalAmount: totalAmount,
      paidAmount: paid,
      pendingAmount: pending,
      scheduledDeliveryDate: scheduledDeliveryDate,
      reminderSent: false,
      customerName: customerName ?? quote.name,
      notes: notes,
      createdBy: 1, // TODO: Get from session when auth is implemented
      created: DateTime.now(),
    );

    final insertedSale = await Sale.db.insertRow(session, sale);
    return insertedSale;
  }

  /// Update sale status
  Future<Sale> updateSaleStatus(
    Session session,
    int saleId,
    SaleStatus newStatus, {
    String? notes,
  }) async {
    final sale = await Sale.db.findById(session, saleId);
    if (sale == null) {
      throw Exception('Sale not found with id: $saleId');
    }

    sale.saleStatus = newStatus;
    sale.updatedBy = 1; // TODO: Get from session
    sale.updated = DateTime.now();

    if (notes != null) {
      sale.notes = notes;
    }

    // If status is ENTREGADO, set delivery date if not already set
    if (newStatus == SaleStatus.ENTREGADO && sale.actualDeliveryDate == null) {
      sale.actualDeliveryDate = DateTime.now();
    }

    await Sale.db.updateRow(session, sale);
    return sale;
  }

  /// Update payment status and paid amount
  Future<Sale> updatePaymentStatus(
    Session session,
    int saleId,
    PaymentStatus newPaymentStatus, {
    double? paidAmount,
    String? notes,
  }) async {
    final sale = await Sale.db.findById(session, saleId);
    if (sale == null) {
      throw Exception('Sale not found with id: $saleId');
    }

    sale.paymentStatus = newPaymentStatus;
    sale.updatedBy = 1; // TODO: Get from session
    sale.updated = DateTime.now();

    if (paidAmount != null) {
      sale.paidAmount = paidAmount;
      sale.pendingAmount = sale.totalAmount - paidAmount;
      
      // Auto-adjust payment status based on amounts
      if (sale.paidAmount >= sale.totalAmount) {
        sale.paymentStatus = PaymentStatus.PAGADO;
      } else if (sale.paidAmount > 0) {
        sale.paymentStatus = PaymentStatus.PARCIAL;
      }
    }

    if (notes != null) {
      sale.notes = notes;
    }

    await Sale.db.updateRow(session, sale);
    return sale;
  }

  /// Update delivery scheduling
  Future<Sale> updateDeliverySchedule(
    Session session,
    int saleId, {
    DateTime? scheduledDeliveryDate,
    DateTime? reminderDate,
    DateTime? actualDeliveryDate,
  }) async {
    final sale = await Sale.db.findById(session, saleId);
    if (sale == null) {
      throw Exception('Sale not found with id: $saleId');
    }

    if (scheduledDeliveryDate != null) {
      sale.scheduledDeliveryDate = scheduledDeliveryDate;
    }

    if (reminderDate != null) {
      sale.reminderDate = reminderDate;
    }

    if (actualDeliveryDate != null) {
      sale.actualDeliveryDate = actualDeliveryDate;
    }

    sale.updatedBy = 1; // TODO: Get from session
    sale.updated = DateTime.now();

    await Sale.db.updateRow(session, sale);
    return sale;
  }

  /// Update sale notes
  Future<Sale> updateSaleNotes(
    Session session,
    int saleId,
    String notes,
  ) async {
    final sale = await Sale.db.findById(session, saleId);
    if (sale == null) {
      throw Exception('Sale not found with id: $saleId');
    }

    sale.notes = notes;
    sale.updatedBy = 1; // TODO: Get from session
    sale.updated = DateTime.now();

    await Sale.db.updateRow(session, sale);
    return sale;
  }

  /// Delete a sale
  Future<bool> deleteSale(Session session, int saleId) async {
    final sale = await Sale.db.findById(session, saleId);
    if (sale == null) {
      throw Exception('Sale not found with id: $saleId');
    }

    await Sale.db.deleteRow(session, sale);
    return true;
  }

  /// Get sales statistics
  Future<Map<String, dynamic>> getSalesStatistics(
    Session session, {
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    var sales = await Sale.db.find(session);

    if (fromDate != null) {
      sales = sales.where((s) => s.created.isAfter(fromDate) || s.created.isAtSameMomentAs(fromDate)).toList();
    }

    if (toDate != null) {
      sales = sales.where((s) => s.created.isBefore(toDate) || s.created.isAtSameMomentAs(toDate)).toList();
    }

    final totalSales = sales.length;
    final totalRevenue = sales.fold<double>(0.0, (sum, sale) => sum + sale.totalAmount);
    final totalPaid = sales.fold<double>(0.0, (sum, sale) => sum + sale.paidAmount);

    final salesByStatus = <String, int>{};
    for (var status in SaleStatus.values) {
      salesByStatus[status.name] = sales.where((s) => s.saleStatus == status).length;
    }

    final salesByPaymentStatus = <String, int>{};
    for (var status in PaymentStatus.values) {
      salesByPaymentStatus[status.name] = sales.where((s) => s.paymentStatus == status).length;
    }

    return {
      'totalSales': totalSales,
      'totalRevenue': totalRevenue,
      'totalPaid': totalPaid,
      'totalPending': totalRevenue - totalPaid,
      'salesByStatus': salesByStatus,
      'salesByPaymentStatus': salesByPaymentStatus,
    };
  }

  /// Get upcoming deliveries (scheduled for the next N days)
  Future<List<Sale>> getUpcomingDeliveries(
    Session session, {
    int daysAhead = 7,
  }) async {
    final now = DateTime.now();
    final futureDate = now.add(Duration(days: daysAhead));

    final sales = await Sale.db.find(session);
    final filtered = sales.where((s) =>
      s.scheduledDeliveryDate != null &&
      s.scheduledDeliveryDate!.isAfter(now) &&
      s.scheduledDeliveryDate!.isBefore(futureDate) &&
      s.saleStatus != SaleStatus.ENTREGADO
    ).toList();

    filtered.sort((a, b) => a.scheduledDeliveryDate!.compareTo(b.scheduledDeliveryDate!));
    return filtered;
  }

  /// Get overdue deliveries (scheduled delivery date passed but not delivered)
  Future<List<Sale>> getOverdueDeliveries(Session session) async {
    final now = DateTime.now();

    final sales = await Sale.db.find(session);
    final filtered = sales.where((s) =>
      s.scheduledDeliveryDate != null &&
      s.scheduledDeliveryDate!.isBefore(now) &&
      s.saleStatus != SaleStatus.ENTREGADO
    ).toList();

    filtered.sort((a, b) => a.scheduledDeliveryDate!.compareTo(b.scheduledDeliveryDate!));
    return filtered;
  }
}
