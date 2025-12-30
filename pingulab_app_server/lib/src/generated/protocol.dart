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
import 'package:serverpod/protocol.dart' as _i2;
import 'greeting.dart' as _i3;
import 'customer.dart' as _i4;
import 'electricity_rate.dart' as _i5;
import 'extra_supply.dart' as _i6;
import 'filament.dart' as _i7;
import 'filament_usage.dart' as _i8;
import 'printer.dart' as _i9;
import 'quote.dart' as _i10;
import 'quote_details.dart' as _i11;
import 'quote_extra_supply.dart' as _i12;
import 'quote_filament.dart' as _i13;
import 'quote_filament_detail.dart' as _i14;
import 'quote_input.dart' as _i15;
import 'quote_status.dart' as _i16;
import 'quote_supply_detail.dart' as _i17;
import 'shipping.dart' as _i18;
import 'supply_usage.dart' as _i19;
import 'package:pingulab_app_server/src/generated/customer.dart' as _i20;
import 'package:pingulab_app_server/src/generated/quote.dart' as _i21;
import 'package:pingulab_app_server/src/generated/printer.dart' as _i22;
import 'package:pingulab_app_server/src/generated/filament.dart' as _i23;
import 'package:pingulab_app_server/src/generated/extra_supply.dart' as _i24;
import 'package:pingulab_app_server/src/generated/shipping.dart' as _i25;
import 'package:pingulab_app_server/src/generated/electricity_rate.dart'
    as _i26;
