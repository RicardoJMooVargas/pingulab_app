/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/customer_endpoint.dart' as _i2;
import '../endpoints/quote_endpoint.dart' as _i3;
import '../endpoints/resources_endpoint.dart' as _i4;
import '../greeting_endpoint.dart' as _i5;
import 'package:pingulab_app_server/src/generated/quote_input.dart' as _i6;
import 'package:pingulab_app_server/src/generated/quote_status.dart' as _i7;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'customer': _i2.CustomerEndpoint()
        ..initialize(
          server,
          'customer',
          null,
        ),
      'quote': _i3.QuoteEndpoint()
        ..initialize(
          server,
          'quote',
          null,
        ),
      'resources': _i4.ResourcesEndpoint()
        ..initialize(
          server,
          'resources',
          null,
        ),
      'greeting': _i5.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['customer'] = _i1.EndpointConnector(
      name: 'customer',
      endpoint: endpoints['customer']!,
      methodConnectors: {
        'searchCustomers': _i1.MethodConnector(
          name: 'searchCustomers',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['customer'] as _i2.CustomerEndpoint).searchCustomers(
            session,
            params['query'],
          ),
        ),
        'getAllCustomers': _i1.MethodConnector(
          name: 'getAllCustomers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['customer'] as _i2.CustomerEndpoint)
                  .getAllCustomers(session),
        ),
        'getCustomer': _i1.MethodConnector(
          name: 'getCustomer',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['customer'] as _i2.CustomerEndpoint).getCustomer(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['quote'] = _i1.EndpointConnector(
      name: 'quote',
      endpoint: endpoints['quote']!,
      methodConnectors: {
        'createQuote': _i1.MethodConnector(
          name: 'createQuote',
          params: {
            'input': _i1.ParameterDescription(
              name: 'input',
              type: _i1.getType<_i6.QuoteInput>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i3.QuoteEndpoint).createQuote(
            session,
            params['input'],
          ),
        ),
        'getQuote': _i1.MethodConnector(
          name: 'getQuote',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i3.QuoteEndpoint).getQuote(
            session,
            params['id'],
          ),
        ),
        'getQuoteDetails': _i1.MethodConnector(
          name: 'getQuoteDetails',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i3.QuoteEndpoint).getQuoteDetails(
            session,
            params['id'],
          ),
        ),
        'getAllQuotes': _i1.MethodConnector(
          name: 'getAllQuotes',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i3.QuoteEndpoint).getAllQuotes(session),
        ),
        'updateQuote': _i1.MethodConnector(
          name: 'updateQuote',
          params: {
            'quoteId': _i1.ParameterDescription(
              name: 'quoteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'input': _i1.ParameterDescription(
              name: 'input',
              type: _i1.getType<_i6.QuoteInput>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i3.QuoteEndpoint).updateQuote(
            session,
            params['quoteId'],
            params['input'],
          ),
        ),
        'deleteQuote': _i1.MethodConnector(
          name: 'deleteQuote',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i3.QuoteEndpoint).deleteQuote(
            session,
            params['id'],
          ),
        ),
        'updateQuoteStatus': _i1.MethodConnector(
          name: 'updateQuoteStatus',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i7.QuoteStatus>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i3.QuoteEndpoint).updateQuoteStatus(
            session,
            params['id'],
            params['status'],
          ),
        ),
      },
    );
    connectors['resources'] = _i1.EndpointConnector(
      name: 'resources',
      endpoint: endpoints['resources']!,
      methodConnectors: {
        'getAllPrinters': _i1.MethodConnector(
          name: 'getAllPrinters',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i4.ResourcesEndpoint)
                  .getAllPrinters(session),
        ),
        'getAvailablePrinters': _i1.MethodConnector(
          name: 'getAvailablePrinters',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i4.ResourcesEndpoint)
                  .getAvailablePrinters(session),
        ),
        'getAllFilaments': _i1.MethodConnector(
          name: 'getAllFilaments',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i4.ResourcesEndpoint)
                  .getAllFilaments(session),
        ),
        'getAllExtraSupplies': _i1.MethodConnector(
          name: 'getAllExtraSupplies',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i4.ResourcesEndpoint)
                  .getAllExtraSupplies(session),
        ),
        'getAllShippings': _i1.MethodConnector(
          name: 'getAllShippings',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i4.ResourcesEndpoint)
                  .getAllShippings(session),
        ),
        'getActiveElectricityRate': _i1.MethodConnector(
          name: 'getActiveElectricityRate',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i4.ResourcesEndpoint)
                  .getActiveElectricityRate(session),
        ),
        'getAllElectricityRates': _i1.MethodConnector(
          name: 'getAllElectricityRates',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i4.ResourcesEndpoint)
                  .getAllElectricityRates(session),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['greeting'] as _i5.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
  }
}
