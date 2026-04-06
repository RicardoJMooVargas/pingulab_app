/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:pingulab_app_client/src/protocol/user.dart' as _i3;
import 'package:pingulab_app_client/src/protocol/user_role.dart' as _i4;
import 'package:pingulab_app_client/src/protocol/customer.dart' as _i5;
import 'package:pingulab_app_client/src/protocol/quote.dart' as _i6;
import 'package:pingulab_app_client/src/protocol/quote_input.dart' as _i7;
import 'package:pingulab_app_client/src/protocol/quote_details.dart' as _i8;
import 'package:pingulab_app_client/src/protocol/quote_status.dart' as _i9;
import 'package:pingulab_app_client/src/protocol/quote_version.dart' as _i10;
import 'package:pingulab_app_client/src/protocol/sale.dart' as _i11;
import 'package:pingulab_app_client/src/protocol/sale_status.dart' as _i12;
import 'package:pingulab_app_client/src/protocol/payment_status.dart' as _i13;
import 'package:pingulab_app_client/src/protocol/greeting.dart' as _i14;
import 'protocol.dart' as _i15;

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// Register a new user
  _i2.Future<_i3.User> register(
    String email,
    String password,
    String nombre,
    String? apellido,
    _i4.UserRole rol,
  ) =>
      caller.callServerEndpoint<_i3.User>(
        'auth',
        'register',
        {
          'email': email,
          'password': password,
          'nombre': nombre,
          'apellido': apellido,
          'rol': rol,
        },
      );

  /// Login user
  _i2.Future<_i3.User?> login(
    String email,
    String password,
  ) =>
      caller.callServerEndpoint<_i3.User?>(
        'auth',
        'login',
        {
          'email': email,
          'password': password,
        },
      );

  /// Change password
  _i2.Future<bool> changePassword(
    int userId,
    String oldPassword,
    String newPassword,
  ) =>
      caller.callServerEndpoint<bool>(
        'auth',
        'changePassword',
        {
          'userId': userId,
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );

  /// Get user by ID
  _i2.Future<_i3.User?> getUserById(int userId) =>
      caller.callServerEndpoint<_i3.User?>(
        'auth',
        'getUserById',
        {'userId': userId},
      );

  /// Get all users
  _i2.Future<List<_i3.User>> getAllUsers() =>
      caller.callServerEndpoint<List<_i3.User>>(
        'auth',
        'getAllUsers',
        {},
      );

  /// Update user
  _i2.Future<_i3.User> updateUser(
    int userId,
    String nombre,
    String? apellido,
    _i4.UserRole rol,
    bool activo,
  ) =>
      caller.callServerEndpoint<_i3.User>(
        'auth',
        'updateUser',
        {
          'userId': userId,
          'nombre': nombre,
          'apellido': apellido,
          'rol': rol,
          'activo': activo,
        },
      );

  /// Deactivate user
  _i2.Future<_i3.User> deactivateUser(int userId) =>
      caller.callServerEndpoint<_i3.User>(
        'auth',
        'deactivateUser',
        {'userId': userId},
      );

  /// Activate user
  _i2.Future<_i3.User> activateUser(int userId) =>
      caller.callServerEndpoint<_i3.User>(
        'auth',
        'activateUser',
        {'userId': userId},
      );

  /// Reset password (admin only)
  _i2.Future<String> resetPassword(int userId) =>
      caller.callServerEndpoint<String>(
        'auth',
        'resetPassword',
        {'userId': userId},
      );
}

