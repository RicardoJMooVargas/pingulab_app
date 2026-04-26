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
import 'greeting.dart' as _i2;
import 'backup_data.dart' as _i3;
import 'customer.dart' as _i4;
import 'electricity_rate.dart' as _i5;
import 'extra_supply.dart' as _i6;
import 'filament.dart' as _i7;
import 'filament_catalog_item.dart' as _i8;
import 'filament_inventory_match.dart' as _i9;
import 'filament_usage.dart' as _i10;
import 'import_result.dart' as _i11;
import 'payment_status.dart' as _i12;
import 'printer.dart' as _i13;
import 'quote.dart' as _i14;
import 'quote_category.dart' as _i15;
import 'quote_details.dart' as _i16;
import 'quote_extra_supply.dart' as _i17;
import 'quote_filament.dart' as _i18;
import 'quote_filament_detail.dart' as _i19;
import 'quote_input.dart' as _i20;
import 'quote_status.dart' as _i21;
import 'quote_supply_detail.dart' as _i22;
import 'quote_version.dart' as _i23;
import 'quote_version_filament.dart' as _i24;
import 'quote_version_supply.dart' as _i25;
import 'sale.dart' as _i26;
import 'sale_filament_consumption.dart' as _i27;
import 'sale_status.dart' as _i28;
import 'shipping.dart' as _i29;
import 'supply_usage.dart' as _i30;
import 'user.dart' as _i31;
import 'user_role.dart' as _i32;
import 'package:pingulab_app_client/src/protocol/user.dart' as _i33;
import 'package:pingulab_app_client/src/protocol/filament.dart' as _i34;
import 'package:pingulab_app_client/src/protocol/printer.dart' as _i35;
import 'package:pingulab_app_client/src/protocol/shipping.dart' as _i36;
import 'package:pingulab_app_client/src/protocol/customer.dart' as _i37;
import 'package:pingulab_app_client/src/protocol/electricity_rate.dart' as _i38;
import 'package:pingulab_app_client/src/protocol/extra_supply.dart' as _i39;
import 'package:pingulab_app_client/src/protocol/quote.dart' as _i40;
import 'package:pingulab_app_client/src/protocol/quote_version.dart' as _i41;
import 'package:pingulab_app_client/src/protocol/quote_category.dart' as _i42;
import 'package:pingulab_app_client/src/protocol/sale.dart' as _i43;
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Greeting) {
      return _i2.Greeting.fromJson(data) as T;
    }
    if (t == _i3.BackupData) {
      return _i3.BackupData.fromJson(data) as T;
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
    if (t == _i8.FilamentCatalogItem) {
      return _i8.FilamentCatalogItem.fromJson(data) as T;
    }
    if (t == _i9.FilamentInventoryMatch) {
      return _i9.FilamentInventoryMatch.fromJson(data) as T;
    }
    if (t == _i10.FilamentUsage) {
      return _i10.FilamentUsage.fromJson(data) as T;
    }
    if (t == _i11.ImportResult) {
      return _i11.ImportResult.fromJson(data) as T;
    }
    if (t == _i12.PaymentStatus) {
      return _i12.PaymentStatus.fromJson(data) as T;
    }
    if (t == _i13.Printer) {
      return _i13.Printer.fromJson(data) as T;
    }
    if (t == _i14.Quote) {
      return _i14.Quote.fromJson(data) as T;
    }
    if (t == _i15.QuoteCategory) {
      return _i15.QuoteCategory.fromJson(data) as T;
    }
    if (t == _i16.QuoteDetails) {
      return _i16.QuoteDetails.fromJson(data) as T;
    }
    if (t == _i17.QuoteExtraSupply) {
      return _i17.QuoteExtraSupply.fromJson(data) as T;
    }
    if (t == _i18.QuoteFilament) {
      return _i18.QuoteFilament.fromJson(data) as T;
    }
    if (t == _i19.QuoteFilamentDetail) {
      return _i19.QuoteFilamentDetail.fromJson(data) as T;
    }
    if (t == _i20.QuoteInput) {
      return _i20.QuoteInput.fromJson(data) as T;
    }
    if (t == _i21.QuoteStatus) {
      return _i21.QuoteStatus.fromJson(data) as T;
    }
    if (t == _i22.QuoteSupplyDetail) {
      return _i22.QuoteSupplyDetail.fromJson(data) as T;
    }
    if (t == _i23.QuoteVersion) {
      return _i23.QuoteVersion.fromJson(data) as T;
    }
    if (t == _i24.QuoteVersionFilament) {
      return _i24.QuoteVersionFilament.fromJson(data) as T;
    }
    if (t == _i25.QuoteVersionSupply) {
      return _i25.QuoteVersionSupply.fromJson(data) as T;
    }
    if (t == _i26.Sale) {
      return _i26.Sale.fromJson(data) as T;
    }
    if (t == _i27.SaleFilamentConsumption) {
      return _i27.SaleFilamentConsumption.fromJson(data) as T;
    }
    if (t == _i28.SaleStatus) {
      return _i28.SaleStatus.fromJson(data) as T;
    }
    if (t == _i29.Shipping) {
      return _i29.Shipping.fromJson(data) as T;
    }
    if (t == _i30.SupplyUsage) {
      return _i30.SupplyUsage.fromJson(data) as T;
    }
    if (t == _i31.User) {
      return _i31.User.fromJson(data) as T;
    }
    if (t == _i32.UserRole) {
      return _i32.UserRole.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Greeting?>()) {
      return (data != null ? _i2.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.BackupData?>()) {
      return (data != null ? _i3.BackupData.fromJson(data) : null) as T;
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
    if (t == _i1.getType<_i8.FilamentCatalogItem?>()) {
      return (data != null ? _i8.FilamentCatalogItem.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.FilamentInventoryMatch?>()) {
      return (data != null ? _i9.FilamentInventoryMatch.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.FilamentUsage?>()) {
      return (data != null ? _i10.FilamentUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ImportResult?>()) {
      return (data != null ? _i11.ImportResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.PaymentStatus?>()) {
      return (data != null ? _i12.PaymentStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Printer?>()) {
      return (data != null ? _i13.Printer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Quote?>()) {
      return (data != null ? _i14.Quote.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.QuoteCategory?>()) {
      return (data != null ? _i15.QuoteCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.QuoteDetails?>()) {
      return (data != null ? _i16.QuoteDetails.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.QuoteExtraSupply?>()) {
      return (data != null ? _i17.QuoteExtraSupply.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.QuoteFilament?>()) {
      return (data != null ? _i18.QuoteFilament.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.QuoteFilamentDetail?>()) {
      return (data != null ? _i19.QuoteFilamentDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.QuoteInput?>()) {
      return (data != null ? _i20.QuoteInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.QuoteStatus?>()) {
      return (data != null ? _i21.QuoteStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.QuoteSupplyDetail?>()) {
      return (data != null ? _i22.QuoteSupplyDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.QuoteVersion?>()) {
      return (data != null ? _i23.QuoteVersion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.QuoteVersionFilament?>()) {
      return (data != null ? _i24.QuoteVersionFilament.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.QuoteVersionSupply?>()) {
      return (data != null ? _i25.QuoteVersionSupply.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.Sale?>()) {
      return (data != null ? _i26.Sale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SaleFilamentConsumption?>()) {
      return (data != null ? _i27.SaleFilamentConsumption.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.SaleStatus?>()) {
      return (data != null ? _i28.SaleStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.Shipping?>()) {
      return (data != null ? _i29.Shipping.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.SupplyUsage?>()) {
      return (data != null ? _i30.SupplyUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.User?>()) {
      return (data != null ? _i31.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.UserRole?>()) {
      return (data != null ? _i32.UserRole.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i19.QuoteFilamentDetail>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.QuoteFilamentDetail>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.QuoteSupplyDetail>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.QuoteSupplyDetail>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.FilamentUsage>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i10.FilamentUsage>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.SupplyUsage>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i30.SupplyUsage>(e)).toList()
          : null) as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as T;
    }
    if (t == List<_i33.User>) {
      return (data as List).map((e) => deserialize<_i33.User>(e)).toList() as T;
    }
    if (t == List<_i34.Filament>) {
      return (data as List).map((e) => deserialize<_i34.Filament>(e)).toList()
          as T;
    }
    if (t == List<_i35.Printer>) {
      return (data as List).map((e) => deserialize<_i35.Printer>(e)).toList()
          as T;
    }
    if (t == List<_i36.Shipping>) {
      return (data as List).map((e) => deserialize<_i36.Shipping>(e)).toList()
          as T;
    }
    if (t == List<_i37.Customer>) {
      return (data as List).map((e) => deserialize<_i37.Customer>(e)).toList()
          as T;
    }
    if (t == List<_i38.ElectricityRate>) {
      return (data as List)
          .map((e) => deserialize<_i38.ElectricityRate>(e))
          .toList() as T;
    }
    if (t == List<_i39.ExtraSupply>) {
      return (data as List)
          .map((e) => deserialize<_i39.ExtraSupply>(e))
          .toList() as T;
    }
    if (t == List<_i40.Quote>) {
      return (data as List).map((e) => deserialize<_i40.Quote>(e)).toList()
          as T;
    }
    if (t == List<_i41.QuoteVersion>) {
      return (data as List)
          .map((e) => deserialize<_i41.QuoteVersion>(e))
          .toList() as T;
    }
    if (t == List<_i42.QuoteCategory>) {
      return (data as List)
          .map((e) => deserialize<_i42.QuoteCategory>(e))
          .toList() as T;
    }
    if (t == List<_i43.Sale>) {
      return (data as List).map((e) => deserialize<_i43.Sale>(e)).toList() as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Greeting) {
      return 'Greeting';
    }
    if (data is _i3.BackupData) {
      return 'BackupData';
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
    if (data is _i8.FilamentCatalogItem) {
      return 'FilamentCatalogItem';
    }
    if (data is _i9.FilamentInventoryMatch) {
      return 'FilamentInventoryMatch';
    }
    if (data is _i10.FilamentUsage) {
      return 'FilamentUsage';
    }
    if (data is _i11.ImportResult) {
      return 'ImportResult';
    }
    if (data is _i12.PaymentStatus) {
      return 'PaymentStatus';
    }
    if (data is _i13.Printer) {
      return 'Printer';
    }
    if (data is _i14.Quote) {
      return 'Quote';
    }
    if (data is _i15.QuoteCategory) {
      return 'QuoteCategory';
    }
    if (data is _i16.QuoteDetails) {
      return 'QuoteDetails';
    }
    if (data is _i17.QuoteExtraSupply) {
      return 'QuoteExtraSupply';
    }
    if (data is _i18.QuoteFilament) {
      return 'QuoteFilament';
    }
    if (data is _i19.QuoteFilamentDetail) {
      return 'QuoteFilamentDetail';
    }
    if (data is _i20.QuoteInput) {
      return 'QuoteInput';
    }
    if (data is _i21.QuoteStatus) {
      return 'QuoteStatus';
    }
    if (data is _i22.QuoteSupplyDetail) {
      return 'QuoteSupplyDetail';
    }
    if (data is _i23.QuoteVersion) {
      return 'QuoteVersion';
    }
    if (data is _i24.QuoteVersionFilament) {
      return 'QuoteVersionFilament';
    }
    if (data is _i25.QuoteVersionSupply) {
      return 'QuoteVersionSupply';
    }
    if (data is _i26.Sale) {
      return 'Sale';
    }
    if (data is _i27.SaleFilamentConsumption) {
      return 'SaleFilamentConsumption';
    }
    if (data is _i28.SaleStatus) {
      return 'SaleStatus';
    }
    if (data is _i29.Shipping) {
      return 'Shipping';
    }
    if (data is _i30.SupplyUsage) {
      return 'SupplyUsage';
    }
    if (data is _i31.User) {
      return 'User';
    }
    if (data is _i32.UserRole) {
      return 'UserRole';
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
      return deserialize<_i2.Greeting>(data['data']);
    }
    if (dataClassName == 'BackupData') {
      return deserialize<_i3.BackupData>(data['data']);
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
    if (dataClassName == 'FilamentCatalogItem') {
      return deserialize<_i8.FilamentCatalogItem>(data['data']);
    }
    if (dataClassName == 'FilamentInventoryMatch') {
      return deserialize<_i9.FilamentInventoryMatch>(data['data']);
    }
    if (dataClassName == 'FilamentUsage') {
      return deserialize<_i10.FilamentUsage>(data['data']);
    }
    if (dataClassName == 'ImportResult') {
      return deserialize<_i11.ImportResult>(data['data']);
    }
    if (dataClassName == 'PaymentStatus') {
      return deserialize<_i12.PaymentStatus>(data['data']);
    }
    if (dataClassName == 'Printer') {
      return deserialize<_i13.Printer>(data['data']);
    }
    if (dataClassName == 'Quote') {
      return deserialize<_i14.Quote>(data['data']);
    }
    if (dataClassName == 'QuoteCategory') {
      return deserialize<_i15.QuoteCategory>(data['data']);
    }
    if (dataClassName == 'QuoteDetails') {
      return deserialize<_i16.QuoteDetails>(data['data']);
    }
    if (dataClassName == 'QuoteExtraSupply') {
      return deserialize<_i17.QuoteExtraSupply>(data['data']);
    }
    if (dataClassName == 'QuoteFilament') {
      return deserialize<_i18.QuoteFilament>(data['data']);
    }
    if (dataClassName == 'QuoteFilamentDetail') {
      return deserialize<_i19.QuoteFilamentDetail>(data['data']);
    }
    if (dataClassName == 'QuoteInput') {
      return deserialize<_i20.QuoteInput>(data['data']);
    }
    if (dataClassName == 'QuoteStatus') {
      return deserialize<_i21.QuoteStatus>(data['data']);
    }
    if (dataClassName == 'QuoteSupplyDetail') {
      return deserialize<_i22.QuoteSupplyDetail>(data['data']);
    }
    if (dataClassName == 'QuoteVersion') {
      return deserialize<_i23.QuoteVersion>(data['data']);
    }
    if (dataClassName == 'QuoteVersionFilament') {
      return deserialize<_i24.QuoteVersionFilament>(data['data']);
    }
    if (dataClassName == 'QuoteVersionSupply') {
      return deserialize<_i25.QuoteVersionSupply>(data['data']);
    }
    if (dataClassName == 'Sale') {
      return deserialize<_i26.Sale>(data['data']);
    }
    if (dataClassName == 'SaleFilamentConsumption') {
      return deserialize<_i27.SaleFilamentConsumption>(data['data']);
    }
    if (dataClassName == 'SaleStatus') {
      return deserialize<_i28.SaleStatus>(data['data']);
    }
    if (dataClassName == 'Shipping') {
      return deserialize<_i29.Shipping>(data['data']);
    }
    if (dataClassName == 'SupplyUsage') {
      return deserialize<_i30.SupplyUsage>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i31.User>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i32.UserRole>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
