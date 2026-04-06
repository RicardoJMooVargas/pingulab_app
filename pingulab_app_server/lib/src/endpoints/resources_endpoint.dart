import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ResourcesEndpoint extends Endpoint {
  Future<Filament?> _findLastUsedFilamentForCatalog(
    Session session,
    String materialType,
    String color,
  ) async {
    final quoteFilaments = await QuoteFilament.db.find(
      session,
      orderBy: (t) => t.id,
      orderDescending: true,
      limit: 100,
    );

    for (final qf in quoteFilaments) {
      final filament = await Filament.db.findById(session, qf.filamentId);
      if (filament == null) continue;
      if (filament.materialType == materialType && filament.color == color) {
        return filament;
      }
    }

    return null;
  }

  // ========== PRINTERS ==========
  
  /// Get all printers
  Future<List<Printer>> getAllPrinters(Session session) async {
    return await Printer.db.find(session, orderBy: (t) => t.name);
  }

  /// Get available printers only
  Future<List<Printer>> getAvailablePrinters(Session session) async {
    return await Printer.db.find(
      session,
      where: (t) => t.available.equals(true),
      orderBy: (t) => t.name,
    );
  }
  
  /// Create a new printer
  Future<Printer> createPrinter(
    Session session,
    String name,
    int powerConsumptionWatts,
    double purchaseCost,
    bool available, {
    String? imageBase64,
  }) async {
    final printer = Printer(
      name: name,
      powerConsumptionWatts: powerConsumptionWatts,
      purchaseCost: purchaseCost,
      imageBase64: imageBase64,
      available: available,
    );
    
    return await Printer.db.insertRow(session, printer);
  }
  
  /// Update printer
  Future<Printer> updatePrinter(
    Session session,
    int printerId,
    String name,
    int powerConsumptionWatts,
    double purchaseCost,
    bool available, {
    String? imageBase64,
  }) async {
    final printer = await Printer.db.findById(session, printerId);
    
    if (printer == null) {
      throw Exception('Printer not found');
    }
    
    printer.name = name;
    printer.powerConsumptionWatts = powerConsumptionWatts;
    printer.purchaseCost = purchaseCost;
    printer.imageBase64 = imageBase64;
    printer.available = available;
    
    return await Printer.db.updateRow(session, printer);
  }
  
  /// Delete printer
  Future<void> deletePrinter(Session session, int printerId) async {
    await Printer.db.deleteWhere(
      session,
      where: (t) => t.id.equals(printerId),
    );
  }

  // ========== FILAMENTS ==========
  
  /// Get all filaments
  Future<List<Filament>> getAllFilaments(Session session) async {
    return await Filament.db.find(session, orderBy: (t) => t.name);
  }

  /// Get filament catalog items used by UI (material + color)
  Future<List<FilamentCatalogItem>> getFilamentCatalogItems(
    Session session, {
    bool onlyActive = true,
  }) async {
    return await FilamentCatalogItem.db.find(
      session,
      where: onlyActive ? (t) => t.active.equals(true) : null,
      orderBy: (t) => t.materialType,
    );
  }

  /// Get available filament spools for a catalog item.
  Future<List<Filament>> getFilamentInventoryByCatalog(
    Session session,
    String materialType,
    String color, {
    bool onlyWithStock = false,
  }) async {
    final filaments = await Filament.db.find(
      session,
      where: (t) => t.materialType.equals(materialType) & t.color.equals(color),
      orderBy: (t) => t.remainingGrams,
      orderDescending: true,
    );

    if (!onlyWithStock) return filaments;
    return filaments.where((f) => f.remainingGrams > 0).toList();
  }

  /// Suggests which real spool should be used for a quote requirement.
  /// Selection priority:
  /// 1) preferredFilamentId (if valid)
  /// 2) spool with most stock that can cover required grams
  /// 3) spool with most stock (same material+color)
  /// 4) last used spool (same material+color)
  /// 5) any spool with same color
  Future<String> suggestFilamentForRequirement(
    Session session,
    String materialType,
    String color,
    double requiredGrams, {
    int? preferredFilamentId,
  }) async {
    final filaments = await Filament.db.find(
      session,
      where: (t) => t.materialType.equals(materialType) & t.color.equals(color),
      orderBy: (t) => t.remainingGrams,
      orderDescending: true,
    );

    Filament? selected;
    String reason = 'none_found';

    if (preferredFilamentId != null) {
      final preferred = await Filament.db.findById(session, preferredFilamentId);
      if (preferred != null && preferred.materialType == materialType && preferred.color == color) {
        selected = preferred;
        reason = 'preferred';
      }
    }

    if (selected == null) {
      final withEnough = filaments.where((f) => f.remainingGrams >= requiredGrams).toList();
      if (withEnough.isNotEmpty) {
        selected = withEnough.first;
        reason = 'most_available_with_stock';
      }
    }

    if (selected == null && filaments.isNotEmpty) {
      selected = filaments.first;
      reason = 'most_available_same_catalog';
    }

    if (selected == null) {
      final lastUsed = await _findLastUsedFilamentForCatalog(session, materialType, color);
      if (lastUsed != null) {
        selected = lastUsed;
        reason = 'last_used_same_catalog';
      }
    }

    if (selected == null) {
      final sameColor = await Filament.db.find(
        session,
        where: (t) => t.color.equals(color),
        orderBy: (t) => t.remainingGrams,
        orderDescending: true,
        limit: 1,
      );
      if (sameColor.isNotEmpty) {
        selected = sameColor.first;
        reason = 'same_color_fallback';
      }
    }

    return jsonEncode({
      'materialType': materialType,
      'color': color,
      'requiredGrams': requiredGrams,
      'selectedFilamentId': selected?.id,
      'selectionReason': reason,
      'hasAvailableStock': selected != null ? selected.remainingGrams > 0 : false,
      'selectedRemainingGrams': selected?.remainingGrams,
      'candidates': filaments
          .map((f) => {
                'filamentId': f.id,
                'name': f.name,
                'brand': f.brand,
                'remainingGrams': f.remainingGrams,
                'isSufficient': f.remainingGrams >= requiredGrams,
              })
          .toList(),
    });
  }

  /// Applies inventory movement when a sale is completed.
  /// If there is not enough stock in a linked spool, auto-corrects by
  /// adding the missing grams first, then discounting used grams.
  Future<String> applySaleFilamentInventoryImpact(
    Session session,
    int saleId, {
    bool autoCorrectIfInsufficient = true,
  }) async {
    final sale = await Sale.db.findById(session, saleId);
    if (sale == null) {
      throw Exception('Sale not found');
    }

    final quoteFilaments = await QuoteFilament.db.find(
      session,
      where: (t) => t.quoteId.equals(sale.quoteId),
    );

    final movements = <Map<String, dynamic>>[];

    for (final qf in quoteFilaments) {
      final filament = await Filament.db.findById(session, qf.filamentId);
      if (filament == null) {
        movements.add({
          'filamentId': qf.filamentId,
          'status': 'missing_filament',
          'usedGrams': qf.gramsUsed,
        });
        continue;
      }

      final before = filament.remainingGrams;
      double added = 0.0;
      if (before < qf.gramsUsed && autoCorrectIfInsufficient) {
        added = qf.gramsUsed - before;
        filament.remainingGrams = before + added;
      }

      filament.remainingGrams = (filament.remainingGrams - qf.gramsUsed).clamp(0.0, double.infinity);
      await Filament.db.updateRow(session, filament);

      movements.add({
        'filamentId': filament.id,
        'name': filament.name,
        'usedGrams': qf.gramsUsed,
        'beforeGrams': before,
        'addedForCorrection': added,
        'afterGrams': filament.remainingGrams,
        'status': added > 0 ? 'auto_corrected' : 'discounted',
      });
    }

    return jsonEncode({
      'saleId': saleId,
      'quoteId': sale.quoteId,
      'autoCorrectIfInsufficient': autoCorrectIfInsufficient,
      'movements': movements,
    });
  }
  
  /// Create filament
  Future<Filament> createFilament(
    Session session,
    String name,
    String brand,
    String materialType,
    String color,
    double spoolWeightKg,
    double spoolCost,
  ) async {
    final filament = Filament(
      name: name,
      brand: brand,
      materialType: materialType,
      color: color,
      spoolWeightKg: spoolWeightKg,
      spoolCost: spoolCost,
      remainingGrams: spoolWeightKg * 1000,
    );
    
    return await Filament.db.insertRow(session, filament);
  }
  
  /// Update filament
  Future<Filament> updateFilament(
    Session session,
    int filamentId,
    String name,
    String brand,
    String materialType,
    String color,
    double spoolWeightKg,
    double spoolCost,
  ) async {
    final filament = await Filament.db.findById(session, filamentId);
    
    if (filament == null) {
      throw Exception('Filament not found');
    }
    
    filament.name = name;
    filament.brand = brand;
    filament.materialType = materialType;
    filament.color = color;
    filament.spoolWeightKg = spoolWeightKg;
    filament.spoolCost = spoolCost;
    
    return await Filament.db.updateRow(session, filament);
  }
  
  /// Delete filament
  Future<void> deleteFilament(Session session, int filamentId) async {
    await Filament.db.deleteWhere(
      session,
      where: (t) => t.id.equals(filamentId),
    );
  }

  // ========== EXTRA SUPPLIES ==========
  
  /// Get all extra supplies
  Future<List<ExtraSupply>> getAllExtraSupplies(Session session) async {
    return await ExtraSupply.db.find(session, orderBy: (t) => t.name);
  }
  
  /// Create extra supply
  Future<ExtraSupply> createExtraSupply(
    Session session,
    String name,
    double cost,
  ) async {
    final supply = ExtraSupply(
      name: name,
      cost: cost,
    );
    
    return await ExtraSupply.db.insertRow(session, supply);
  }
  
  /// Update extra supply
  Future<ExtraSupply> updateExtraSupply(
    Session session,
    int supplyId,
    String name,
    double cost,
  ) async {
    final supply = await ExtraSupply.db.findById(session, supplyId);
    
    if (supply == null) {
      throw Exception('Extra supply not found');
    }
    
    supply.name = name;
    supply.cost = cost;
    
    return await ExtraSupply.db.updateRow(session, supply);
  }
  
  /// Delete extra supply
  Future<void> deleteExtraSupply(Session session, int supplyId) async {
    await ExtraSupply.db.deleteWhere(
      session,
      where: (t) => t.id.equals(supplyId),
    );
  }

  // ========== SHIPPING ==========
  
  /// Get all shipping options
  Future<List<Shipping>> getAllShippings(Session session) async {
    return await Shipping.db.find(session, orderBy: (t) => t.shippingType);
  }
  
  /// Create shipping option
  Future<Shipping> createShipping(
    Session session,
    String shippingType,
    String carrierName,
    double cost,
  ) async {
    final shipping = Shipping(
      shippingType: shippingType,
      carrierName: carrierName,
      cost: cost,
    );
    
    return await Shipping.db.insertRow(session, shipping);
  }
  
  /// Update shipping option
  Future<Shipping> updateShipping(
    Session session,
    int shippingId,
    String shippingType,
    String carrierName,
    double cost,
  ) async {
    final shipping = await Shipping.db.findById(session, shippingId);
    
    if (shipping == null) {
      throw Exception('Shipping not found');
    }
    
    shipping.shippingType = shippingType;
    shipping.carrierName = carrierName;
    shipping.cost = cost;
    
    return await Shipping.db.updateRow(session, shipping);
  }
  
  /// Delete shipping option
  Future<void> deleteShipping(Session session, int shippingId) async {
    await Shipping.db.deleteWhere(
      session,
      where: (t) => t.id.equals(shippingId),
    );
  }

  // ========== ELECTRICITY RATES ==========
  
  /// Get active electricity rate
  Future<ElectricityRate?> getActiveElectricityRate(Session session) async {
    return await ElectricityRate.db.findFirstRow(
      session,
      where: (t) => t.active.equals(true),
    );
  }

  /// Get all electricity rates
  Future<List<ElectricityRate>> getAllElectricityRates(Session session) async {
    return await ElectricityRate.db.find(session, orderBy: (t) => t.id);
  }
  
  /// Create electricity rate
  Future<ElectricityRate> createElectricityRate(
    Session session,
    double costPerKwh,
    bool active,
  ) async {
    // If this rate should be active, deactivate all others
    if (active) {
      final allRates = await ElectricityRate.db.find(session);
      for (var rate in allRates) {
        if (rate.active) {
          rate.active = false;
          await ElectricityRate.db.updateRow(session, rate);
        }
      }
    }
    
    final rate = ElectricityRate(
      costPerKwh: costPerKwh,
      active: active,
    );
    
    return await ElectricityRate.db.insertRow(session, rate);
  }
  
  /// Update electricity rate
  Future<ElectricityRate> updateElectricityRate(
    Session session,
    int rateId,
    double costPerKwh,
    bool active,
  ) async {
    final rate = await ElectricityRate.db.findById(session, rateId);
    
    if (rate == null) {
      throw Exception('Electricity rate not found');
    }
    
    // If this rate should be active, deactivate all others
    if (active && !rate.active) {
      final allRates = await ElectricityRate.db.find(session);
      for (var r in allRates) {
        if (r.active && r.id != rateId) {
          r.active = false;
          await ElectricityRate.db.updateRow(session, r);
        }
      }
    }
    
    rate.costPerKwh = costPerKwh;
    rate.active = active;
    
    return await ElectricityRate.db.updateRow(session, rate);
  }
  
  /// Delete electricity rate
  Future<void> deleteElectricityRate(Session session, int rateId) async {
    await ElectricityRate.db.deleteWhere(
      session,
      where: (t) => t.id.equals(rateId),
    );
  }

  // ========== QUOTE CATEGORIES ==========
  
  /// Get all quote categories
  Future<List<QuoteCategory>> getAllQuoteCategories(Session session) async {
    return await QuoteCategory.db.find(session, orderBy: (t) => t.name);
  }

  /// Get active quote categories only
  Future<List<QuoteCategory>> getActiveQuoteCategories(Session session) async {
    return await QuoteCategory.db.find(
      session,
      where: (t) => t.active.equals(true),
      orderBy: (t) => t.name,
    );
  }
  
  /// Create a new quote category
  Future<QuoteCategory> createQuoteCategory(
    Session session,
    String name,
    bool active, {
    String? description,
    String? icon,
    String? color,
  }) async {
    final category = QuoteCategory(
      name: name,
      description: description,
      icon: icon,
      color: color,
      active: active,
    );
    
    return await QuoteCategory.db.insertRow(session, category);
  }
  
  /// Update quote category
  Future<QuoteCategory> updateQuoteCategory(
    Session session,
    int categoryId,
    String name,
    bool active, {
    String? description,
    String? icon,
    String? color,
  }) async {
    final category = await QuoteCategory.db.findById(session, categoryId);
    if (category == null) {
      throw Exception('Quote category not found');
    }
    
    category.name = name;
    category.description = description;
    category.icon = icon;
    category.color = color;
    category.active = active;
    
    return await QuoteCategory.db.updateRow(session, category);
  }
  
  /// Delete quote category
  Future<void> deleteQuoteCategory(Session session, int categoryId) async {
    await QuoteCategory.db.deleteWhere(
      session,
      where: (t) => t.id.equals(categoryId),
    );
  }
}

