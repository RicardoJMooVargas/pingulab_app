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
  
  /// Create a new customer
  Future<Customer> createCustomer(
    Session session,
    String apodo,
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
  ) async {
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
  
  /// Update an existing customer
  Future<Customer> updateCustomer(
    Session session,
    int customerId,
    String apodo,
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
  ) async {
    final customer = await Customer.db.findById(session, customerId);
    
    if (customer == null) {
      throw Exception('Customer not found');
    }
    
    customer.apodo = apodo;
    customer.nombre = nombre;
    customer.apellido = apellido;
    customer.numero = numero;
    customer.direccion = direccion;
    customer.notes = notes;
    customer.updated = DateTime.now();
    
    return await Customer.db.updateRow(session, customer);
  }
  
  /// Delete a customer
  Future<void> deleteCustomer(Session session, int customerId) async {
    // Check if customer is used in any quotes
    final quotesWithCustomer = await Quote.db.find(
      session,
      where: (t) => t.customerId.equals(customerId),
      limit: 1,
    );
    
    if (quotesWithCustomer.isNotEmpty) {
      throw Exception('Cannot delete customer: used in existing quotes');
    }
    
    await Customer.db.deleteWhere(
      session,
      where: (t) => t.id.equals(customerId),
    );
  }
}
