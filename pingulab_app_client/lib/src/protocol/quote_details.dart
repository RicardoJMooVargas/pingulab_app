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
import 'quote.dart' as _i2;
import 'quote_filament_detail.dart' as _i3;
import 'quote_supply_detail.dart' as _i4;
import 'customer.dart' as _i5;
import 'printer.dart' as _i6;
import 'shipping.dart' as _i7;

abstract class QuoteDetails implements _i1.SerializableModel {
  QuoteDetails._({
    required this.quote,
    this.filamentDetails,
    this.supplyDetails,
    this.customer,
    this.printer,
    this.shipping,
  });

  factory QuoteDetails({
    required _i2.Quote quote,
    List<_i3.QuoteFilamentDetail>? filamentDetails,
    List<_i4.QuoteSupplyDetail>? supplyDetails,
    _i5.Customer? customer,
    _i6.Printer? printer,
    _i7.Shipping? shipping,
  }) = _QuoteDetailsImpl;

  factory QuoteDetails.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteDetails(
      quote: _i2.Quote.fromJson(
          (jsonSerialization['quote'] as Map<String, dynamic>)),
      filamentDetails: (jsonSerialization['filamentDetails'] as List?)
          ?.map((e) =>
              _i3.QuoteFilamentDetail.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supplyDetails: (jsonSerialization['supplyDetails'] as List?)
          ?.map((e) =>
              _i4.QuoteSupplyDetail.fromJson((e as Map<String, dynamic>)))
          .toList(),
      customer: jsonSerialization['customer'] == null
          ? null
          : _i5.Customer.fromJson(
              (jsonSerialization['customer'] as Map<String, dynamic>)),
      printer: jsonSerialization['printer'] == null
          ? null
          : _i6.Printer.fromJson(
              (jsonSerialization['printer'] as Map<String, dynamic>)),
      shipping: jsonSerialization['shipping'] == null
          ? null
          : _i7.Shipping.fromJson(
              (jsonSerialization['shipping'] as Map<String, dynamic>)),
    );
  }

  _i2.Quote quote;

  List<_i3.QuoteFilamentDetail>? filamentDetails;

  List<_i4.QuoteSupplyDetail>? supplyDetails;

  _i5.Customer? customer;

  _i6.Printer? printer;

  _i7.Shipping? shipping;

  /// Returns a shallow copy of this [QuoteDetails]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteDetails copyWith({
    _i2.Quote? quote,
    List<_i3.QuoteFilamentDetail>? filamentDetails,
    List<_i4.QuoteSupplyDetail>? supplyDetails,
    _i5.Customer? customer,
    _i6.Printer? printer,
    _i7.Shipping? shipping,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'quote': quote.toJson(),
      if (filamentDetails != null)
        'filamentDetails':
            filamentDetails?.toJson(valueToJson: (v) => v.toJson()),
      if (supplyDetails != null)
        'supplyDetails': supplyDetails?.toJson(valueToJson: (v) => v.toJson()),
      if (customer != null) 'customer': customer?.toJson(),
      if (printer != null) 'printer': printer?.toJson(),
      if (shipping != null) 'shipping': shipping?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteDetailsImpl extends QuoteDetails {
  _QuoteDetailsImpl({
    required _i2.Quote quote,
    List<_i3.QuoteFilamentDetail>? filamentDetails,
    List<_i4.QuoteSupplyDetail>? supplyDetails,
    _i5.Customer? customer,
    _i6.Printer? printer,
    _i7.Shipping? shipping,
  }) : super._(
          quote: quote,
          filamentDetails: filamentDetails,
          supplyDetails: supplyDetails,
          customer: customer,
          printer: printer,
          shipping: shipping,
        );

  /// Returns a shallow copy of this [QuoteDetails]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteDetails copyWith({
    _i2.Quote? quote,
    Object? filamentDetails = _Undefined,
    Object? supplyDetails = _Undefined,
    Object? customer = _Undefined,
    Object? printer = _Undefined,
    Object? shipping = _Undefined,
  }) {
    return QuoteDetails(
      quote: quote ?? this.quote.copyWith(),
      filamentDetails: filamentDetails is List<_i3.QuoteFilamentDetail>?
          ? filamentDetails
          : this.filamentDetails?.map((e0) => e0.copyWith()).toList(),
      supplyDetails: supplyDetails is List<_i4.QuoteSupplyDetail>?
          ? supplyDetails
          : this.supplyDetails?.map((e0) => e0.copyWith()).toList(),
      customer:
          customer is _i5.Customer? ? customer : this.customer?.copyWith(),
      printer: printer is _i6.Printer? ? printer : this.printer?.copyWith(),
      shipping:
          shipping is _i7.Shipping? ? shipping : this.shipping?.copyWith(),
    );
  }
}
