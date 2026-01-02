import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ResourcesEndpoint extends Endpoint {
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
}
