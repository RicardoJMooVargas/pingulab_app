import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Endpoint para gestión de catálogos (listas maestras)
class CatalogsEndpoint extends Endpoint {
  
  // ========== FILAMENTS ==========
  
  Future<List<Filament>> getFilaments(Session session) async {
    return await Filament.db.find(session, orderBy: (t) => t.name);
  }
  
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
  
  Future<Filament> updateFilament(
    Session session,
    int id,
    String name,
    String brand,
    String materialType,
    String color,
    double spoolWeightKg,
    double spoolCost,
  ) async {
    final filament = await Filament.db.findById(session, id);
    if (filament == null) throw Exception('Filament not found');
    
    filament.name = name;
    filament.brand = brand;
    filament.materialType = materialType;
    filament.color = color;
    filament.spoolWeightKg = spoolWeightKg;
    filament.spoolCost = spoolCost;
    
    return await Filament.db.updateRow(session, filament);
  }
  
  Future<void> deleteFilament(Session session, int id) async {
    await Filament.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
  
  // ========== PRINTERS ==========
  
  Future<List<Printer>> getPrinters(Session session) async {
    return await Printer.db.find(session, orderBy: (t) => t.name);
  }
  
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
  
  Future<Printer> updatePrinter(
    Session session,
    int id,
    String name,
    int powerConsumptionWatts,
    double purchaseCost,
    bool available, {
    String? imageBase64,
  }) async {
    final printer = await Printer.db.findById(session, id);
    if (printer == null) throw Exception('Printer not found');
    
    printer.name = name;
    printer.powerConsumptionWatts = powerConsumptionWatts;
    printer.purchaseCost = purchaseCost;
    printer.imageBase64 = imageBase64;
    printer.available = available;
    
    return await Printer.db.updateRow(session, printer);
  }
  
  Future<void> deletePrinter(Session session, int id) async {
    await Printer.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
  
  // ========== SHIPPINGS ==========
  
  Future<List<Shipping>> getShippings(Session session) async {
    return await Shipping.db.find(session, orderBy: (t) => t.shippingType);
  }
  
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
  
  Future<Shipping> updateShipping(
    Session session,
    int id,
    String shippingType,
    String carrierName,
    double cost,
  ) async {
    final shipping = await Shipping.db.findById(session, id);
    if (shipping == null) throw Exception('Shipping not found');
    
    shipping.shippingType = shippingType;
    shipping.carrierName = carrierName;
    shipping.cost = cost;
    
    return await Shipping.db.updateRow(session, shipping);
  }
  
  Future<void> deleteShipping(Session session, int id) async {
    await Shipping.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
  
  // ========== CUSTOMERS ==========
  
  Future<List<Customer>> getCustomers(Session session) async {
    return await Customer.db.find(session, orderBy: (t) => t.apodo);
  }
  
  Future<Customer> createCustomer(
    Session session,
    String apodo, {
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
  }) async {
    final customer = Customer(
      apodo: apodo,
      nombre: nombre,
      apellido: apellido,
      numero: numero,
      direccion: direccion,
      notes: notes,
      created: DateTime.now(),
    );
    return await Customer.db.insertRow(session, customer);
  }
  
  Future<Customer> updateCustomer(
    Session session,
    int id,
    String apodo, {
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
  }) async {
    final customer = await Customer.db.findById(session, id);
    if (customer == null) throw Exception('Customer not found');
    
    customer.apodo = apodo;
    customer.nombre = nombre;
    customer.apellido = apellido;
    customer.numero = numero;
    customer.direccion = direccion;
    customer.notes = notes;
    customer.updated = DateTime.now();
    
    return await Customer.db.updateRow(session, customer);
  }
  
  Future<void> deleteCustomer(Session session, int id) async {
    await Customer.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
  
  // ========== ELECTRICITY RATES ==========
  
  Future<List<ElectricityRate>> getElectricityRates(Session session) async {
    return await ElectricityRate.db.find(session);
  }
  
  Future<ElectricityRate> createElectricityRate(
    Session session,
    double costPerKwh,
    bool active,
  ) async {
    // Desactivar todas las tarifas anteriores si esta es activa
    if (active) {
      final rates = await ElectricityRate.db.find(session);
      for (final rate in rates) {
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
  
  Future<ElectricityRate> updateElectricityRate(
    Session session,
    int id,
    double costPerKwh,
    bool active,
  ) async {
    final rate = await ElectricityRate.db.findById(session, id);
    if (rate == null) throw Exception('Electricity rate not found');
    
    // Desactivar todas las tarifas anteriores si esta se activa
    if (active && !rate.active) {
      final rates = await ElectricityRate.db.find(session);
      for (final r in rates) {
        if (r.active && r.id != id) {
          r.active = false;
          await ElectricityRate.db.updateRow(session, r);
        }
      }
    }
    
    rate.costPerKwh = costPerKwh;
    rate.active = active;
    
    return await ElectricityRate.db.updateRow(session, rate);
  }
  
  Future<void> deleteElectricityRate(Session session, int id) async {
    await ElectricityRate.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
  
  // ========== EXTRA SUPPLIES ==========
  
  Future<List<ExtraSupply>> getExtraSupplies(Session session) async {
    return await ExtraSupply.db.find(session, orderBy: (t) => t.name);
  }
  
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
  
  Future<ExtraSupply> updateExtraSupply(
    Session session,
    int id,
    String name,
    double cost,
  ) async {
    final supply = await ExtraSupply.db.findById(session, id);
    if (supply == null) throw Exception('Extra supply not found');
    
    supply.name = name;
    supply.cost = cost;
    
    return await ExtraSupply.db.updateRow(session, supply);
  }
  
  Future<void> deleteExtraSupply(Session session, int id) async {
    await ExtraSupply.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
