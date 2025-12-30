import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class QuoteEndpoint extends Endpoint {
  /// Create a new quote from input data
  Future<Quote> createQuote(Session session, QuoteInput input) async {
    // Create the quote object
    var quote = Quote(
      name: input.name,
      pieceWeightGrams: input.pieceWeightGrams,
      printHours: input.printHours,
      postProcessingCost: input.postProcessingCost,
      measurements: input.measurements,
      marginPercent: input.marginPercent,
      imageUrl: input.imageUrl,
      status: input.status ?? QuoteStatus.PENDIENTE,
      customerId: input.customerId,
      printerId: input.printerId,
      shippingId: input.shippingId,
      filamentCost: 0.0,
      electricityCost: 0.0,
      suppliesCost: 0.0,
      subtotal: 0.0,
      total: 0.0,
    );
    
    // Insert the quote first to get an ID
    quote = await Quote.db.insertRow(session, quote);
    
    // Process filament usages
    if (input.filamentUsages != null && input.filamentUsages!.isNotEmpty) {
      for (var usage in input.filamentUsages!) {
        final filament = await Filament.db.findById(session, usage.filamentId);
        if (filament != null) {
          // Calculate cost: (grams used / total grams) * spool cost
          final totalGrams = filament.spoolWeightKg * 1000;
          final cost = (usage.gramsUsed / totalGrams) * filament.spoolCost;
          
          await QuoteFilament.db.insertRow(session, QuoteFilament(
            quoteId: quote.id!,
            filamentId: usage.filamentId,
            gramsUsed: usage.gramsUsed,
            cost: cost,
          ));
        }
      }
    }
    
    // Process supply usages
    if (input.supplyUsages != null && input.supplyUsages!.isNotEmpty) {
      for (var usage in input.supplyUsages!) {
        final supply = await ExtraSupply.db.findById(session, usage.extraSupplyId);
        if (supply != null) {
          final cost = supply.cost * usage.quantity;
          
          await QuoteExtraSupply.db.insertRow(session, QuoteExtraSupply(
            quoteId: quote.id!,
            extraSupplyId: usage.extraSupplyId,
            quantity: usage.quantity,
            cost: cost,
          ));
        }
      }
    }
    
    // Calculate costs and update quote
    quote = await _calculateQuoteCosts(session, quote);
    quote = await Quote.db.updateRow(session, quote);
    
    // Return quote with all relations
    return (await getQuote(session, quote.id!))!;
  }

  /// Get a quote by ID with all relations
  Future<Quote?> getQuote(Session session, int id) async {
    final quote = await Quote.db.findById(session, id);
    return quote;
  }

  /// Get a quote with all its detailed information
  Future<QuoteDetails?> getQuoteDetails(Session session, int id) async {
    final quote = await Quote.db.findById(session, id);
    if (quote == null) return null;
    
    // Get filaments used
    final quoteFilaments = await QuoteFilament.db.find(
      session,
      where: (t) => t.quoteId.equals(id),
    );
    
    // Get filament details
    final filamentDetails = <QuoteFilamentDetail>[];
    for (var qf in quoteFilaments) {
      final filament = await Filament.db.findById(session, qf.filamentId);
      if (filament != null) {
        filamentDetails.add(QuoteFilamentDetail(
          filament: filament,
          gramsUsed: qf.gramsUsed,
          cost: qf.cost,
        ));
      }
    }
    
    // Get extra supplies used
    final quoteSupplies = await QuoteExtraSupply.db.find(
      session,
      where: (t) => t.quoteId.equals(id),
    );
    
    // Get supply details
    final supplyDetails = <QuoteSupplyDetail>[];
    for (var qs in quoteSupplies) {
      final supply = await ExtraSupply.db.findById(session, qs.extraSupplyId);
      if (supply != null) {
        supplyDetails.add(QuoteSupplyDetail(
          supply: supply,
          quantity: qs.quantity,
          cost: qs.cost,
        ));
      }
    }
    
    // Get printer if set
    Customer? customer;
    if (quote.customerId != null) {
      customer = await Customer.db.findById(session, quote.customerId!);
    }
    
    // Get printer if set
    Printer? printer;
    if (quote.printerId != null) {
      printer = await Printer.db.findById(session, quote.printerId!);
    }
    
    // Get shipping if set
    Shipping? shipping;
    if (quote.shippingId != null) {
      shipping = await Shipping.db.findById(session, quote.shippingId!);
    }
    
    return QuoteDetails(
      quote: quote,
      filamentDetails: filamentDetails.isEmpty ? null : filamentDetails,
      supplyDetails: supplyDetails.isEmpty ? null : supplyDetails,
      customer: customer,
      printer: printer,
      shipping: shipping,
    );
  }

  /// Get all quotes
  Future<List<Quote>> getAllQuotes(Session session) async {
    final quotes = await Quote.db.find(
      session,
      orderBy: (t) => t.id,
      orderDescending: true,
    );
    
    return quotes;
  }

  /// Update an existing quote
  Future<Quote> updateQuote(Session session, int quoteId, QuoteInput input) async {
    // Get existing quote
    var quote = await Quote.db.findById(session, quoteId);
    if (quote == null) {
      throw Exception('Quote not found');
    }
    
    // Update quote fields
    quote.name = input.name;
    quote.pieceWeightGrams = input.pieceWeightGrams;
    quote.printHours = input.printHours;
    quote.postProcessingCost = input.postProcessingCost;
    quote.measurements = input.measurements;
    quote.marginPercent = input.marginPercent;
    quote.imageUrl = input.imageUrl;
    quote.customerId = input.customerId;
    quote.printerId = input.printerId;
    quote.shippingId = input.shippingId;
    
    if (input.status != null) {
      quote.status = input.status!;
    }
    
    // Delete existing filament and supply relations
    await QuoteFilament.db.deleteWhere(
      session,
      where: (t) => t.quoteId.equals(quoteId),
    );
    
    await QuoteExtraSupply.db.deleteWhere(
      session,
      where: (t) => t.quoteId.equals(quoteId),
    );
    
    // Process new filament usages
    if (input.filamentUsages != null && input.filamentUsages!.isNotEmpty) {
      for (var usage in input.filamentUsages!) {
        final filament = await Filament.db.findById(session, usage.filamentId);
        if (filament != null) {
          final totalGrams = filament.spoolWeightKg * 1000;
          final cost = (usage.gramsUsed / totalGrams) * filament.spoolCost;
          
          await QuoteFilament.db.insertRow(session, QuoteFilament(
            quoteId: quoteId,
            filamentId: usage.filamentId,
            gramsUsed: usage.gramsUsed,
            cost: cost,
          ));
        }
      }
    }
    
    // Process new supply usages
    if (input.supplyUsages != null && input.supplyUsages!.isNotEmpty) {
      for (var usage in input.supplyUsages!) {
        final supply = await ExtraSupply.db.findById(session, usage.extraSupplyId);
        if (supply != null) {
          final cost = supply.cost * usage.quantity;
          
          await QuoteExtraSupply.db.insertRow(session, QuoteExtraSupply(
            quoteId: quoteId,
            extraSupplyId: usage.extraSupplyId,
            quantity: usage.quantity,
            cost: cost,
          ));
        }
      }
    }
    
    // Recalculate costs and update
    quote = await _calculateQuoteCosts(session, quote);
    quote = await Quote.db.updateRow(session, quote);
    
    // Return updated quote with relations
    return (await getQuote(session, quoteId))!;
  }

  /// Delete a quote
  Future<void> deleteQuote(Session session, int id) async {
    // First delete related records
    await QuoteFilament.db.deleteWhere(
      session,
      where: (t) => t.quoteId.equals(id),
    );
    
    await QuoteExtraSupply.db.deleteWhere(
      session,
      where: (t) => t.quoteId.equals(id),
    );
    
    // Then delete the quote
    await Quote.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }

  /// Helper method to calculate all costs for a quote
  Future<Quote> _calculateQuoteCosts(Session session, Quote quote) async {
    double filamentCost = 0.0;
    double electricityCost = 0.0;
    double suppliesCost = 0.0;
    double shippingCost = 0.0;

    // Calculate filament cost from related QuoteFilament records
    final quoteFilaments = await QuoteFilament.db.find(
      session,
      where: (t) => t.quoteId.equals(quote.id!),
    );
    
    for (var qf in quoteFilaments) {
      filamentCost += qf.cost;
    }

    // Calculate electricity cost
    if (quote.printerId != null && quote.printHours > 0) {
      final printer = await Printer.db.findById(session, quote.printerId!);
      if (printer != null) {
        // Get active electricity rate
        final electricityRate = await ElectricityRate.db.findFirstRow(
          session,
          where: (t) => t.active.equals(true),
        );
        
        if (electricityRate != null) {
          // Convert watts to kilowatts and calculate cost
          final kwh = (printer.powerConsumptionWatts / 1000) * quote.printHours;
          electricityCost = kwh * electricityRate.costPerKwh;
        }
      }
    }

    // Calculate supplies cost from related QuoteExtraSupply records
    final quoteSupplies = await QuoteExtraSupply.db.find(
      session,
      where: (t) => t.quoteId.equals(quote.id!),
    );
    
    for (var es in quoteSupplies) {
      suppliesCost += es.cost;
    }

    // Get shipping cost if shipping is selected
    if (quote.shippingId != null) {
      final shipping = await Shipping.db.findById(session, quote.shippingId!);
      if (shipping != null) {
        shippingCost = shipping.cost;
      }
    }

    // Calculate subtotal (before margin and shipping)
    final subtotal = filamentCost + electricityCost + suppliesCost + (quote.postProcessingCost ?? 0.0);

    // Calculate total with margin and shipping
    final total = subtotal * (1 + quote.marginPercent) + shippingCost;

    // Update quote with calculated values
    quote.filamentCost = filamentCost;
    quote.electricityCost = electricityCost;
    quote.suppliesCost = suppliesCost;
    quote.shippingCost = shippingCost;
    quote.subtotal = subtotal;
    quote.total = total;

    return quote;
  }

  /// Update quote status
  Future<Quote> updateQuoteStatus(Session session, int id, QuoteStatus status) async {
    final quote = await Quote.db.findById(session, id);
    
    if (quote == null) {
      throw Exception('Quote not found');
    }
    
    quote.status = status;
    final updatedQuote = await Quote.db.updateRow(session, quote);
    
    return updatedQuote;
  }
}
