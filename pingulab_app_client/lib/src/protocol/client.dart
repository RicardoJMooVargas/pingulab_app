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
import 'package:pingulab_app_client/src/protocol/filament.dart' as _i5;
import 'package:pingulab_app_client/src/protocol/printer.dart' as _i6;
import 'package:pingulab_app_client/src/protocol/shipping.dart' as _i7;
import 'package:pingulab_app_client/src/protocol/customer.dart' as _i8;
import 'package:pingulab_app_client/src/protocol/electricity_rate.dart' as _i9;
import 'package:pingulab_app_client/src/protocol/extra_supply.dart' as _i10;
import 'package:pingulab_app_client/src/protocol/quote.dart' as _i11;
import 'package:pingulab_app_client/src/protocol/quote_input.dart' as _i12;
import 'package:pingulab_app_client/src/protocol/quote_details.dart' as _i13;
import 'package:pingulab_app_client/src/protocol/quote_status.dart' as _i14;
import 'package:pingulab_app_client/src/protocol/greeting.dart' as _i15;
import 'protocol.dart' as _i16;

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

/// Endpoint para gestión de catálogos (listas maestras)
/// {@category Endpoint}
class EndpointCatalogs extends _i1.EndpointRef {
  EndpointCatalogs(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'catalogs';

  _i2.Future<List<_i5.Filament>> getFilaments() =>
      caller.callServerEndpoint<List<_i5.Filament>>(
        'catalogs',
        'getFilaments',
        {},
      );

  _i2.Future<_i5.Filament> createFilament(
    String name,
    String brand,
    String materialType,
    String color,
    double spoolWeightKg,
    double spoolCost,
  ) =>
      caller.callServerEndpoint<_i5.Filament>(
        'catalogs',
        'createFilament',
        {
          'name': name,
          'brand': brand,
          'materialType': materialType,
          'color': color,
          'spoolWeightKg': spoolWeightKg,
          'spoolCost': spoolCost,
        },
      );

  _i2.Future<_i5.Filament> updateFilament(
    int id,
    String name,
    String brand,
    String materialType,
    String color,
    double spoolWeightKg,
    double spoolCost,
  ) =>
      caller.callServerEndpoint<_i5.Filament>(
        'catalogs',
        'updateFilament',
        {
          'id': id,
          'name': name,
          'brand': brand,
          'materialType': materialType,
          'color': color,
          'spoolWeightKg': spoolWeightKg,
          'spoolCost': spoolCost,
        },
      );

  _i2.Future<void> deleteFilament(int id) => caller.callServerEndpoint<void>(
        'catalogs',
        'deleteFilament',
        {'id': id},
      );

  _i2.Future<List<_i6.Printer>> getPrinters() =>
      caller.callServerEndpoint<List<_i6.Printer>>(
        'catalogs',
        'getPrinters',
        {},
      );

  _i2.Future<_i6.Printer> createPrinter(
    String name,
    int powerConsumptionWatts,
    double purchaseCost,
    bool available, {
    String? imageBase64,
  }) =>
      caller.callServerEndpoint<_i6.Printer>(
        'catalogs',
        'createPrinter',
        {
          'name': name,
          'powerConsumptionWatts': powerConsumptionWatts,
          'purchaseCost': purchaseCost,
          'available': available,
          'imageBase64': imageBase64,
        },
      );

  _i2.Future<_i6.Printer> updatePrinter(
    int id,
    String name,
    int powerConsumptionWatts,
    double purchaseCost,
    bool available, {
    String? imageBase64,
  }) =>
      caller.callServerEndpoint<_i6.Printer>(
        'catalogs',
        'updatePrinter',
        {
          'id': id,
          'name': name,
          'powerConsumptionWatts': powerConsumptionWatts,
          'purchaseCost': purchaseCost,
          'available': available,
          'imageBase64': imageBase64,
        },
      );

  _i2.Future<void> deletePrinter(int id) => caller.callServerEndpoint<void>(
        'catalogs',
        'deletePrinter',
        {'id': id},
      );

  _i2.Future<List<_i7.Shipping>> getShippings() =>
      caller.callServerEndpoint<List<_i7.Shipping>>(
        'catalogs',
        'getShippings',
        {},
      );

  _i2.Future<_i7.Shipping> createShipping(
    String shippingType,
    String carrierName,
    double cost,
  ) =>
      caller.callServerEndpoint<_i7.Shipping>(
        'catalogs',
        'createShipping',
        {
          'shippingType': shippingType,
          'carrierName': carrierName,
          'cost': cost,
        },
      );

  _i2.Future<_i7.Shipping> updateShipping(
    int id,
    String shippingType,
    String carrierName,
    double cost,
  ) =>
      caller.callServerEndpoint<_i7.Shipping>(
        'catalogs',
        'updateShipping',
        {
          'id': id,
          'shippingType': shippingType,
          'carrierName': carrierName,
          'cost': cost,
        },
      );

  _i2.Future<void> deleteShipping(int id) => caller.callServerEndpoint<void>(
        'catalogs',
        'deleteShipping',
        {'id': id},
      );

  _i2.Future<List<_i8.Customer>> getCustomers() =>
      caller.callServerEndpoint<List<_i8.Customer>>(
        'catalogs',
        'getCustomers',
        {},
      );

  _i2.Future<_i8.Customer> createCustomer(
    String apodo, {
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i8.Customer>(
        'catalogs',
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

  _i2.Future<_i8.Customer> updateCustomer(
    int id,
    String apodo, {
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i8.Customer>(
        'catalogs',
        'updateCustomer',
        {
          'id': id,
          'apodo': apodo,
          'nombre': nombre,
          'apellido': apellido,
          'numero': numero,
          'direccion': direccion,
          'notes': notes,
        },
      );

  _i2.Future<void> deleteCustomer(int id) => caller.callServerEndpoint<void>(
        'catalogs',
        'deleteCustomer',
        {'id': id},
      );

  _i2.Future<List<_i9.ElectricityRate>> getElectricityRates() =>
      caller.callServerEndpoint<List<_i9.ElectricityRate>>(
        'catalogs',
        'getElectricityRates',
        {},
      );

  _i2.Future<_i9.ElectricityRate> createElectricityRate(
    double costPerKwh,
    bool active,
  ) =>
      caller.callServerEndpoint<_i9.ElectricityRate>(
        'catalogs',
        'createElectricityRate',
        {
          'costPerKwh': costPerKwh,
          'active': active,
        },
      );

  _i2.Future<_i9.ElectricityRate> updateElectricityRate(
    int id,
    double costPerKwh,
    bool active,
  ) =>
      caller.callServerEndpoint<_i9.ElectricityRate>(
        'catalogs',
        'updateElectricityRate',
        {
          'id': id,
          'costPerKwh': costPerKwh,
          'active': active,
        },
      );

  _i2.Future<void> deleteElectricityRate(int id) =>
      caller.callServerEndpoint<void>(
        'catalogs',
        'deleteElectricityRate',
        {'id': id},
      );

  _i2.Future<List<_i10.ExtraSupply>> getExtraSupplies() =>
      caller.callServerEndpoint<List<_i10.ExtraSupply>>(
        'catalogs',
        'getExtraSupplies',
        {},
      );

  _i2.Future<_i10.ExtraSupply> createExtraSupply(
    String name,
    double cost,
  ) =>
      caller.callServerEndpoint<_i10.ExtraSupply>(
        'catalogs',
        'createExtraSupply',
        {
          'name': name,
          'cost': cost,
        },
      );

  _i2.Future<_i10.ExtraSupply> updateExtraSupply(
    int id,
    String name,
    double cost,
  ) =>
      caller.callServerEndpoint<_i10.ExtraSupply>(
        'catalogs',
        'updateExtraSupply',
        {
          'id': id,
          'name': name,
          'cost': cost,
        },
      );

  _i2.Future<void> deleteExtraSupply(int id) => caller.callServerEndpoint<void>(
        'catalogs',
        'deleteExtraSupply',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointCustomer extends _i1.EndpointRef {
  EndpointCustomer(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customer';

  /// Search customers by apodo, nombre or apellido
  _i2.Future<List<_i8.Customer>> searchCustomers(String query) =>
      caller.callServerEndpoint<List<_i8.Customer>>(
        'customer',
        'searchCustomers',
        {'query': query},
      );

  /// Get all customers
  _i2.Future<List<_i8.Customer>> getAllCustomers() =>
      caller.callServerEndpoint<List<_i8.Customer>>(
        'customer',
        'getAllCustomers',
        {},
      );

  /// Get customer by ID
  _i2.Future<_i8.Customer?> getCustomer(int id) =>
      caller.callServerEndpoint<_i8.Customer?>(
        'customer',
        'getCustomer',
        {'id': id},
      );

  /// Create a new customer
  _i2.Future<_i8.Customer> createCustomer(
    String apodo,
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
  ) =>
      caller.callServerEndpoint<_i8.Customer>(
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
  _i2.Future<_i8.Customer> updateCustomer(
    int customerId,
    String apodo,
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
  ) =>
      caller.callServerEndpoint<_i8.Customer>(
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
  _i2.Future<_i11.Quote> createQuote(
    _i12.QuoteInput input, {
    int? userId,
  }) =>
      caller.callServerEndpoint<_i11.Quote>(
        'quote',
        'createQuote',
        {
          'input': input,
          'userId': userId,
        },
      );

  /// Get a quote by ID with all relations
  _i2.Future<_i11.Quote?> getQuote(int id) =>
      caller.callServerEndpoint<_i11.Quote?>(
        'quote',
        'getQuote',
        {'id': id},
      );

  /// Get a quote with all its detailed information
  _i2.Future<_i13.QuoteDetails?> getQuoteDetails(int id) =>
      caller.callServerEndpoint<_i13.QuoteDetails?>(
        'quote',
        'getQuoteDetails',
        {'id': id},
      );

  /// Get all quotes
  _i2.Future<List<_i11.Quote>> getAllQuotes() =>
      caller.callServerEndpoint<List<_i11.Quote>>(
        'quote',
        'getAllQuotes',
        {},
      );

  /// Update an existing quote
  _i2.Future<_i11.Quote> updateQuote(
    int quoteId,
    _i12.QuoteInput input, {
    int? userId,
  }) =>
      caller.callServerEndpoint<_i11.Quote>(
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
  _i2.Future<_i11.Quote> updateQuoteStatus(
    int id,
    _i14.QuoteStatus status,
  ) =>
      caller.callServerEndpoint<_i11.Quote>(
        'quote',
        'updateQuoteStatus',
        {
          'id': id,
          'status': status,
        },
      );
}

/// {@category Endpoint}
class EndpointResources extends _i1.EndpointRef {
  EndpointResources(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'resources';

  /// Get all printers
  _i2.Future<List<_i6.Printer>> getAllPrinters() =>
      caller.callServerEndpoint<List<_i6.Printer>>(
        'resources',
        'getAllPrinters',
        {},
      );

  /// Get available printers only
  _i2.Future<List<_i6.Printer>> getAvailablePrinters() =>
      caller.callServerEndpoint<List<_i6.Printer>>(
        'resources',
        'getAvailablePrinters',
        {},
      );

  /// Create a new printer
  _i2.Future<_i6.Printer> createPrinter(
    String name,
    int powerConsumptionWatts,
    double purchaseCost,
    bool available, {
    String? imageBase64,
  }) =>
      caller.callServerEndpoint<_i6.Printer>(
        'resources',
        'createPrinter',
        {
          'name': name,
          'powerConsumptionWatts': powerConsumptionWatts,
          'purchaseCost': purchaseCost,
          'available': available,
          'imageBase64': imageBase64,
        },
      );

  /// Update printer
  _i2.Future<_i6.Printer> updatePrinter(
    int printerId,
    String name,
    int powerConsumptionWatts,
    double purchaseCost,
    bool available, {
    String? imageBase64,
  }) =>
      caller.callServerEndpoint<_i6.Printer>(
        'resources',
        'updatePrinter',
        {
          'printerId': printerId,
          'name': name,
          'powerConsumptionWatts': powerConsumptionWatts,
          'purchaseCost': purchaseCost,
          'available': available,
          'imageBase64': imageBase64,
        },
      );

  /// Delete printer
  _i2.Future<void> deletePrinter(int printerId) =>
      caller.callServerEndpoint<void>(
        'resources',
        'deletePrinter',
        {'printerId': printerId},
      );

  /// Get all filaments
  _i2.Future<List<_i5.Filament>> getAllFilaments() =>
      caller.callServerEndpoint<List<_i5.Filament>>(
        'resources',
        'getAllFilaments',
        {},
      );

  /// Create filament
  _i2.Future<_i5.Filament> createFilament(
    String name,
    String brand,
    String materialType,
    String color,
    double spoolWeightKg,
    double spoolCost,
  ) =>
      caller.callServerEndpoint<_i5.Filament>(
        'resources',
        'createFilament',
        {
          'name': name,
          'brand': brand,
          'materialType': materialType,
          'color': color,
          'spoolWeightKg': spoolWeightKg,
          'spoolCost': spoolCost,
        },
      );

  /// Update filament
  _i2.Future<_i5.Filament> updateFilament(
    int filamentId,
    String name,
    String brand,
    String materialType,
    String color,
    double spoolWeightKg,
    double spoolCost,
  ) =>
      caller.callServerEndpoint<_i5.Filament>(
        'resources',
        'updateFilament',
        {
          'filamentId': filamentId,
          'name': name,
          'brand': brand,
          'materialType': materialType,
          'color': color,
          'spoolWeightKg': spoolWeightKg,
          'spoolCost': spoolCost,
        },
      );

  /// Delete filament
  _i2.Future<void> deleteFilament(int filamentId) =>
      caller.callServerEndpoint<void>(
        'resources',
        'deleteFilament',
        {'filamentId': filamentId},
      );

  /// Get all extra supplies
  _i2.Future<List<_i10.ExtraSupply>> getAllExtraSupplies() =>
      caller.callServerEndpoint<List<_i10.ExtraSupply>>(
        'resources',
        'getAllExtraSupplies',
        {},
      );

  /// Create extra supply
  _i2.Future<_i10.ExtraSupply> createExtraSupply(
    String name,
    double cost,
  ) =>
      caller.callServerEndpoint<_i10.ExtraSupply>(
        'resources',
        'createExtraSupply',
        {
          'name': name,
          'cost': cost,
        },
      );

  /// Update extra supply
  _i2.Future<_i10.ExtraSupply> updateExtraSupply(
    int supplyId,
    String name,
    double cost,
  ) =>
      caller.callServerEndpoint<_i10.ExtraSupply>(
        'resources',
        'updateExtraSupply',
        {
          'supplyId': supplyId,
          'name': name,
          'cost': cost,
        },
      );

  /// Delete extra supply
  _i2.Future<void> deleteExtraSupply(int supplyId) =>
      caller.callServerEndpoint<void>(
        'resources',
        'deleteExtraSupply',
        {'supplyId': supplyId},
      );

  /// Get all shipping options
  _i2.Future<List<_i7.Shipping>> getAllShippings() =>
      caller.callServerEndpoint<List<_i7.Shipping>>(
        'resources',
        'getAllShippings',
        {},
      );

  /// Create shipping option
  _i2.Future<_i7.Shipping> createShipping(
    String shippingType,
    String carrierName,
    double cost,
  ) =>
      caller.callServerEndpoint<_i7.Shipping>(
        'resources',
        'createShipping',
        {
          'shippingType': shippingType,
          'carrierName': carrierName,
          'cost': cost,
        },
      );

  /// Update shipping option
  _i2.Future<_i7.Shipping> updateShipping(
    int shippingId,
    String shippingType,
    String carrierName,
    double cost,
  ) =>
      caller.callServerEndpoint<_i7.Shipping>(
        'resources',
        'updateShipping',
        {
          'shippingId': shippingId,
          'shippingType': shippingType,
          'carrierName': carrierName,
          'cost': cost,
        },
      );

  /// Delete shipping option
  _i2.Future<void> deleteShipping(int shippingId) =>
      caller.callServerEndpoint<void>(
        'resources',
        'deleteShipping',
        {'shippingId': shippingId},
      );

  /// Get active electricity rate
  _i2.Future<_i9.ElectricityRate?> getActiveElectricityRate() =>
      caller.callServerEndpoint<_i9.ElectricityRate?>(
        'resources',
        'getActiveElectricityRate',
        {},
      );

  /// Get all electricity rates
  _i2.Future<List<_i9.ElectricityRate>> getAllElectricityRates() =>
      caller.callServerEndpoint<List<_i9.ElectricityRate>>(
        'resources',
        'getAllElectricityRates',
        {},
      );

  /// Create electricity rate
  _i2.Future<_i9.ElectricityRate> createElectricityRate(
    double costPerKwh,
    bool active,
  ) =>
      caller.callServerEndpoint<_i9.ElectricityRate>(
        'resources',
        'createElectricityRate',
        {
          'costPerKwh': costPerKwh,
          'active': active,
        },
      );

  /// Update electricity rate
  _i2.Future<_i9.ElectricityRate> updateElectricityRate(
    int rateId,
    double costPerKwh,
    bool active,
  ) =>
      caller.callServerEndpoint<_i9.ElectricityRate>(
        'resources',
        'updateElectricityRate',
        {
          'rateId': rateId,
          'costPerKwh': costPerKwh,
          'active': active,
        },
      );

  /// Delete electricity rate
  _i2.Future<void> deleteElectricityRate(int rateId) =>
      caller.callServerEndpoint<void>(
        'resources',
        'deleteElectricityRate',
        {'rateId': rateId},
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
  _i2.Future<_i15.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i15.Greeting>(
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
          _i16.Protocol(),
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
    catalogs = EndpointCatalogs(this);
    customer = EndpointCustomer(this);
    init = EndpointInit(this);
    quote = EndpointQuote(this);
    resources = EndpointResources(this);
    greeting = EndpointGreeting(this);
  }

  late final EndpointAuth auth;

  late final EndpointCatalogs catalogs;

  late final EndpointCustomer customer;

  late final EndpointInit init;

  late final EndpointQuote quote;

  late final EndpointResources resources;

  late final EndpointGreeting greeting;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'catalogs': catalogs,
        'customer': customer,
        'init': init,
        'quote': quote,
        'resources': resources,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
