import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class QuoteVersionEndpoint extends Endpoint {
  /// Get all versions for a quote
  Future<List<QuoteVersion>> getQuoteVersions(Session session, int quoteId) async {
    return await QuoteVersion.db.find(
      session,
      where: (t) => t.quoteId.equals(quoteId),
      orderBy: (t) => t.versionNumber,
    );
  }

  /// Get primary version for a quote
  Future<QuoteVersion?> getPrimaryVersion(Session session, int quoteId) async {
    final versions = await QuoteVersion.db.find(
      session,
      where: (t) => t.quoteId.equals(quoteId) & t.isPrimary.equals(true),
      limit: 1,
    );
    return versions.isEmpty ? null : versions.first;
  }

  /// Create new version from current quote
  Future<QuoteVersion> createVersionFromQuote(
    Session session,
    int quoteId,
    String? versionName,
    bool isPrimary,
    int? userId,
  ) async {
    // Get the original quote
    final quote = await Quote.db.findById(session, quoteId);
    if (quote == null) {
      throw Exception('Quote not found');
    }

    // Get existing versions to determine version number
    final existingVersions = await QuoteVersion.db.find(
      session,
      where: (t) => t.quoteId.equals(quoteId),
      orderBy: (t) => t.versionNumber,
    );

    final versionNumber = existingVersions.isEmpty ? 1 : existingVersions.last.versionNumber + 1;

    // If this is primary, unset other primary versions
    if (isPrimary) {
      for (var version in existingVersions) {
        if (version.isPrimary) {
          version.isPrimary = false;
          await QuoteVersion.db.updateRow(session, version);
        }
      }
    }

    // Create the version
    var version = QuoteVersion(
      quoteId: quoteId,
      versionNumber: versionNumber,
      versionName: versionName,
      isPrimary: isPrimary,
      quantity: quote.quantity,
      pieceWeightGrams: quote.pieceWeightGrams,
      printHours: quote.printHours,
      postProcessingCost: quote.postProcessingCost,
      measurements: quote.measurements,
      filamentCost: quote.filamentCost,
      electricityCost: quote.electricityCost,
      suppliesCost: quote.suppliesCost,
      depreciationCost: quote.depreciationCost,
      shippingCost: quote.shippingCost,
      subtotal: quote.subtotal,
      marginPercent: quote.marginPercent,
      total: quote.total,
      printerId: quote.printerId,
      shippingId: quote.shippingId,
      createdBy: userId,
      created: DateTime.now(),
      notes: null,
    );

    version = await QuoteVersion.db.insertRow(session, version);

    // Copy filaments
    final quoteFilaments = await QuoteFilament.db.find(
      session,
      where: (t) => t.quoteId.equals(quoteId),
    );

    for (var qf in quoteFilaments) {
      await QuoteVersionFilament.db.insertRow(
        session,
        QuoteVersionFilament(
          quoteVersionId: version.id!,
          filamentId: qf.filamentId,
          gramsUsed: qf.gramsUsed,
          cost: qf.cost,
        ),
      );
    }

    // Copy supplies
    final quoteSupplies = await QuoteExtraSupply.db.find(
      session,
      where: (t) => t.quoteId.equals(quoteId),
    );

    for (var qs in quoteSupplies) {
      await QuoteVersionSupply.db.insertRow(
        session,
        QuoteVersionSupply(
          quoteVersionId: version.id!,
          extraSupplyId: qs.extraSupplyId,
          quantity: qs.quantity,
          cost: qs.cost,
        ),
      );
    }

    return version;
  }

  /// Set version as primary
  Future<void> setPrimaryVersion(Session session, int versionId) async {
    final version = await QuoteVersion.db.findById(session, versionId);
    if (version == null) {
      throw Exception('Version not found');
    }

    // Unset other primary versions for this quote
    final allVersions = await QuoteVersion.db.find(
      session,
      where: (t) => t.quoteId.equals(version.quoteId),
    );

    for (var v in allVersions) {
      v.isPrimary = (v.id == versionId);
      await QuoteVersion.db.updateRow(session, v);
    }
  }

  /// Apply version to quote (update quote with version data)
  Future<Quote> applyVersionToQuote(Session session, int versionId, int? userId) async {
    final version = await QuoteVersion.db.findById(session, versionId);
    if (version == null) {
      throw Exception('Version not found');
    }

    final quote = await Quote.db.findById(session, version.quoteId);
    if (quote == null) {
      throw Exception('Quote not found');
    }

    // Update quote with version data
    quote.quantity = version.quantity;
    quote.pieceWeightGrams = version.pieceWeightGrams;
    quote.printHours = version.printHours;
    quote.postProcessingCost = version.postProcessingCost;
    quote.measurements = version.measurements;
    quote.printerId = version.printerId;
    quote.shippingId = version.shippingId;
    quote.marginPercent = version.marginPercent;
    quote.updatedBy = userId;

    // Delete existing filaments and supplies
    await QuoteFilament.db.deleteWhere(
      session,
      where: (t) => t.quoteId.equals(quote.id!),
    );
    await QuoteExtraSupply.db.deleteWhere(
      session,
      where: (t) => t.quoteId.equals(quote.id!),
    );

    // Copy version filaments to quote
    final versionFilaments = await QuoteVersionFilament.db.find(
      session,
      where: (t) => t.quoteVersionId.equals(versionId),
    );

    for (var vf in versionFilaments) {
      await QuoteFilament.db.insertRow(
        session,
        QuoteFilament(
          quoteId: quote.id!,
          filamentId: vf.filamentId,
          gramsUsed: vf.gramsUsed,
          cost: vf.cost,
        ),
      );
    }

    // Copy version supplies to quote
    final versionSupplies = await QuoteVersionSupply.db.find(
      session,
      where: (t) => t.quoteVersionId.equals(versionId),
    );

    for (var vs in versionSupplies) {
      await QuoteExtraSupply.db.insertRow(
        session,
        QuoteExtraSupply(
          quoteId: quote.id!,
          extraSupplyId: vs.extraSupplyId,
          quantity: vs.quantity,
          cost: vs.cost,
        ),
      );
    }

    // Recalculate costs
    final updatedQuote = await _recalculateQuoteCosts(session, quote);
    return await Quote.db.updateRow(session, updatedQuote);
  }

  /// Delete version
  Future<void> deleteVersion(Session session, int versionId) async {
    // Delete related filaments and supplies
    await QuoteVersionFilament.db.deleteWhere(
      session,
      where: (t) => t.quoteVersionId.equals(versionId),
    );
    await QuoteVersionSupply.db.deleteWhere(
      session,
      where: (t) => t.quoteVersionId.equals(versionId),
    );
    
    // Delete version
    await QuoteVersion.db.deleteWhere(
      session,
      where: (t) => t.id.equals(versionId),
    );
  }

  /// Recalculate quote costs (helper method)
  Future<Quote> _recalculateQuoteCosts(Session session, Quote quote) async {
    double filamentCost = 0.0;
    double suppliesCost = 0.0;
    double electricityCost = 0.0;
    double depreciationCost = 0.0;
    double shippingCost = 0.0;

    // Calculate filament costs
    final filaments = await QuoteFilament.db.find(
      session,
      where: (t) => t.quoteId.equals(quote.id!),
    );
    for (var f in filaments) {
      filamentCost += f.cost;
    }

    // Calculate supply costs
    final supplies = await QuoteExtraSupply.db.find(
      session,
      where: (t) => t.quoteId.equals(quote.id!),
    );
    for (var s in supplies) {
      suppliesCost += s.cost;
    }

    // Calculate electricity cost
    if (quote.printerId != null) {
      final printer = await Printer.db.findById(session, quote.printerId!);
      if (printer != null) {
        final activeRate = await ElectricityRate.db.find(
          session,
          where: (t) => t.active.equals(true),
          limit: 1,
        );
        if (activeRate.isNotEmpty) {
          final kWh = (printer.powerConsumptionWatts / 1000.0) * quote.printHours;
          electricityCost = kWh * activeRate.first.costPerKwh;
        }
        // Calculate depreciation
        const double estimatedLifespanHours = 5000.0;
        depreciationCost = (printer.purchaseCost / estimatedLifespanHours) * quote.printHours;
      }
    }

    // Calculate shipping cost
    if (quote.shippingId != null) {
      final shipping = await Shipping.db.findById(session, quote.shippingId!);
      if (shipping != null) {
        shippingCost = shipping.cost;
      }
    }

    // Update quote costs
    quote.filamentCost = filamentCost * quote.quantity;
    quote.electricityCost = electricityCost * quote.quantity;
    quote.suppliesCost = suppliesCost * quote.quantity;
    quote.depreciationCost = depreciationCost * quote.quantity;
    quote.shippingCost = shippingCost;

    final postProcessing = quote.postProcessingCost ?? 0.0;
    quote.subtotal = (filamentCost + electricityCost + suppliesCost + depreciationCost + postProcessing) * quote.quantity;
    quote.total = quote.subtotal * (1 + quote.marginPercent) + shippingCost;

    return quote;
  }
}
