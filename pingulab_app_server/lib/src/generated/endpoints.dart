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
import '../endpoints/catalogs_endpoint.dart' as _i3;
import '../endpoints/customer_endpoint.dart' as _i4;
import '../endpoints/init_endpoint.dart' as _i5;
import '../endpoints/quote_endpoint.dart' as _i6;
import '../endpoints/resources_endpoint.dart' as _i7;
import '../greeting_endpoint.dart' as _i8;
import 'package:pingulab_app_server/src/generated/user_role.dart' as _i9;
import 'package:pingulab_app_server/src/generated/quote_input.dart' as _i10;
import 'package:pingulab_app_server/src/generated/quote_status.dart' as _i11;

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
      'catalogs': _i3.CatalogsEndpoint()
        ..initialize(
          server,
          'catalogs',
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
      'resources': _i7.ResourcesEndpoint()
        ..initialize(
          server,
          'resources',
          null,
        ),
      'greeting': _i8.GreetingEndpoint()
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
              type: _i1.getType<_i9.UserRole>(),
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
              type: _i1.getType<_i9.UserRole>(),
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
    connectors['catalogs'] = _i1.EndpointConnector(
      name: 'catalogs',
      endpoint: endpoints['catalogs']!,
      methodConnectors: {
        'getFilaments': _i1.MethodConnector(
          name: 'getFilaments',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint)
                  .getFilaments(session),
        ),
        'createFilament': _i1.MethodConnector(
          name: 'createFilament',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'brand': _i1.ParameterDescription(
              name: 'brand',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'materialType': _i1.ParameterDescription(
              name: 'materialType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'color': _i1.ParameterDescription(
              name: 'color',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'spoolWeightKg': _i1.ParameterDescription(
              name: 'spoolWeightKg',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'spoolCost': _i1.ParameterDescription(
              name: 'spoolCost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).createFilament(
            session,
            params['name'],
            params['brand'],
            params['materialType'],
            params['color'],
            params['spoolWeightKg'],
            params['spoolCost'],
          ),
        ),
        'updateFilament': _i1.MethodConnector(
          name: 'updateFilament',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'brand': _i1.ParameterDescription(
              name: 'brand',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'materialType': _i1.ParameterDescription(
              name: 'materialType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'color': _i1.ParameterDescription(
              name: 'color',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'spoolWeightKg': _i1.ParameterDescription(
              name: 'spoolWeightKg',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'spoolCost': _i1.ParameterDescription(
              name: 'spoolCost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).updateFilament(
            session,
            params['id'],
            params['name'],
            params['brand'],
            params['materialType'],
            params['color'],
            params['spoolWeightKg'],
            params['spoolCost'],
          ),
        ),
        'deleteFilament': _i1.MethodConnector(
          name: 'deleteFilament',
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
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).deleteFilament(
            session,
            params['id'],
          ),
        ),
        'getPrinters': _i1.MethodConnector(
          name: 'getPrinters',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint)
                  .getPrinters(session),
        ),
        'createPrinter': _i1.MethodConnector(
          name: 'createPrinter',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'powerConsumptionWatts': _i1.ParameterDescription(
              name: 'powerConsumptionWatts',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'purchaseCost': _i1.ParameterDescription(
              name: 'purchaseCost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'available': _i1.ParameterDescription(
              name: 'available',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'imageBase64': _i1.ParameterDescription(
              name: 'imageBase64',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).createPrinter(
            session,
            params['name'],
            params['powerConsumptionWatts'],
            params['purchaseCost'],
            params['available'],
            imageBase64: params['imageBase64'],
          ),
        ),
        'updatePrinter': _i1.MethodConnector(
          name: 'updatePrinter',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'powerConsumptionWatts': _i1.ParameterDescription(
              name: 'powerConsumptionWatts',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'purchaseCost': _i1.ParameterDescription(
              name: 'purchaseCost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'available': _i1.ParameterDescription(
              name: 'available',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'imageBase64': _i1.ParameterDescription(
              name: 'imageBase64',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).updatePrinter(
            session,
            params['id'],
            params['name'],
            params['powerConsumptionWatts'],
            params['purchaseCost'],
            params['available'],
            imageBase64: params['imageBase64'],
          ),
        ),
        'deletePrinter': _i1.MethodConnector(
          name: 'deletePrinter',
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
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).deletePrinter(
            session,
            params['id'],
          ),
        ),
        'getShippings': _i1.MethodConnector(
          name: 'getShippings',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint)
                  .getShippings(session),
        ),
        'createShipping': _i1.MethodConnector(
          name: 'createShipping',
          params: {
            'shippingType': _i1.ParameterDescription(
              name: 'shippingType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'carrierName': _i1.ParameterDescription(
              name: 'carrierName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'cost': _i1.ParameterDescription(
              name: 'cost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).createShipping(
            session,
            params['shippingType'],
            params['carrierName'],
            params['cost'],
          ),
        ),
        'updateShipping': _i1.MethodConnector(
          name: 'updateShipping',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'shippingType': _i1.ParameterDescription(
              name: 'shippingType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'carrierName': _i1.ParameterDescription(
              name: 'carrierName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'cost': _i1.ParameterDescription(
              name: 'cost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).updateShipping(
            session,
            params['id'],
            params['shippingType'],
            params['carrierName'],
            params['cost'],
          ),
        ),
        'deleteShipping': _i1.MethodConnector(
          name: 'deleteShipping',
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
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).deleteShipping(
            session,
            params['id'],
          ),
        ),
        'getCustomers': _i1.MethodConnector(
          name: 'getCustomers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint)
                  .getCustomers(session),
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
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).createCustomer(
            session,
            params['apodo'],
            nombre: params['nombre'],
            apellido: params['apellido'],
            numero: params['numero'],
            direccion: params['direccion'],
            notes: params['notes'],
          ),
        ),
        'updateCustomer': _i1.MethodConnector(
          name: 'updateCustomer',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
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
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).updateCustomer(
            session,
            params['id'],
            params['apodo'],
            nombre: params['nombre'],
            apellido: params['apellido'],
            numero: params['numero'],
            direccion: params['direccion'],
            notes: params['notes'],
          ),
        ),
        'deleteCustomer': _i1.MethodConnector(
          name: 'deleteCustomer',
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
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).deleteCustomer(
            session,
            params['id'],
          ),
        ),
        'getElectricityRates': _i1.MethodConnector(
          name: 'getElectricityRates',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint)
                  .getElectricityRates(session),
        ),
        'createElectricityRate': _i1.MethodConnector(
          name: 'createElectricityRate',
          params: {
            'costPerKwh': _i1.ParameterDescription(
              name: 'costPerKwh',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'active': _i1.ParameterDescription(
              name: 'active',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint)
                  .createElectricityRate(
            session,
            params['costPerKwh'],
            params['active'],
          ),
        ),
        'updateElectricityRate': _i1.MethodConnector(
          name: 'updateElectricityRate',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'costPerKwh': _i1.ParameterDescription(
              name: 'costPerKwh',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'active': _i1.ParameterDescription(
              name: 'active',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint)
                  .updateElectricityRate(
            session,
            params['id'],
            params['costPerKwh'],
            params['active'],
          ),
        ),
        'deleteElectricityRate': _i1.MethodConnector(
          name: 'deleteElectricityRate',
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
              (endpoints['catalogs'] as _i3.CatalogsEndpoint)
                  .deleteElectricityRate(
            session,
            params['id'],
          ),
        ),
        'getExtraSupplies': _i1.MethodConnector(
          name: 'getExtraSupplies',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint)
                  .getExtraSupplies(session),
        ),
        'createExtraSupply': _i1.MethodConnector(
          name: 'createExtraSupply',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'cost': _i1.ParameterDescription(
              name: 'cost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).createExtraSupply(
            session,
            params['name'],
            params['cost'],
          ),
        ),
        'updateExtraSupply': _i1.MethodConnector(
          name: 'updateExtraSupply',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'cost': _i1.ParameterDescription(
              name: 'cost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).updateExtraSupply(
            session,
            params['id'],
            params['name'],
            params['cost'],
          ),
        ),
        'deleteExtraSupply': _i1.MethodConnector(
          name: 'deleteExtraSupply',
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
              (endpoints['catalogs'] as _i3.CatalogsEndpoint).deleteExtraSupply(
            session,
            params['id'],
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
              type: _i1.getType<_i10.QuoteInput>(),
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
              type: _i1.getType<_i10.QuoteInput>(),
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
              type: _i1.getType<_i11.QuoteStatus>(),
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
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .getAllPrinters(session),
        ),
        'getAvailablePrinters': _i1.MethodConnector(
          name: 'getAvailablePrinters',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .getAvailablePrinters(session),
        ),
        'createPrinter': _i1.MethodConnector(
          name: 'createPrinter',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'powerConsumptionWatts': _i1.ParameterDescription(
              name: 'powerConsumptionWatts',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'purchaseCost': _i1.ParameterDescription(
              name: 'purchaseCost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'available': _i1.ParameterDescription(
              name: 'available',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'imageBase64': _i1.ParameterDescription(
              name: 'imageBase64',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint).createPrinter(
            session,
            params['name'],
            params['powerConsumptionWatts'],
            params['purchaseCost'],
            params['available'],
            imageBase64: params['imageBase64'],
          ),
        ),
        'updatePrinter': _i1.MethodConnector(
          name: 'updatePrinter',
          params: {
            'printerId': _i1.ParameterDescription(
              name: 'printerId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'powerConsumptionWatts': _i1.ParameterDescription(
              name: 'powerConsumptionWatts',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'purchaseCost': _i1.ParameterDescription(
              name: 'purchaseCost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'available': _i1.ParameterDescription(
              name: 'available',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'imageBase64': _i1.ParameterDescription(
              name: 'imageBase64',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint).updatePrinter(
            session,
            params['printerId'],
            params['name'],
            params['powerConsumptionWatts'],
            params['purchaseCost'],
            params['available'],
            imageBase64: params['imageBase64'],
          ),
        ),
        'deletePrinter': _i1.MethodConnector(
          name: 'deletePrinter',
          params: {
            'printerId': _i1.ParameterDescription(
              name: 'printerId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint).deletePrinter(
            session,
            params['printerId'],
          ),
        ),
        'getAllFilaments': _i1.MethodConnector(
          name: 'getAllFilaments',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .getAllFilaments(session),
        ),
        'createFilament': _i1.MethodConnector(
          name: 'createFilament',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'brand': _i1.ParameterDescription(
              name: 'brand',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'materialType': _i1.ParameterDescription(
              name: 'materialType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'color': _i1.ParameterDescription(
              name: 'color',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'spoolWeightKg': _i1.ParameterDescription(
              name: 'spoolWeightKg',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'spoolCost': _i1.ParameterDescription(
              name: 'spoolCost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint).createFilament(
            session,
            params['name'],
            params['brand'],
            params['materialType'],
            params['color'],
            params['spoolWeightKg'],
            params['spoolCost'],
          ),
        ),
        'updateFilament': _i1.MethodConnector(
          name: 'updateFilament',
          params: {
            'filamentId': _i1.ParameterDescription(
              name: 'filamentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'brand': _i1.ParameterDescription(
              name: 'brand',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'materialType': _i1.ParameterDescription(
              name: 'materialType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'color': _i1.ParameterDescription(
              name: 'color',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'spoolWeightKg': _i1.ParameterDescription(
              name: 'spoolWeightKg',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'spoolCost': _i1.ParameterDescription(
              name: 'spoolCost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint).updateFilament(
            session,
            params['filamentId'],
            params['name'],
            params['brand'],
            params['materialType'],
            params['color'],
            params['spoolWeightKg'],
            params['spoolCost'],
          ),
        ),
        'deleteFilament': _i1.MethodConnector(
          name: 'deleteFilament',
          params: {
            'filamentId': _i1.ParameterDescription(
              name: 'filamentId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint).deleteFilament(
            session,
            params['filamentId'],
          ),
        ),
        'getAllExtraSupplies': _i1.MethodConnector(
          name: 'getAllExtraSupplies',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .getAllExtraSupplies(session),
        ),
        'createExtraSupply': _i1.MethodConnector(
          name: 'createExtraSupply',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'cost': _i1.ParameterDescription(
              name: 'cost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .createExtraSupply(
            session,
            params['name'],
            params['cost'],
          ),
        ),
        'updateExtraSupply': _i1.MethodConnector(
          name: 'updateExtraSupply',
          params: {
            'supplyId': _i1.ParameterDescription(
              name: 'supplyId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'cost': _i1.ParameterDescription(
              name: 'cost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .updateExtraSupply(
            session,
            params['supplyId'],
            params['name'],
            params['cost'],
          ),
        ),
        'deleteExtraSupply': _i1.MethodConnector(
          name: 'deleteExtraSupply',
          params: {
            'supplyId': _i1.ParameterDescription(
              name: 'supplyId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .deleteExtraSupply(
            session,
            params['supplyId'],
          ),
        ),
        'getAllShippings': _i1.MethodConnector(
          name: 'getAllShippings',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .getAllShippings(session),
        ),
        'createShipping': _i1.MethodConnector(
          name: 'createShipping',
          params: {
            'shippingType': _i1.ParameterDescription(
              name: 'shippingType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'carrierName': _i1.ParameterDescription(
              name: 'carrierName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'cost': _i1.ParameterDescription(
              name: 'cost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint).createShipping(
            session,
            params['shippingType'],
            params['carrierName'],
            params['cost'],
          ),
        ),
        'updateShipping': _i1.MethodConnector(
          name: 'updateShipping',
          params: {
            'shippingId': _i1.ParameterDescription(
              name: 'shippingId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'shippingType': _i1.ParameterDescription(
              name: 'shippingType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'carrierName': _i1.ParameterDescription(
              name: 'carrierName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'cost': _i1.ParameterDescription(
              name: 'cost',
              type: _i1.getType<double>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint).updateShipping(
            session,
            params['shippingId'],
            params['shippingType'],
            params['carrierName'],
            params['cost'],
          ),
        ),
        'deleteShipping': _i1.MethodConnector(
          name: 'deleteShipping',
          params: {
            'shippingId': _i1.ParameterDescription(
              name: 'shippingId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint).deleteShipping(
            session,
            params['shippingId'],
          ),
        ),
        'getActiveElectricityRate': _i1.MethodConnector(
          name: 'getActiveElectricityRate',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .getActiveElectricityRate(session),
        ),
        'getAllElectricityRates': _i1.MethodConnector(
          name: 'getAllElectricityRates',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .getAllElectricityRates(session),
        ),
        'createElectricityRate': _i1.MethodConnector(
          name: 'createElectricityRate',
          params: {
            'costPerKwh': _i1.ParameterDescription(
              name: 'costPerKwh',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'active': _i1.ParameterDescription(
              name: 'active',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .createElectricityRate(
            session,
            params['costPerKwh'],
            params['active'],
          ),
        ),
        'updateElectricityRate': _i1.MethodConnector(
          name: 'updateElectricityRate',
          params: {
            'rateId': _i1.ParameterDescription(
              name: 'rateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'costPerKwh': _i1.ParameterDescription(
              name: 'costPerKwh',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'active': _i1.ParameterDescription(
              name: 'active',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .updateElectricityRate(
            session,
            params['rateId'],
            params['costPerKwh'],
            params['active'],
          ),
        ),
        'deleteElectricityRate': _i1.MethodConnector(
          name: 'deleteElectricityRate',
          params: {
            'rateId': _i1.ParameterDescription(
              name: 'rateId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['resources'] as _i7.ResourcesEndpoint)
                  .deleteElectricityRate(
            session,
            params['rateId'],
          ),
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
              (endpoints['greeting'] as _i8.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
  }
}
