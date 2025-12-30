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
import 'customer.dart' as _i3;
import 'electricity_rate.dart' as _i4;
import 'extra_supply.dart' as _i5;
import 'filament.dart' as _i6;
import 'filament_usage.dart' as _i7;
import 'printer.dart' as _i8;
import 'quote.dart' as _i9;
import 'quote_details.dart' as _i10;
import 'quote_extra_supply.dart' as _i11;
import 'quote_filament.dart' as _i12;
import 'quote_filament_detail.dart' as _i13;
import 'quote_input.dart' as _i14;
import 'quote_status.dart' as _i15;
import 'quote_supply_detail.dart' as _i16;
import 'shipping.dart' as _i17;
import 'supply_usage.dart' as _i18;
import 'package:pingulab_app_client/src/protocol/customer.dart' as _i19;
import 'package:pingulab_app_client/src/protocol/quote.dart' as _i20;
import 'package:pingulab_app_client/src/protocol/printer.dart' as _i21;
import 'package:pingulab_app_client/src/protocol/filament.dart' as _i22;
import 'package:pingulab_app_client/src/protocol/extra_supply.dart' as _i23;
import 'package:pingulab_app_client/src/protocol/shipping.dart' as _i24;
import 'package:pingulab_app_client/src/protocol/electricity_rate.dart' as _i25;
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
    if (t == _i3.Customer) {
      return _i3.Customer.fromJson(data) as T;
    }
    if (t == _i4.ElectricityRate) {
      return _i4.ElectricityRate.fromJson(data) as T;
    }
    if (t == _i5.ExtraSupply) {
      return _i5.ExtraSupply.fromJson(data) as T;
    }
    if (t == _i6.Filament) {
      return _i6.Filament.fromJson(data) as T;
    }
    if (t == _i7.FilamentUsage) {
      return _i7.FilamentUsage.fromJson(data) as T;
    }
    if (t == _i8.Printer) {
      return _i8.Printer.fromJson(data) as T;
    }
    if (t == _i9.Quote) {
      return _i9.Quote.fromJson(data) as T;
    }
    if (t == _i10.QuoteDetails) {
      return _i10.QuoteDetails.fromJson(data) as T;
    }
    if (t == _i11.QuoteExtraSupply) {
      return _i11.QuoteExtraSupply.fromJson(data) as T;
    }
    if (t == _i12.QuoteFilament) {
      return _i12.QuoteFilament.fromJson(data) as T;
    }
    if (t == _i13.QuoteFilamentDetail) {
      return _i13.QuoteFilamentDetail.fromJson(data) as T;
    }
    if (t == _i14.QuoteInput) {
      return _i14.QuoteInput.fromJson(data) as T;
    }
    if (t == _i15.QuoteStatus) {
      return _i15.QuoteStatus.fromJson(data) as T;
    }
    if (t == _i16.QuoteSupplyDetail) {
      return _i16.QuoteSupplyDetail.fromJson(data) as T;
    }
    if (t == _i17.Shipping) {
      return _i17.Shipping.fromJson(data) as T;
    }
    if (t == _i18.SupplyUsage) {
      return _i18.SupplyUsage.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Greeting?>()) {
      return (data != null ? _i2.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Customer?>()) {
      return (data != null ? _i3.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ElectricityRate?>()) {
      return (data != null ? _i4.ElectricityRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ExtraSupply?>()) {
      return (data != null ? _i5.ExtraSupply.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Filament?>()) {
      return (data != null ? _i6.Filament.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.FilamentUsage?>()) {
      return (data != null ? _i7.FilamentUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Printer?>()) {
      return (data != null ? _i8.Printer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Quote?>()) {
      return (data != null ? _i9.Quote.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.QuoteDetails?>()) {
      return (data != null ? _i10.QuoteDetails.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.QuoteExtraSupply?>()) {
      return (data != null ? _i11.QuoteExtraSupply.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.QuoteFilament?>()) {
      return (data != null ? _i12.QuoteFilament.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.QuoteFilamentDetail?>()) {
      return (data != null ? _i13.QuoteFilamentDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.QuoteInput?>()) {
      return (data != null ? _i14.QuoteInput.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.QuoteStatus?>()) {
      return (data != null ? _i15.QuoteStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.QuoteSupplyDetail?>()) {
      return (data != null ? _i16.QuoteSupplyDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Shipping?>()) {
      return (data != null ? _i17.Shipping.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.SupplyUsage?>()) {
      return (data != null ? _i18.SupplyUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i13.QuoteFilamentDetail>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.QuoteFilamentDetail>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.QuoteSupplyDetail>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.QuoteSupplyDetail>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.FilamentUsage>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.FilamentUsage>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.SupplyUsage>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i18.SupplyUsage>(e)).toList()
          : null) as T;
    }
    if (t == List<_i19.Customer>) {
      return (data as List).map((e) => deserialize<_i19.Customer>(e)).toList()
          as T;
    }
    if (t == List<_i20.Quote>) {
      return (data as List).map((e) => deserialize<_i20.Quote>(e)).toList()
          as T;
    }
    if (t == List<_i21.Printer>) {
      return (data as List).map((e) => deserialize<_i21.Printer>(e)).toList()
          as T;
    }
    if (t == List<_i22.Filament>) {
      return (data as List).map((e) => deserialize<_i22.Filament>(e)).toList()
          as T;
    }
    if (t == List<_i23.ExtraSupply>) {
      return (data as List)
          .map((e) => deserialize<_i23.ExtraSupply>(e))
          .toList() as T;
    }
    if (t == List<_i24.Shipping>) {
      return (data as List).map((e) => deserialize<_i24.Shipping>(e)).toList()
          as T;
    }
    if (t == List<_i25.ElectricityRate>) {
      return (data as List)
          .map((e) => deserialize<_i25.ElectricityRate>(e))
          .toList() as T;
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
    if (data is _i3.Customer) {
      return 'Customer';
    }
    if (data is _i4.ElectricityRate) {
      return 'ElectricityRate';
    }
    if (data is _i5.ExtraSupply) {
      return 'ExtraSupply';
    }
    if (data is _i6.Filament) {
      return 'Filament';
    }
    if (data is _i7.FilamentUsage) {
      return 'FilamentUsage';
    }
    if (data is _i8.Printer) {
      return 'Printer';
    }
    if (data is _i9.Quote) {
      return 'Quote';
    }
    if (data is _i10.QuoteDetails) {
      return 'QuoteDetails';
    }
    if (data is _i11.QuoteExtraSupply) {
      return 'QuoteExtraSupply';
    }
    if (data is _i12.QuoteFilament) {
      return 'QuoteFilament';
    }
    if (data is _i13.QuoteFilamentDetail) {
      return 'QuoteFilamentDetail';
    }
    if (data is _i14.QuoteInput) {
      return 'QuoteInput';
    }
    if (data is _i15.QuoteStatus) {
      return 'QuoteStatus';
    }
    if (data is _i16.QuoteSupplyDetail) {
      return 'QuoteSupplyDetail';
    }
    if (data is _i17.Shipping) {
      return 'Shipping';
    }
    if (data is _i18.SupplyUsage) {
      return 'SupplyUsage';
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
    if (dataClassName == 'Customer') {
      return deserialize<_i3.Customer>(data['data']);
    }
    if (dataClassName == 'ElectricityRate') {
      return deserialize<_i4.ElectricityRate>(data['data']);
    }
    if (dataClassName == 'ExtraSupply') {
      return deserialize<_i5.ExtraSupply>(data['data']);
    }
    if (dataClassName == 'Filament') {
      return deserialize<_i6.Filament>(data['data']);
    }
    if (dataClassName == 'FilamentUsage') {
      return deserialize<_i7.FilamentUsage>(data['data']);
    }
    if (dataClassName == 'Printer') {
      return deserialize<_i8.Printer>(data['data']);
    }
    if (dataClassName == 'Quote') {
      return deserialize<_i9.Quote>(data['data']);
    }
    if (dataClassName == 'QuoteDetails') {
      return deserialize<_i10.QuoteDetails>(data['data']);
    }
    if (dataClassName == 'QuoteExtraSupply') {
      return deserialize<_i11.QuoteExtraSupply>(data['data']);
    }
    if (dataClassName == 'QuoteFilament') {
      return deserialize<_i12.QuoteFilament>(data['data']);
    }
    if (dataClassName == 'QuoteFilamentDetail') {
      return deserialize<_i13.QuoteFilamentDetail>(data['data']);
    }
    if (dataClassName == 'QuoteInput') {
      return deserialize<_i14.QuoteInput>(data['data']);
    }
    if (dataClassName == 'QuoteStatus') {
      return deserialize<_i15.QuoteStatus>(data['data']);
    }
    if (dataClassName == 'QuoteSupplyDetail') {
      return deserialize<_i16.QuoteSupplyDetail>(data['data']);
    }
    if (dataClassName == 'Shipping') {
      return deserialize<_i17.Shipping>(data['data']);
    }
    if (dataClassName == 'SupplyUsage') {
      return deserialize<_i18.SupplyUsage>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