/// {@category Endpoint}
class EndpointBackup extends _i1.EndpointRef {
  EndpointBackup(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'backup';

  /// Exporta todos los datos de todas las tablas en formato JSON
  _i2.Future<String> exportDatabase() => caller.callServerEndpoint<String>(
        'backup',
        'exportDatabase',
        {},
      );

  /// Importa datos con validación
  _i2.Future<String> importDatabase(String jsonData) =>
      caller.callServerEndpoint<String>(
        'backup',
        'importDatabase',
        {'jsonData': jsonData},
      );
}

/// {@category Endpoint}
class EndpointCustomer extends _i1.EndpointRef {
  EndpointCustomer(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customer';

  /// Search customers by apodo, nombre or apellido
  _i2.Future<List<_i5.Customer>> searchCustomers(String query) =>
      caller.callServerEndpoint<List<_i5.Customer>>(
        'customer',
        'searchCustomers',
        {'query': query},
      );

  /// Get all customers
  _i2.Future<List<_i5.Customer>> getAllCustomers() =>
      caller.callServerEndpoint<List<_i5.Customer>>(
        'customer',
        'getAllCustomers',
        {},
      );

  /// Get customer by ID
  _i2.Future<_i5.Customer?> getCustomer(int id) =>
      caller.callServerEndpoint<_i5.Customer?>(
        'customer',
        'getCustomer',
        {'id': id},
      );

  /// Create a new customer
  _i2.Future<_i5.Customer> createCustomer(
    String apodo,
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
  ) =>
      caller.callServerEndpoint<_i5.Customer>(
        'customer',
        'createCustomer',
        {
          'apodo': apodo,
          'nombre': nombre,
          'apellido': apellido,
          'numero': numero,
          'direccion': direccion,
          'notes': notes,
        },
      );

  /// Update an existing customer
  _i2.Future<_i5.Customer> updateCustomer(
    int customerId,
    String apodo,
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
  ) =>
      caller.callServerEndpoint<_i5.Customer>(
        'customer',
        'updateCustomer',
        {
          'customerId': customerId,
          'apodo': apodo,
          'nombre': nombre,
          'apellido': apellido,
          'numero': numero,
          'direccion': direccion,
          'notes': notes,
        },
      );

  /// Delete a customer
  _i2.Future<void> deleteCustomer(int customerId) =>
      caller.callServerEndpoint<void>(
        'customer',
        'deleteCustomer',
        {'customerId': customerId},
      );
}

/// Endpoint para inicialización de la base de datos
/// Crea datos por defecto si no existen
/// {@category Endpoint}
class EndpointInit extends _i1.EndpointRef {
  EndpointInit(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'init';

  /// Inicializa la base de datos con datos por defecto
  /// Retorna true si se inicializó, false si ya estaba inicializada
  _i2.Future<bool> initializeDatabase() => caller.callServerEndpoint<bool>(
        'init',
        'initializeDatabase',
        {},
      );

  /// Verifica si la base de datos está inicializada
  _i2.Future<bool> isDatabaseInitialized() => caller.callServerEndpoint<bool>(
        'init',
        'isDatabaseInitialized',
        {},
      );
}

/// {@category Endpoint}
class EndpointQuote extends _i1.EndpointRef {
  EndpointQuote(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'quote';

  /// Create a new quote from input data
  _i2.Future<_i6.Quote> createQuote(
    _i7.QuoteInput input, {
    int? userId,
  }) =>
      caller.callServerEndpoint<_i6.Quote>(
        'quote',
        'createQuote',
        {
          'input': input,
          'userId': userId,
        },
      );

  /// Get a quote by ID with all relations
  _i2.Future<_i6.Quote?> getQuote(int id) =>
      caller.callServerEndpoint<_i6.Quote?>(
        'quote',
        'getQuote',
        {'id': id},
      );

  /// Get a quote with all its detailed information
  _i2.Future<_i8.QuoteDetails?> getQuoteDetails(int id) =>
      caller.callServerEndpoint<_i8.QuoteDetails?>(
        'quote',
        'getQuoteDetails',
        {'id': id},
      );

  /// Get all quotes
  _i2.Future<List<_i6.Quote>> getAllQuotes() =>
      caller.callServerEndpoint<List<_i6.Quote>>(
        'quote',
        'getAllQuotes',
        {},
      );

  /// Get quotes with pagination and optional filtering
  _i2.Future<List<_i6.Quote>> getQuotesPaginated({
    required int limit,
    required int offset,
    _i9.QuoteStatus? status,
    int? customerId,
  }) =>
      caller.callServerEndpoint<List<_i6.Quote>>(
        'quote',
        'getQuotesPaginated',
        {
          'limit': limit,
          'offset': offset,
          'status': status,
          'customerId': customerId,
        },
      );

  /// Update an existing quote
  _i2.Future<_i6.Quote> updateQuote(
    int quoteId,
    _i7.QuoteInput input, {
    int? userId,
  }) =>
      caller.callServerEndpoint<_i6.Quote>(
        'quote',
        'updateQuote',
        {
          'quoteId': quoteId,
          'input': input,
          'userId': userId,
        },
      );

  /// Delete a quote
  _i2.Future<void> deleteQuote(int id) => caller.callServerEndpoint<void>(
        'quote',
        'deleteQuote',
        {'id': id},
      );

  /// Update quote status
  _i2.Future<_i6.Quote> updateQuoteStatus(
    int id,
    _i9.QuoteStatus status,
  ) =>
      caller.callServerEndpoint<_i6.Quote>(
        'quote',
        'updateQuoteStatus',
        {
          'id': id,
          'status': status,
        },
      );
}

/// {@category Endpoint}
class EndpointQuoteVersion extends _i1.EndpointRef {
  EndpointQuoteVersion(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'quoteVersion';

  /// Get all versions for a quote
  _i2.Future<List<_i10.QuoteVersion>> getQuoteVersions(int quoteId) =>
      caller.callServerEndpoint<List<_i10.QuoteVersion>>(
        'quoteVersion',
        'getQuoteVersions',
        {'quoteId': quoteId},
      );

  /// Get primary version for a quote
  _i2.Future<_i10.QuoteVersion?> getPrimaryVersion(int quoteId) =>
      caller.callServerEndpoint<_i10.QuoteVersion?>(
        'quoteVersion',
        'getPrimaryVersion',
        {'quoteId': quoteId},
      );

  /// Create new version from current quote
  _i2.Future<_i10.QuoteVersion> createVersionFromQuote(
    int quoteId,
    String? versionName,
    bool isPrimary,
    int? userId,
  ) =>
      caller.callServerEndpoint<_i10.QuoteVersion>(
        'quoteVersion',
        'createVersionFromQuote',
        {
          'quoteId': quoteId,
          'versionName': versionName,
          'isPrimary': isPrimary,
          'userId': userId,
        },
      );

  /// Set version as primary
  _i2.Future<void> setPrimaryVersion(int versionId) =>
      caller.callServerEndpoint<void>(
        'quoteVersion',
        'setPrimaryVersion',
        {'versionId': versionId},
      );

  /// Apply version to quote (update quote with version data)
  _i2.Future<_i6.Quote> applyVersionToQuote(
    int versionId,
    int? userId,
  ) =>
      caller.callServerEndpoint<_i6.Quote>(
        'quoteVersion',
        'applyVersionToQuote',
        {
          'versionId': versionId,
          'userId': userId,
        },
      );

  /// Delete version
  _i2.Future<void> deleteVersion(int versionId) =>
      caller.callServerEndpoint<void>(
        'quoteVersion',
        'deleteVersion',
        {'versionId': versionId},
      );
}

/// Endpoint for managing sales operations.
/// Handles conversion from quotes to sales, status tracking, and payment management.
/// {@category Endpoint}
class EndpointSales extends _i1.EndpointRef {
  EndpointSales(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'sales';

  /// Get all sales with optional filtering by status
  _i2.Future<List<_i11.Sale>> getAllSales({
    _i12.SaleStatus? status,
    _i13.PaymentStatus? paymentStatus,
  }) =>
      caller.callServerEndpoint<List<_i11.Sale>>(
        'sales',
        'getAllSales',
        {
          'status': status,
          'paymentStatus': paymentStatus,
        },
      );

  /// Get sales with pagination and optional filtering
  _i2.Future<List<_i11.Sale>> getSalesPaginated({
    required int limit,
    required int offset,
    _i12.SaleStatus? status,
    _i13.PaymentStatus? paymentStatus,
    int? customerId,
  }) =>
      caller.callServerEndpoint<List<_i11.Sale>>(
        'sales',
        'getSalesPaginated',
        {
          'limit': limit,
          'offset': offset,
          'status': status,
          'paymentStatus': paymentStatus,
          'customerId': customerId,
        },
      );

  /// Get a specific sale by ID
  _i2.Future<_i11.Sale?> getSaleById(int saleId) =>
      caller.callServerEndpoint<_i11.Sale?>(
        'sales',
        'getSaleById',
        {'saleId': saleId},
      );

  /// Get sales by quote ID
  _i2.Future<List<_i11.Sale>> getSalesByQuoteId(int quoteId) =>
      caller.callServerEndpoint<List<_i11.Sale>>(
        'sales',
        'getSalesByQuoteId',
        {'quoteId': quoteId},
      );

  /// Convert a quote to a sale
  _i2.Future<_i11.Sale> convertQuoteToSale(
    int quoteId, {
    int? quoteVersionId,
    int? customerId,
    _i12.SaleStatus? initialStatus,
    _i13.PaymentStatus? initialPaymentStatus,
    double? paidAmount,
    DateTime? scheduledDeliveryDate,
    String? customerName,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i11.Sale>(
        'sales',
        'convertQuoteToSale',
        {
          'quoteId': quoteId,
          'quoteVersionId': quoteVersionId,
          'customerId': customerId,
          'initialStatus': initialStatus,
          'initialPaymentStatus': initialPaymentStatus,
          'paidAmount': paidAmount,
          'scheduledDeliveryDate': scheduledDeliveryDate,
          'customerName': customerName,
          'notes': notes,
        },
      );

  /// Update sale status
  _i2.Future<_i11.Sale> updateSaleStatus(
    int saleId,
    _i12.SaleStatus newStatus, {
    String? notes,
  }) =>
      caller.callServerEndpoint<_i11.Sale>(
        'sales',
        'updateSaleStatus',
        {
          'saleId': saleId,
          'newStatus': newStatus,
          'notes': notes,
        },
      );

  /// Update payment status and paid amount
  _i2.Future<_i11.Sale> updatePaymentStatus(
    int saleId,
    _i13.PaymentStatus newPaymentStatus, {
    double? paidAmount,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i11.Sale>(
        'sales',
        'updatePaymentStatus',
        {
          'saleId': saleId,
          'newPaymentStatus': newPaymentStatus,
          'paidAmount': paidAmount,
          'notes': notes,
        },
      );

  /// Update delivery scheduling
  _i2.Future<_i11.Sale> updateDeliverySchedule(
    int saleId, {
    DateTime? scheduledDeliveryDate,
    DateTime? reminderDate,
    DateTime? actualDeliveryDate,
  }) =>
      caller.callServerEndpoint<_i11.Sale>(
        'sales',
        'updateDeliverySchedule',
        {
          'saleId': saleId,
          'scheduledDeliveryDate': scheduledDeliveryDate,
          'reminderDate': reminderDate,
          'actualDeliveryDate': actualDeliveryDate,
        },
      );

  /// Update sale notes
  _i2.Future<_i11.Sale> updateSaleNotes(
    int saleId,
    String notes,
  ) =>
      caller.callServerEndpoint<_i11.Sale>(
        'sales',
        'updateSaleNotes',
        {
          'saleId': saleId,
          'notes': notes,
        },
      );

  /// Delete a sale
  _i2.Future<bool> deleteSale(int saleId) => caller.callServerEndpoint<bool>(
        'sales',
        'deleteSale',
        {'saleId': saleId},
      );

  /// Get sales statistics
  _i2.Future<Map<String, dynamic>> getSalesStatistics({
    DateTime? fromDate,
    DateTime? toDate,
  }) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'sales',
        'getSalesStatistics',
        {
          'fromDate': fromDate,
          'toDate': toDate,
        },
      );

  /// Get upcoming deliveries (scheduled for the next N days)
  _i2.Future<List<_i11.Sale>> getUpcomingDeliveries({required int daysAhead}) =>
      caller.callServerEndpoint<List<_i11.Sale>>(
        'sales',
        'getUpcomingDeliveries',
        {'daysAhead': daysAhead},
      );

  /// Get overdue deliveries (scheduled delivery date passed but not delivered)
  _i2.Future<List<_i11.Sale>> getOverdueDeliveries() =>
      caller.callServerEndpoint<List<_i11.Sale>>(
        'sales',
        'getOverdueDeliveries',
        {},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i14.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i14.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i15.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    auth = EndpointAuth(this);
    backup = EndpointBackup(this);
    customer = EndpointCustomer(this);
    init = EndpointInit(this);
    quote = EndpointQuote(this);
    quoteVersion = EndpointQuoteVersion(this);
    sales = EndpointSales(this);
    greeting = EndpointGreeting(this);
  }

  late final EndpointAuth auth;

  late final EndpointBackup backup;

  late final EndpointCustomer customer;

  late final EndpointInit init;

  late final EndpointQuote quote;

  late final EndpointQuoteVersion quoteVersion;

  late final EndpointSales sales;

  late final EndpointGreeting greeting;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'backup': backup,
        'customer': customer,
        'init': init,
        'quote': quote,
        'quoteVersion': quoteVersion,
        'sales': sales,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