export 'greeting.dart';
export 'customer.dart';
export 'electricity_rate.dart';
export 'extra_supply.dart';
export 'filament.dart';
export 'filament_usage.dart';
export 'printer.dart';
export 'quote.dart';
export 'quote_details.dart';
export 'quote_extra_supply.dart';
export 'quote_filament.dart';
export 'quote_filament_detail.dart';
export 'quote_input.dart';
export 'quote_status.dart';
export 'quote_supply_detail.dart';
export 'shipping.dart';
export 'supply_usage.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'customers',
      dartName: 'Customer',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'customers_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'apodo',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nombre',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'apellido',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'numero',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'direccion',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'created',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updated',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'customers_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'electricity_rates',
      dartName: 'ElectricityRate',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'electricity_rates_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'costPerKwh',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'active',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'electricity_rates_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'extra_supplies',
      dartName: 'ExtraSupply',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'extra_supplies_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'extra_supplies_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'filaments',
      dartName: 'Filament',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'filaments_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'brand',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'materialType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'spoolWeightKg',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'spoolCost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'filaments_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'printers',
      dartName: 'Printer',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'printers_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'powerConsumptionWatts',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'available',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'printers_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'quote_extra_supplies',
      dartName: 'QuoteExtraSupply',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'quote_extra_supplies_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'quoteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'extraSupplyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'quote_extra_supplies_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'quote_filaments',
      dartName: 'QuoteFilament',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'quote_filaments_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'quoteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'filamentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'gramsUsed',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'quote_filaments_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'quotes',
      dartName: 'Quote',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'quotes_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'pieceWeightGrams',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'printHours',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'postProcessingCost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'measurements',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'filamentCost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'electricityCost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'suppliesCost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'shippingCost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'subtotal',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'marginPercent',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'total',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:QuoteStatus',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'customerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'printerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'shippingId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'quotes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'shippings',
      dartName: 'Shipping',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'shippings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'shippingType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'carrierName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'shippings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i3.Greeting) {
      return _i3.Greeting.fromJson(data) as T;
    }
    if (t == _i4.Customer) {
      return _i4.Customer.fromJson(data) as T;
    }
    if (t == _i5.ElectricityRate) {
      return _i5.ElectricityRate.fromJson(data) as T;
    }
    if (t == _i6.ExtraSupply) {
      return _i6.ExtraSupply.fromJson(data) as T;
    }
    if (t == _i7.Filament) {
      return _i7.Filament.fromJson(data) as T;
    }
    if (t == _i8.FilamentUsage) {
      return _i8.FilamentUsage.fromJson(data) as T;
    }
    if (t == _i9.Printer) {
      return _i9.Printer.fromJson(data) as T;
    }
    if (t == _i10.Quote) {
      return _i10.Quote.fromJson(data) as T;
    }
    if (t == _i11.QuoteDetails) {
      return _i11.QuoteDetails.fromJson(data) as T;
    }
    if (t == _i12.QuoteExtraSupply) {
      return _i12.QuoteExtraSupply.fromJson(data) as T;
    }
    if (t == _i13.QuoteFilament) {
      return _i13.QuoteFilament.fromJson(data) as T;
    }
    if (t == _i14.QuoteFilamentDetail) {
      return _i14.QuoteFilamentDetail.fromJson(data) as T;
    }
    if (t == _i15.QuoteInput) {
      return _i15.QuoteInput.fromJson(data) as T;
    }
    if (t == _i16.QuoteStatus) {
      return _i16.QuoteStatus.fromJson(data) as T;
    }
    if (t == _i17.QuoteSupplyDetail) {
      return _i17.QuoteSupplyDetail.fromJson(data) as T;
    }
    if (t == _i18.Shipping) {
      return _i18.Shipping.fromJson(data) as T;
    }
    if (t == _i19.SupplyUsage) {
      return _i19.SupplyUsage.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.Greeting?>()) {
      return (data != null ? _i3.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Customer?>()) {
      return (data != null ? _i4.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ElectricityRate?>()) {
      return (data != null ? _i5.ElectricityRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ExtraSupply?>()) {
      return (data != null ? _i6.ExtraSupply.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Filament?>()) {
      return (data != null ? _i7.Filament.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.FilamentUsage?>()) {
      return (data != null ? _i8.FilamentUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Printer?>()) {
      return (data != null ? _i9.Printer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Quote?>()) {
      return (data != null ? _i10.Quote.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.QuoteDetails?>()) {
      return (data != null ? _i11.QuoteDetails.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.QuoteExtraSupply?>()) {
      return (data != null ? _i12.QuoteExtraSupply.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.QuoteFilament?>()) {
      return (data != null ? _i13.QuoteFilament.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.QuoteFilamentDetail?>()) {
      return (data != null ? _i14.QuoteFilamentDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.QuoteInput?>()) {
      return (data != null ? _i15.QuoteInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.QuoteStatus?>()) {
      return (data != null ? _i16.QuoteStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.QuoteSupplyDetail?>()) {
      return (data != null ? _i17.QuoteSupplyDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Shipping?>()) {
      return (data != null ? _i18.Shipping.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.SupplyUsage?>()) {
      return (data != null ? _i19.SupplyUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i14.QuoteFilamentDetail>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.QuoteFilamentDetail>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.QuoteSupplyDetail>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.QuoteSupplyDetail>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i8.FilamentUsage>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i8.FilamentUsage>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.SupplyUsage>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i19.SupplyUsage>(e)).toList()
          : null) as T;
    }
    if (t == List<_i20.Customer>) {
      return (data as List).map((e) => deserialize<_i20.Customer>(e)).toList()
          as T;
    }
    if (t == List<_i21.Quote>) {
      return (data as List).map((e) => deserialize<_i21.Quote>(e)).toList()
          as T;
    }
    if (t == List<_i22.Printer>) {
      return (data as List).map((e) => deserialize<_i22.Printer>(e)).toList()
          as T;
    }
    if (t == List<_i23.Filament>) {
      return (data as List).map((e) => deserialize<_i23.Filament>(e)).toList()
          as T;
    }
    if (t == List<_i24.ExtraSupply>) {
      return (data as List)
          .map((e) => deserialize<_i24.ExtraSupply>(e))
          .toList() as T;
    }
    if (t == List<_i25.Shipping>) {
      return (data as List).map((e) => deserialize<_i25.Shipping>(e)).toList()
          as T;
    }
    if (t == List<_i26.ElectricityRate>) {
      return (data as List)
          .map((e) => deserialize<_i26.ElectricityRate>(e))
          .toList() as T;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i3.Greeting) {
      return 'Greeting';
    }
    if (data is _i4.Customer) {
      return 'Customer';
    }
    if (data is _i5.ElectricityRate) {
      return 'ElectricityRate';
    }
    if (data is _i6.ExtraSupply) {
      return 'ExtraSupply';
    }
    if (data is _i7.Filament) {
      return 'Filament';
    }
    if (data is _i8.FilamentUsage) {
      return 'FilamentUsage';
    }
    if (data is _i9.Printer) {
      return 'Printer';
    }
    if (data is _i10.Quote) {
      return 'Quote';
    }
    if (data is _i11.QuoteDetails) {
      return 'QuoteDetails';
    }
    if (data is _i12.QuoteExtraSupply) {
      return 'QuoteExtraSupply';
    }
    if (data is _i13.QuoteFilament) {
      return 'QuoteFilament';
    }
    if (data is _i14.QuoteFilamentDetail) {
      return 'QuoteFilamentDetail';
    }
    if (data is _i15.QuoteInput) {
      return 'QuoteInput';
    }
    if (data is _i16.QuoteStatus) {
      return 'QuoteStatus';
    }
    if (data is _i17.QuoteSupplyDetail) {
      return 'QuoteSupplyDetail';
    }
    if (data is _i18.Shipping) {
      return 'Shipping';
    }
    if (data is _i19.SupplyUsage) {
      return 'SupplyUsage';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i3.Greeting>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i4.Customer>(data['data']);
    }
    if (dataClassName == 'ElectricityRate') {
      return deserialize<_i5.ElectricityRate>(data['data']);
    }
    if (dataClassName == 'ExtraSupply') {
      return deserialize<_i6.ExtraSupply>(data['data']);
    }
    if (dataClassName == 'Filament') {
      return deserialize<_i7.Filament>(data['data']);
    }
    if (dataClassName == 'FilamentUsage') {
      return deserialize<_i8.FilamentUsage>(data['data']);
    }
    if (dataClassName == 'Printer') {
      return deserialize<_i9.Printer>(data['data']);
    }
    if (dataClassName == 'Quote') {
      return deserialize<_i10.Quote>(data['data']);
    }
    if (dataClassName == 'QuoteDetails') {
      return deserialize<_i11.QuoteDetails>(data['data']);
    }
    if (dataClassName == 'QuoteExtraSupply') {
      return deserialize<_i12.QuoteExtraSupply>(data['data']);
    }
    if (dataClassName == 'QuoteFilament') {
      return deserialize<_i13.QuoteFilament>(data['data']);
    }
    if (dataClassName == 'QuoteFilamentDetail') {
      return deserialize<_i14.QuoteFilamentDetail>(data['data']);
    }
    if (dataClassName == 'QuoteInput') {
      return deserialize<_i15.QuoteInput>(data['data']);
    }
    if (dataClassName == 'QuoteStatus') {
      return deserialize<_i16.QuoteStatus>(data['data']);
    }
    if (dataClassName == 'QuoteSupplyDetail') {
      return deserialize<_i17.QuoteSupplyDetail>(data['data']);
    }
    if (dataClassName == 'Shipping') {
      return deserialize<_i18.Shipping>(data['data']);
    }
    if (dataClassName == 'SupplyUsage') {
      return deserialize<_i19.SupplyUsage>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i4.Customer:
        return _i4.Customer.t;
      case _i5.ElectricityRate:
        return _i5.ElectricityRate.t;
      case _i6.ExtraSupply:
        return _i6.ExtraSupply.t;
      case _i7.Filament:
        return _i7.Filament.t;
      case _i9.Printer:
        return _i9.Printer.t;
      case _i10.Quote:
        return _i10.Quote.t;
      case _i12.QuoteExtraSupply:
        return _i12.QuoteExtraSupply.t;
      case _i13.QuoteFilament:
        return _i13.QuoteFilament.t;
      case _i18.Shipping:
        return _i18.Shipping.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'pingulab_app';
}
