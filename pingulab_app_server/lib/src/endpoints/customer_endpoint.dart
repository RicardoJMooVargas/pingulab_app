import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class CustomerEndpoint extends Endpoint {
  /// Search customers by apodo, nombre or apellido
  Future<List<Customer>> searchCustomers(Session session, String query) async {
    if (query.isEmpty) {
      return [];
    }
    
    final searchTerm = '%${query.toLowerCase()}%';
    
    final customers = await Customer.db.find(
      session,
      where: (t) =>
          t.apodo.ilike(searchTerm) |
          t.nombre.ilike(searchTerm) |
          t.apellido.ilike(searchTerm),
      limit: 20,
      orderBy: (t) => t.apodo,
    );
    
    return customers;
  }
  
  /// Get all customers
  Future<List<Customer>> getAllCustomers(Session session) async {
    return await Customer.db.find(
      session,
      orderBy: (t) => t.apodo,
    );
  }
  
  /// Get customer by ID
  Future<Customer?> getCustomer(Session session, int id) async {
    return await Customer.db.findById(session, id);
  }
}
