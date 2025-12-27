import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ResourcesEndpoint extends Endpoint {
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

  /// Get all filaments
  Future<List<Filament>> getAllFilaments(Session session) async {
    return await Filament.db.find(session, orderBy: (t) => t.name);
  }

  /// Get all extra supplies
  Future<List<ExtraSupply>> getAllExtraSupplies(Session session) async {
    return await ExtraSupply.db.find(session, orderBy: (t) => t.name);
  }

  /// Get all shipping options
  Future<List<Shipping>> getAllShippings(Session session) async {
    return await Shipping.db.find(session, orderBy: (t) => t.shippingType);
  }

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
}
