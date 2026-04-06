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
import '../endpoints/auth_endpoint.dart' as _i2;
import '../endpoints/backup_endpoint.dart' as _i3;
import '../endpoints/customer_endpoint.dart' as _i4;
import '../endpoints/init_endpoint.dart' as _i5;
import '../endpoints/quote_endpoint.dart' as _i6;
import '../endpoints/quote_version_endpoint.dart' as _i7;
import '../endpoints/sales_endpoint.dart' as _i8;
import '../greeting_endpoint.dart' as _i9;
import 'package:pingulab_app_server/src/generated/user_role.dart' as _i10;
import 'package:pingulab_app_server/src/generated/quote_input.dart' as _i11;
import 'package:pingulab_app_server/src/generated/quote_status.dart' as _i12;
import 'package:pingulab_app_server/src/generated/sale_status.dart' as _i13;
import 'package:pingulab_app_server/src/generated/payment_status.dart' as _i14;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'auth': _i2.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'backup': _i3.BackupEndpoint()
        ..initialize(
          server,
          'backup',
          null,
        ),
      'customer': _i4.CustomerEndpoint()
        ..initialize(
          server,
          'customer',
          null,
        ),
      'init': _i5.InitEndpoint()
        ..initialize(
          server,
          'init',
          null,
        ),
      'quote': _i6.QuoteEndpoint()
        ..initialize(
          server,
          'quote',
          null,
        ),
      'quoteVersion': _i7.QuoteVersionEndpoint()
        ..initialize(
          server,
          'quoteVersion',
          null,
        ),
      'sales': _i8.SalesEndpoint()
        ..initialize(
          server,
          'sales',
          null,
        ),
      'greeting': _i9.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'nombre': _i1.ParameterDescription(
              name: 'nombre',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'apellido': _i1.ParameterDescription(
              name: 'apellido',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'rol': _i1.ParameterDescription(
              name: 'rol',
              type: _i1.getType<_i10.UserRole>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).register(
            session,
            params['email'],
            params['password'],
            params['nombre'],
            params['apellido'],
            params['rol'],
          ),
        ),
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).login(
            session,
            params['email'],
            params['password'],
          ),
        ),
        'changePassword': _i1.MethodConnector(
          name: 'changePassword',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'oldPassword': _i1.ParameterDescription(
              name: 'oldPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).changePassword(
            session,
            params['userId'],
            params['oldPassword'],
            params['newPassword'],
          ),
        ),
        'getUserById': _i1.MethodConnector(
          name: 'getUserById',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).getUserById(
            session,
            params['userId'],
          ),
        ),
        'getAllUsers': _i1.MethodConnector(
          name: 'getAllUsers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).getAllUsers(session),
        ),
        'updateUser': _i1.MethodConnector(
          name: 'updateUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'nombre': _i1.ParameterDescription(
              name: 'nombre',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'apellido': _i1.ParameterDescription(
              name: 'apellido',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'rol': _i1.ParameterDescription(
              name: 'rol',
              type: _i1.getType<_i10.UserRole>(),
              nullable: false,
            ),
            'activo': _i1.ParameterDescription(
              name: 'activo',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).updateUser(
            session,
            params['userId'],
            params['nombre'],
            params['apellido'],
            params['rol'],
            params['activo'],
          ),
        ),
        'deactivateUser': _i1.MethodConnector(
          name: 'deactivateUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).deactivateUser(
            session,
            params['userId'],
          ),
        ),
        'activateUser': _i1.MethodConnector(
          name: 'activateUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).activateUser(
            session,
            params['userId'],
          ),
        ),
        'resetPassword': _i1.MethodConnector(
          name: 'resetPassword',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).resetPassword(
            session,
            params['userId'],
          ),
        ),
      },
    );
    connectors['backup'] = _i1.EndpointConnector(
      name: 'backup',
      endpoint: endpoints['backup']!,
      methodConnectors: {
        'exportDatabase': _i1.MethodConnector(
          name: 'exportDatabase',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backup'] as _i3.BackupEndpoint)
                  .exportDatabase(session),
        ),
        'importDatabase': _i1.MethodConnector(
          name: 'importDatabase',
          params: {
            'jsonData': _i1.ParameterDescription(
              name: 'jsonData',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backup'] as _i3.BackupEndpoint).importDatabase(
            session,
            params['jsonData'],
          ),
        ),
      },
    );
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
              (endpoints['customer'] as _i4.CustomerEndpoint).searchCustomers(
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
              (endpoints['customer'] as _i4.CustomerEndpoint)
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
              (endpoints['customer'] as _i4.CustomerEndpoint).getCustomer(
            session,
            params['id'],
          ),
        ),
        'createCustomer': _i1.MethodConnector(
          name: 'createCustomer',
          params: {
            'apodo': _i1.ParameterDescription(
              name: 'apodo',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'nombre': _i1.ParameterDescription(
              name: 'nombre',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'apellido': _i1.ParameterDescription(
              name: 'apellido',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'numero': _i1.ParameterDescription(
              name: 'numero',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'direccion': _i1.ParameterDescription(
              name: 'direccion',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['customer'] as _i4.CustomerEndpoint).createCustomer(
            session,
            params['apodo'],
            params['nombre'],
            params['apellido'],
            params['numero'],
            params['direccion'],
            params['notes'],
          ),
        ),
        'updateCustomer': _i1.MethodConnector(
          name: 'updateCustomer',
          params: {
            'customerId': _i1.ParameterDescription(
              name: 'customerId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apodo': _i1.ParameterDescription(
              name: 'apodo',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'nombre': _i1.ParameterDescription(
              name: 'nombre',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'apellido': _i1.ParameterDescription(
              name: 'apellido',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'numero': _i1.ParameterDescription(
              name: 'numero',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'direccion': _i1.ParameterDescription(
              name: 'direccion',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['customer'] as _i4.CustomerEndpoint).updateCustomer(
            session,
            params['customerId'],
            params['apodo'],
            params['nombre'],
            params['apellido'],
            params['numero'],
            params['direccion'],
            params['notes'],
          ),
        ),
        'deleteCustomer': _i1.MethodConnector(
          name: 'deleteCustomer',
          params: {
            'customerId': _i1.ParameterDescription(
              name: 'customerId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['customer'] as _i4.CustomerEndpoint).deleteCustomer(
            session,
            params['customerId'],
          ),
        ),
      },
    );
    connectors['init'] = _i1.EndpointConnector(
      name: 'init',
      endpoint: endpoints['init']!,
      methodConnectors: {
        'initializeDatabase': _i1.MethodConnector(
          name: 'initializeDatabase',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['init'] as _i5.InitEndpoint)
                  .initializeDatabase(session),
        ),
        'isDatabaseInitialized': _i1.MethodConnector(
          name: 'isDatabaseInitialized',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['init'] as _i5.InitEndpoint)
                  .isDatabaseInitialized(session),
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
              type: _i1.getType<_i11.QuoteInput>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i6.QuoteEndpoint).createQuote(
            session,
            params['input'],
            userId: params['userId'],
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
              (endpoints['quote'] as _i6.QuoteEndpoint).getQuote(
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
              (endpoints['quote'] as _i6.QuoteEndpoint).getQuoteDetails(
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
              (endpoints['quote'] as _i6.QuoteEndpoint).getAllQuotes(session),
        ),
        'getQuotesPaginated': _i1.MethodConnector(
          name: 'getQuotesPaginated',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i12.QuoteStatus?>(),
              nullable: true,
            ),
            'customerId': _i1.ParameterDescription(
              name: 'customerId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i6.QuoteEndpoint).getQuotesPaginated(
            session,
            limit: params['limit'],
            offset: params['offset'],
            status: params['status'],
            customerId: params['customerId'],
          ),
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
              type: _i1.getType<_i11.QuoteInput>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i6.QuoteEndpoint).updateQuote(
            session,
            params['quoteId'],
            params['input'],
            userId: params['userId'],
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
              (endpoints['quote'] as _i6.QuoteEndpoint).deleteQuote(
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
              type: _i1.getType<_i12.QuoteStatus>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quote'] as _i6.QuoteEndpoint).updateQuoteStatus(
            session,
            params['id'],
            params['status'],
          ),
        ),
      },
    );
    connectors['quoteVersion'] = _i1.EndpointConnector(
      name: 'quoteVersion',
      endpoint: endpoints['quoteVersion']!,
      methodConnectors: {
        'getQuoteVersions': _i1.MethodConnector(
          name: 'getQuoteVersions',
          params: {
            'quoteId': _i1.ParameterDescription(
              name: 'quoteId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quoteVersion'] as _i7.QuoteVersionEndpoint)
                  .getQuoteVersions(
            session,
            params['quoteId'],
          ),
        ),
        'getPrimaryVersion': _i1.MethodConnector(
          name: 'getPrimaryVersion',
          params: {
            'quoteId': _i1.ParameterDescription(
              name: 'quoteId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quoteVersion'] as _i7.QuoteVersionEndpoint)
                  .getPrimaryVersion(
            session,
            params['quoteId'],
          ),
        ),
        'createVersionFromQuote': _i1.MethodConnector(
          name: 'createVersionFromQuote',
          params: {
            'quoteId': _i1.ParameterDescription(
              name: 'quoteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'versionName': _i1.ParameterDescription(
              name: 'versionName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isPrimary': _i1.ParameterDescription(
              name: 'isPrimary',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quoteVersion'] as _i7.QuoteVersionEndpoint)
                  .createVersionFromQuote(
            session,
            params['quoteId'],
            params['versionName'],
            params['isPrimary'],
            params['userId'],
          ),
        ),
        'setPrimaryVersion': _i1.MethodConnector(
          name: 'setPrimaryVersion',
          params: {
            'versionId': _i1.ParameterDescription(
              name: 'versionId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quoteVersion'] as _i7.QuoteVersionEndpoint)
                  .setPrimaryVersion(
            session,
            params['versionId'],
          ),
        ),
        'applyVersionToQuote': _i1.MethodConnector(
          name: 'applyVersionToQuote',
          params: {
            'versionId': _i1.ParameterDescription(
              name: 'versionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quoteVersion'] as _i7.QuoteVersionEndpoint)
                  .applyVersionToQuote(
            session,
            params['versionId'],
            params['userId'],
          ),
        ),
        'deleteVersion': _i1.MethodConnector(
          name: 'deleteVersion',
          params: {
            'versionId': _i1.ParameterDescription(
              name: 'versionId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['quoteVersion'] as _i7.QuoteVersionEndpoint)
                  .deleteVersion(
            session,
            params['versionId'],
          ),
        ),
      },
    );
    connectors['sales'] = _i1.EndpointConnector(
      name: 'sales',
      endpoint: endpoints['sales']!,
      methodConnectors: {
        'getAllSales': _i1.MethodConnector(
          name: 'getAllSales',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i13.SaleStatus?>(),
              nullable: true,
            ),
            'paymentStatus': _i1.ParameterDescription(
              name: 'paymentStatus',
              type: _i1.getType<_i14.PaymentStatus?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).getAllSales(
            session,
            status: params['status'],
            paymentStatus: params['paymentStatus'],
          ),
        ),
        'getSalesPaginated': _i1.MethodConnector(
          name: 'getSalesPaginated',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i13.SaleStatus?>(),
              nullable: true,
            ),
            'paymentStatus': _i1.ParameterDescription(
              name: 'paymentStatus',
              type: _i1.getType<_i14.PaymentStatus?>(),
              nullable: true,
            ),
            'customerId': _i1.ParameterDescription(
              name: 'customerId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).getSalesPaginated(
            session,
            limit: params['limit'],
            offset: params['offset'],
            status: params['status'],
            paymentStatus: params['paymentStatus'],
            customerId: params['customerId'],
          ),
        ),
        'getSaleById': _i1.MethodConnector(
          name: 'getSaleById',
          params: {
            'saleId': _i1.ParameterDescription(
              name: 'saleId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).getSaleById(
            session,
            params['saleId'],
          ),
        ),
        'getSalesByQuoteId': _i1.MethodConnector(
          name: 'getSalesByQuoteId',
          params: {
            'quoteId': _i1.ParameterDescription(
              name: 'quoteId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).getSalesByQuoteId(
            session,
            params['quoteId'],
          ),
        ),
        'convertQuoteToSale': _i1.MethodConnector(
          name: 'convertQuoteToSale',
          params: {
            'quoteId': _i1.ParameterDescription(
              name: 'quoteId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'quoteVersionId': _i1.ParameterDescription(
              name: 'quoteVersionId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'customerId': _i1.ParameterDescription(
              name: 'customerId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'initialStatus': _i1.ParameterDescription(
              name: 'initialStatus',
              type: _i1.getType<_i13.SaleStatus?>(),
              nullable: true,
            ),
            'initialPaymentStatus': _i1.ParameterDescription(
              name: 'initialPaymentStatus',
              type: _i1.getType<_i14.PaymentStatus?>(),
              nullable: true,
            ),
            'paidAmount': _i1.ParameterDescription(
              name: 'paidAmount',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'scheduledDeliveryDate': _i1.ParameterDescription(
              name: 'scheduledDeliveryDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'customerName': _i1.ParameterDescription(
              name: 'customerName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).convertQuoteToSale(
            session,
            params['quoteId'],
            quoteVersionId: params['quoteVersionId'],
            customerId: params['customerId'],
            initialStatus: params['initialStatus'],
            initialPaymentStatus: params['initialPaymentStatus'],
            paidAmount: params['paidAmount'],
            scheduledDeliveryDate: params['scheduledDeliveryDate'],
            customerName: params['customerName'],
            notes: params['notes'],
          ),
        ),
        'updateSaleStatus': _i1.MethodConnector(
          name: 'updateSaleStatus',
          params: {
            'saleId': _i1.ParameterDescription(
              name: 'saleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newStatus': _i1.ParameterDescription(
              name: 'newStatus',
              type: _i1.getType<_i13.SaleStatus>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).updateSaleStatus(
            session,
            params['saleId'],
            params['newStatus'],
            notes: params['notes'],
          ),
        ),
        'updatePaymentStatus': _i1.MethodConnector(
          name: 'updatePaymentStatus',
          params: {
            'saleId': _i1.ParameterDescription(
              name: 'saleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newPaymentStatus': _i1.ParameterDescription(
              name: 'newPaymentStatus',
              type: _i1.getType<_i14.PaymentStatus>(),
              nullable: false,
            ),
            'paidAmount': _i1.ParameterDescription(
              name: 'paidAmount',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).updatePaymentStatus(
            session,
            params['saleId'],
            params['newPaymentStatus'],
            paidAmount: params['paidAmount'],
            notes: params['notes'],
          ),
        ),
        'updateDeliverySchedule': _i1.MethodConnector(
          name: 'updateDeliverySchedule',
          params: {
            'saleId': _i1.ParameterDescription(
              name: 'saleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'scheduledDeliveryDate': _i1.ParameterDescription(
              name: 'scheduledDeliveryDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'reminderDate': _i1.ParameterDescription(
              name: 'reminderDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'actualDeliveryDate': _i1.ParameterDescription(
              name: 'actualDeliveryDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).updateDeliverySchedule(
            session,
            params['saleId'],
            scheduledDeliveryDate: params['scheduledDeliveryDate'],
            reminderDate: params['reminderDate'],
            actualDeliveryDate: params['actualDeliveryDate'],
          ),
        ),
        'updateSaleNotes': _i1.MethodConnector(
          name: 'updateSaleNotes',
          params: {
            'saleId': _i1.ParameterDescription(
              name: 'saleId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).updateSaleNotes(
            session,
            params['saleId'],
            params['notes'],
          ),
        ),
        'deleteSale': _i1.MethodConnector(
          name: 'deleteSale',
          params: {
            'saleId': _i1.ParameterDescription(
              name: 'saleId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).deleteSale(
            session,
            params['saleId'],
          ),
        ),
        'getSalesStatistics': _i1.MethodConnector(
          name: 'getSalesStatistics',
          params: {
            'fromDate': _i1.ParameterDescription(
              name: 'fromDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'toDate': _i1.ParameterDescription(
              name: 'toDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).getSalesStatistics(
            session,
            fromDate: params['fromDate'],
            toDate: params['toDate'],
          ),
        ),
        'getUpcomingDeliveries': _i1.MethodConnector(
          name: 'getUpcomingDeliveries',
          params: {
            'daysAhead': _i1.ParameterDescription(
              name: 'daysAhead',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint).getUpcomingDeliveries(
            session,
            daysAhead: params['daysAhead'],
          ),
        ),
        'getOverdueDeliveries': _i1.MethodConnector(
          name: 'getOverdueDeliveries',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['sales'] as _i8.SalesEndpoint)
                  .getOverdueDeliveries(session),
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
              (endpoints['greeting'] as _i9.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
  }
}
