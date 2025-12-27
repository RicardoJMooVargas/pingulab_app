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
import 'package:pingulab_app_client/src/protocol/quote.dart' as _i3;
import 'package:pingulab_app_client/src/protocol/quote_input.dart' as _i4;
import 'package:pingulab_app_client/src/protocol/quote_details.dart' as _i5;
import 'package:pingulab_app_client/src/protocol/quote_status.dart' as _i6;
import 'package:pingulab_app_client/src/protocol/printer.dart' as _i7;
import 'package:pingulab_app_client/src/protocol/filament.dart' as _i8;
import 'package:pingulab_app_client/src/protocol/extra_supply.dart' as _i9;
import 'package:pingulab_app_client/src/protocol/shipping.dart' as _i10;
import 'package:pingulab_app_client/src/protocol/electricity_rate.dart' as _i11;
import 'package:pingulab_app_client/src/protocol/greeting.dart' as _i12;
import 'protocol.dart' as _i13;

/// {@category Endpoint}
class EndpointQuote extends _i1.EndpointRef {
  EndpointQuote(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'quote';

  /// Create a new quote from input data
  _i2.Future<_i3.Quote> createQuote(_i4.QuoteInput input) =>
      caller.callServerEndpoint<_i3.Quote>(
        'quote',
        'createQuote',
        {'input': input},
      );

  /// Get a quote by ID with all relations
  _i2.Future<_i3.Quote?> getQuote(int id) =>
      caller.callServerEndpoint<_i3.Quote?>(
        'quote',
        'getQuote',
        {'id': id},
      );

  /// Get a quote with all its detailed information
  _i2.Future<_i5.QuoteDetails?> getQuoteDetails(int id) =>
      caller.callServerEndpoint<_i5.QuoteDetails?>(
        'quote',
        'getQuoteDetails',
        {'id': id},
      );

  /// Get all quotes
  _i2.Future<List<_i3.Quote>> getAllQuotes() =>
      caller.callServerEndpoint<List<_i3.Quote>>(
        'quote',
        'getAllQuotes',
        {},
      );

  /// Update an existing quote
  _i2.Future<_i3.Quote> updateQuote(
    int quoteId,
    _i4.QuoteInput input,
  ) =>
      caller.callServerEndpoint<_i3.Quote>(
        'quote',
        'updateQuote',
        {
          'quoteId': quoteId,
          'input': input,
        },
      );

  /// Delete a quote
  _i2.Future<void> deleteQuote(int id) => caller.callServerEndpoint<void>(
        'quote',
        'deleteQuote',
        {'id': id},
      );

  /// Update quote status
  _i2.Future<_i3.Quote> updateQuoteStatus(
    int id,
    _i6.QuoteStatus status,
  ) =>
      caller.callServerEndpoint<_i3.Quote>(
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
  _i2.Future<List<_i7.Printer>> getAllPrinters() =>
      caller.callServerEndpoint<List<_i7.Printer>>(
        'resources',
        'getAllPrinters',
        {},
      );

  /// Get available printers only
  _i2.Future<List<_i7.Printer>> getAvailablePrinters() =>
      caller.callServerEndpoint<List<_i7.Printer>>(
        'resources',
        'getAvailablePrinters',
        {},
      );

  /// Get all filaments
  _i2.Future<List<_i8.Filament>> getAllFilaments() =>
      caller.callServerEndpoint<List<_i8.Filament>>(
        'resources',
        'getAllFilaments',
        {},
      );

  /// Get all extra supplies
  _i2.Future<List<_i9.ExtraSupply>> getAllExtraSupplies() =>
      caller.callServerEndpoint<List<_i9.ExtraSupply>>(
        'resources',
        'getAllExtraSupplies',
        {},
      );

  /// Get all shipping options
  _i2.Future<List<_i10.Shipping>> getAllShippings() =>
      caller.callServerEndpoint<List<_i10.Shipping>>(
        'resources',
        'getAllShippings',
        {},
      );

  /// Get active electricity rate
  _i2.Future<_i11.ElectricityRate?> getActiveElectricityRate() =>
      caller.callServerEndpoint<_i11.ElectricityRate?>(
        'resources',
        'getActiveElectricityRate',
        {},
      );

  /// Get all electricity rates
  _i2.Future<List<_i11.ElectricityRate>> getAllElectricityRates() =>
      caller.callServerEndpoint<List<_i11.ElectricityRate>>(
        'resources',
        'getAllElectricityRates',
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
  _i2.Future<_i12.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i12.Greeting>(
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
          _i13.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    quote = EndpointQuote(this);
    resources = EndpointResources(this);
    greeting = EndpointGreeting(this);
  }

  late final EndpointQuote quote;

  late final EndpointResources resources;

  late final EndpointGreeting greeting;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'quote': quote,
        'resources': resources,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
