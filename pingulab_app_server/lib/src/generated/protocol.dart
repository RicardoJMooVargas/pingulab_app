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
import 'backup_data.dart' as _i4;
import 'customer.dart' as _i5;
import 'electricity_rate.dart' as _i6;
import 'extra_supply.dart' as _i7;
import 'filament.dart' as _i8;
import 'filament_catalog_item.dart' as _i9;
import 'filament_inventory_match.dart' as _i10;
import 'filament_usage.dart' as _i11;
import 'import_result.dart' as _i12;
import 'payment_status.dart' as _i13;
import 'printer.dart' as _i14;
import 'quote.dart' as _i15;
import 'quote_category.dart' as _i16;
import 'quote_details.dart' as _i17;
import 'quote_extra_supply.dart' as _i18;
import 'quote_filament.dart' as _i19;
import 'quote_filament_detail.dart' as _i20;
import 'quote_input.dart' as _i21;
import 'quote_status.dart' as _i22;
import 'quote_supply_detail.dart' as _i23;
import 'quote_version.dart' as _i24;
import 'quote_version_filament.dart' as _i25;
import 'quote_version_supply.dart' as _i26;
import 'sale.dart' as _i27;
import 'sale_filament_consumption.dart' as _i28;
import 'sale_status.dart' as _i29;
import 'shipping.dart' as _i30;
import 'supply_usage.dart' as _i31;
import 'user.dart' as _i32;
import 'user_role.dart' as _i33;
import 'package:pingulab_app_server/src/generated/user.dart' as _i34;
import 'package:pingulab_app_server/src/generated/customer.dart' as _i35;
import 'package:pingulab_app_server/src/generated/quote.dart' as _i36;
import 'package:pingulab_app_server/src/generated/quote_version.dart' as _i37;
import 'package:pingulab_app_server/src/generated/sale.dart' as _i38;
export 'greeting.dart';
export 'backup_data.dart';
export 'customer.dart';
export 'electricity_rate.dart';
export 'extra_supply.dart';
export 'filament.dart';
export 'filament_catalog_item.dart';
export 'filament_inventory_match.dart';
export 'filament_usage.dart';
export 'import_result.dart';
export 'payment_status.dart';
export 'printer.dart';
export 'quote.dart';
export 'quote_category.dart';
export 'quote_details.dart';
export 'quote_extra_supply.dart';
export 'quote_filament.dart';
export 'quote_filament_detail.dart';
export 'quote_input.dart';
export 'quote_status.dart';
export 'quote_supply_detail.dart';
export 'quote_version.dart';
export 'quote_version_filament.dart';
export 'quote_version_supply.dart';
export 'sale.dart';
export 'sale_filament_consumption.dart';
export 'sale_status.dart';
export 'shipping.dart';
export 'supply_usage.dart';
export 'user.dart';
export 'user_role.dart';

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
      name: 'filament_catalog_items',
      dartName: 'FilamentCatalogItem',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'filament_catalog_items_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'materialType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'color',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
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
          indexName: 'filament_catalog_items_pkey',
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
        ),
        _i2.IndexDefinition(
          indexName: 'material_color_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'materialType',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'color',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
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
          name: 'color',
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
        _i2.ColumnDefinition(
          name: 'remainingGrams',
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
          name: 'purchaseCost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'imageBase64',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
      name: 'quote_categories',
      dartName: 'QuoteCategory',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'quote_categories_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'icon',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'color',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
          indexName: 'quote_categories_pkey',
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
        ),
        _i2.IndexDefinition(
          indexName: 'name_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
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
      name: 'quote_version_filaments',
      dartName: 'QuoteVersionFilament',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'quote_version_filaments_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'quoteVersionId',
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
          indexName: 'quote_version_filaments_pkey',
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
      name: 'quote_version_supplies',
      dartName: 'QuoteVersionSupply',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'quote_version_supplies_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'quoteVersionId',
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
          indexName: 'quote_version_supplies_pkey',
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
      name: 'quote_versions',
      dartName: 'QuoteVersion',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'quote_versions_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'quoteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'versionNumber',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'versionName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isPrimary',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
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
          name: 'depreciationCost',
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
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'created',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'quote_versions_pkey',
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
        ),
        _i2.IndexDefinition(
          indexName: 'quote_version_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'quoteId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'versionNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
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
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
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
          name: 'depreciationCost',
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
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedBy',
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
      name: 'sale_filament_consumptions',
      dartName: 'SaleFilamentConsumption',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'sale_filament_consumptions_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'saleId',
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
          name: 'gramsConsumed',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'sale_filament_consumptions_pkey',
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
        ),
        _i2.IndexDefinition(
          indexName: 'sale_filament_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'saleId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'filamentId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'sale_consumptions',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'saleId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'sales',
      dartName: 'Sale',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'sales_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'quoteId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'quoteVersionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'saleStatus',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:SaleStatus',
        ),
        _i2.ColumnDefinition(
          name: 'paymentStatus',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:PaymentStatus',
        ),
        _i2.ColumnDefinition(
          name: 'totalAmount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'paidAmount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'pendingAmount',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledDeliveryDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'actualDeliveryDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'deliveryNotes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'reminderSent',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'reminderDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'customerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'customerName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedBy',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
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
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'sales_pkey',
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
        ),
        _i2.IndexDefinition(
          indexName: 'quote_sale',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'quoteId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
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
    _i2.TableDefinition(
      name: 'users',
      dartName: 'User',
      schema: 'public',
      module: 'pingulab_app',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'passwordHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'nombre',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'apellido',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'rol',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:UserRole',
        ),
        _i2.ColumnDefinition(
          name: 'activo',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
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
          indexName: 'users_pkey',
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
        ),
        _i2.IndexDefinition(
          indexName: 'email_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'email',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
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
    if (t == _i4.BackupData) {
      return _i4.BackupData.fromJson(data) as T;
    }
    if (t == _i5.Customer) {
      return _i5.Customer.fromJson(data) as T;
    }
    if (t == _i6.ElectricityRate) {
      return _i6.ElectricityRate.fromJson(data) as T;
    }
    if (t == _i7.ExtraSupply) {
      return _i7.ExtraSupply.fromJson(data) as T;
    }
    if (t == _i8.Filament) {
      return _i8.Filament.fromJson(data) as T;
    }
    if (t == _i9.FilamentCatalogItem) {
      return _i9.FilamentCatalogItem.fromJson(data) as T;
    }
    if (t == _i10.FilamentInventoryMatch) {
      return _i10.FilamentInventoryMatch.fromJson(data) as T;
    }
    if (t == _i11.FilamentUsage) {
      return _i11.FilamentUsage.fromJson(data) as T;
    }
    if (t == _i12.ImportResult) {
      return _i12.ImportResult.fromJson(data) as T;
    }
    if (t == _i13.PaymentStatus) {
      return _i13.PaymentStatus.fromJson(data) as T;
    }
    if (t == _i14.Printer) {
      return _i14.Printer.fromJson(data) as T;
    }
    if (t == _i15.Quote) {
      return _i15.Quote.fromJson(data) as T;
    }
    if (t == _i16.QuoteCategory) {
      return _i16.QuoteCategory.fromJson(data) as T;
    }
    if (t == _i17.QuoteDetails) {
      return _i17.QuoteDetails.fromJson(data) as T;
    }
    if (t == _i18.QuoteExtraSupply) {
      return _i18.QuoteExtraSupply.fromJson(data) as T;
    }
    if (t == _i19.QuoteFilament) {
      return _i19.QuoteFilament.fromJson(data) as T;
    }
    if (t == _i20.QuoteFilamentDetail) {
      return _i20.QuoteFilamentDetail.fromJson(data) as T;
    }
    if (t == _i21.QuoteInput) {
      return _i21.QuoteInput.fromJson(data) as T;
    }
    if (t == _i22.QuoteStatus) {
      return _i22.QuoteStatus.fromJson(data) as T;
    }
    if (t == _i23.QuoteSupplyDetail) {
      return _i23.QuoteSupplyDetail.fromJson(data) as T;
    }
    if (t == _i24.QuoteVersion) {
      return _i24.QuoteVersion.fromJson(data) as T;
    }
    if (t == _i25.QuoteVersionFilament) {
      return _i25.QuoteVersionFilament.fromJson(data) as T;
    }
    if (t == _i26.QuoteVersionSupply) {
      return _i26.QuoteVersionSupply.fromJson(data) as T;
    }
    if (t == _i27.Sale) {
      return _i27.Sale.fromJson(data) as T;
    }
    if (t == _i28.SaleFilamentConsumption) {
      return _i28.SaleFilamentConsumption.fromJson(data) as T;
    }
    if (t == _i29.SaleStatus) {
      return _i29.SaleStatus.fromJson(data) as T;
    }
    if (t == _i30.Shipping) {
      return _i30.Shipping.fromJson(data) as T;
    }
    if (t == _i31.SupplyUsage) {
      return _i31.SupplyUsage.fromJson(data) as T;
    }
    if (t == _i32.User) {
      return _i32.User.fromJson(data) as T;
    }
    if (t == _i33.UserRole) {
      return _i33.UserRole.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.Greeting?>()) {
      return (data != null ? _i3.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.BackupData?>()) {
      return (data != null ? _i4.BackupData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Customer?>()) {
      return (data != null ? _i5.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ElectricityRate?>()) {
      return (data != null ? _i6.ElectricityRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ExtraSupply?>()) {
      return (data != null ? _i7.ExtraSupply.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Filament?>()) {
      return (data != null ? _i8.Filament.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.FilamentCatalogItem?>()) {
      return (data != null ? _i9.FilamentCatalogItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.FilamentInventoryMatch?>()) {
      return (data != null ? _i10.FilamentInventoryMatch.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.FilamentUsage?>()) {
      return (data != null ? _i11.FilamentUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ImportResult?>()) {
      return (data != null ? _i12.ImportResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.PaymentStatus?>()) {
      return (data != null ? _i13.PaymentStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Printer?>()) {
      return (data != null ? _i14.Printer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Quote?>()) {
      return (data != null ? _i15.Quote.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.QuoteCategory?>()) {
      return (data != null ? _i16.QuoteCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.QuoteDetails?>()) {
      return (data != null ? _i17.QuoteDetails.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.QuoteExtraSupply?>()) {
      return (data != null ? _i18.QuoteExtraSupply.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.QuoteFilament?>()) {
      return (data != null ? _i19.QuoteFilament.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.QuoteFilamentDetail?>()) {
      return (data != null ? _i20.QuoteFilamentDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.QuoteInput?>()) {
      return (data != null ? _i21.QuoteInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.QuoteStatus?>()) {
      return (data != null ? _i22.QuoteStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.QuoteSupplyDetail?>()) {
      return (data != null ? _i23.QuoteSupplyDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.QuoteVersion?>()) {
      return (data != null ? _i24.QuoteVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.QuoteVersionFilament?>()) {
      return (data != null ? _i25.QuoteVersionFilament.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.QuoteVersionSupply?>()) {
      return (data != null ? _i26.QuoteVersionSupply.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.Sale?>()) {
      return (data != null ? _i27.Sale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.SaleFilamentConsumption?>()) {
      return (data != null ? _i28.SaleFilamentConsumption.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.SaleStatus?>()) {
      return (data != null ? _i29.SaleStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.Shipping?>()) {
      return (data != null ? _i30.Shipping.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SupplyUsage?>()) {
      return (data != null ? _i31.SupplyUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.User?>()) {
      return (data != null ? _i32.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.UserRole?>()) {
      return (data != null ? _i33.UserRole.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i20.QuoteFilamentDetail>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.QuoteFilamentDetail>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.QuoteSupplyDetail>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i23.QuoteSupplyDetail>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.FilamentUsage>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.FilamentUsage>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.SupplyUsage>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.SupplyUsage>(e)).toList()
          : null) as T;
    }
    if (t == List<_i34.User>) {
      return (data as List).map((e) => deserialize<_i34.User>(e)).toList() as T;
    }
    if (t == List<_i35.Customer>) {
      return (data as List).map((e) => deserialize<_i35.Customer>(e)).toList()
          as T;
    }
    if (t == List<_i36.Quote>) {
      return (data as List).map((e) => deserialize<_i36.Quote>(e)).toList()
          as T;
    }
    if (t == List<_i37.QuoteVersion>) {
      return (data as List)
          .map((e) => deserialize<_i37.QuoteVersion>(e))
          .toList() as T;
    }
    if (t == List<_i38.Sale>) {
      return (data as List).map((e) => deserialize<_i38.Sale>(e)).toList() as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as T;
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
    if (data is _i4.BackupData) {
      return 'BackupData';
    }
    if (data is _i5.Customer) {
      return 'Customer';
    }
    if (data is _i6.ElectricityRate) {
      return 'ElectricityRate';
    }
    if (data is _i7.ExtraSupply) {
      return 'ExtraSupply';
    }
    if (data is _i8.Filament) {
      return 'Filament';
    }
    if (data is _i9.FilamentCatalogItem) {
      return 'FilamentCatalogItem';
    }
    if (data is _i10.FilamentInventoryMatch) {
      return 'FilamentInventoryMatch';
    }
    if (data is _i11.FilamentUsage) {
      return 'FilamentUsage';
    }
    if (data is _i12.ImportResult) {
      return 'ImportResult';
    }
    if (data is _i13.PaymentStatus) {
      return 'PaymentStatus';
    }
    if (data is _i14.Printer) {
      return 'Printer';
    }
    if (data is _i15.Quote) {
      return 'Quote';
    }
    if (data is _i16.QuoteCategory) {
      return 'QuoteCategory';
    }
    if (data is _i17.QuoteDetails) {
      return 'QuoteDetails';
    }
    if (data is _i18.QuoteExtraSupply) {
      return 'QuoteExtraSupply';
    }
    if (data is _i19.QuoteFilament) {
      return 'QuoteFilament';
    }
    if (data is _i20.QuoteFilamentDetail) {
      return 'QuoteFilamentDetail';
    }
    if (data is _i21.QuoteInput) {
      return 'QuoteInput';
    }
    if (data is _i22.QuoteStatus) {
      return 'QuoteStatus';
    }
    if (data is _i23.QuoteSupplyDetail) {
      return 'QuoteSupplyDetail';
    }
    if (data is _i24.QuoteVersion) {
      return 'QuoteVersion';
    }
    if (data is _i25.QuoteVersionFilament) {
      return 'QuoteVersionFilament';
    }
    if (data is _i26.QuoteVersionSupply) {
      return 'QuoteVersionSupply';
    }
    if (data is _i27.Sale) {
      return 'Sale';
    }
    if (data is _i28.SaleFilamentConsumption) {
      return 'SaleFilamentConsumption';
    }
    if (data is _i29.SaleStatus) {
      return 'SaleStatus';
    }
    if (data is _i30.Shipping) {
      return 'Shipping';
    }
    if (data is _i31.SupplyUsage) {
      return 'SupplyUsage';
    }
    if (data is _i32.User) {
      return 'User';
    }
    if (data is _i33.UserRole) {
      return 'UserRole';
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
    if (dataClassName == 'BackupData') {
      return deserialize<_i4.BackupData>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i5.Customer>(data['data']);
    }
    if (dataClassName == 'ElectricityRate') {
      return deserialize<_i6.ElectricityRate>(data['data']);
    }
    if (dataClassName == 'ExtraSupply') {
      return deserialize<_i7.ExtraSupply>(data['data']);
    }
    if (dataClassName == 'Filament') {
      return deserialize<_i8.Filament>(data['data']);
    }
    if (dataClassName == 'FilamentCatalogItem') {
      return deserialize<_i9.FilamentCatalogItem>(data['data']);
    }
    if (dataClassName == 'FilamentInventoryMatch') {
      return deserialize<_i10.FilamentInventoryMatch>(data['data']);
    }
    if (dataClassName == 'FilamentUsage') {
      return deserialize<_i11.FilamentUsage>(data['data']);
    }
    if (dataClassName == 'ImportResult') {
      return deserialize<_i12.ImportResult>(data['data']);
    }
    if (dataClassName == 'PaymentStatus') {
      return deserialize<_i13.PaymentStatus>(data['data']);
    }
    if (dataClassName == 'Printer') {
      return deserialize<_i14.Printer>(data['data']);
    }
    if (dataClassName == 'Quote') {
      return deserialize<_i15.Quote>(data['data']);
    }
    if (dataClassName == 'QuoteCategory') {
      return deserialize<_i16.QuoteCategory>(data['data']);
    }
    if (dataClassName == 'QuoteDetails') {
      return deserialize<_i17.QuoteDetails>(data['data']);
    }
    if (dataClassName == 'QuoteExtraSupply') {
      return deserialize<_i18.QuoteExtraSupply>(data['data']);
    }
    if (dataClassName == 'QuoteFilament') {
      return deserialize<_i19.QuoteFilament>(data['data']);
    }
    if (dataClassName == 'QuoteFilamentDetail') {
      return deserialize<_i20.QuoteFilamentDetail>(data['data']);
    }
    if (dataClassName == 'QuoteInput') {
      return deserialize<_i21.QuoteInput>(data['data']);
    }
    if (dataClassName == 'QuoteStatus') {
      return deserialize<_i22.QuoteStatus>(data['data']);
    }
    if (dataClassName == 'QuoteSupplyDetail') {
      return deserialize<_i23.QuoteSupplyDetail>(data['data']);
    }
    if (dataClassName == 'QuoteVersion') {
      return deserialize<_i24.QuoteVersion>(data['data']);
    }
    if (dataClassName == 'QuoteVersionFilament') {
      return deserialize<_i25.QuoteVersionFilament>(data['data']);
    }
    if (dataClassName == 'QuoteVersionSupply') {
      return deserialize<_i26.QuoteVersionSupply>(data['data']);
    }
    if (dataClassName == 'Sale') {
      return deserialize<_i27.Sale>(data['data']);
    }
    if (dataClassName == 'SaleFilamentConsumption') {
      return deserialize<_i28.SaleFilamentConsumption>(data['data']);
    }
    if (dataClassName == 'SaleStatus') {
      return deserialize<_i29.SaleStatus>(data['data']);
    }
    if (dataClassName == 'Shipping') {
      return deserialize<_i30.Shipping>(data['data']);
    }
    if (dataClassName == 'SupplyUsage') {
      return deserialize<_i31.SupplyUsage>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i32.User>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i33.UserRole>(data['data']);
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
      case _i5.Customer:
        return _i5.Customer.t;
      case _i6.ElectricityRate:
        return _i6.ElectricityRate.t;
      case _i7.ExtraSupply:
        return _i7.ExtraSupply.t;
      case _i8.Filament:
        return _i8.Filament.t;
      case _i9.FilamentCatalogItem:
        return _i9.FilamentCatalogItem.t;
      case _i14.Printer:
        return _i14.Printer.t;
      case _i15.Quote:
        return _i15.Quote.t;
      case _i16.QuoteCategory:
        return _i16.QuoteCategory.t;
      case _i18.QuoteExtraSupply:
        return _i18.QuoteExtraSupply.t;
      case _i19.QuoteFilament:
        return _i19.QuoteFilament.t;
      case _i24.QuoteVersion:
        return _i24.QuoteVersion.t;
      case _i25.QuoteVersionFilament:
        return _i25.QuoteVersionFilament.t;
      case _i26.QuoteVersionSupply:
        return _i26.QuoteVersionSupply.t;
      case _i27.Sale:
        return _i27.Sale.t;
      case _i28.SaleFilamentConsumption:
        return _i28.SaleFilamentConsumption.t;
      case _i30.Shipping:
        return _i30.Shipping.t;
      case _i32.User:
        return _i32.User.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'pingulab_app';
}
