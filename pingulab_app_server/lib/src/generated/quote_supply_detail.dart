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
import 'extra_supply.dart' as _i2;

abstract class QuoteSupplyDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  QuoteSupplyDetail._({
    required this.supply,
    required this.quantity,
    required this.cost,
  });

  factory QuoteSupplyDetail({
    required _i2.ExtraSupply supply,
    required int quantity,
    required double cost,
  }) = _QuoteSupplyDetailImpl;

  factory QuoteSupplyDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteSupplyDetail(
      supply: _i2.ExtraSupply.fromJson(
          (jsonSerialization['supply'] as Map<String, dynamic>)),
      quantity: jsonSerialization['quantity'] as int,
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  _i2.ExtraSupply supply;

  int quantity;

  double cost;

  /// Returns a shallow copy of this [QuoteSupplyDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteSupplyDetail copyWith({
    _i2.ExtraSupply? supply,
    int? quantity,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'supply': supply.toJson(),
      'quantity': quantity,
      'cost': cost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'supply': supply.toJsonForProtocol(),
      'quantity': quantity,
      'cost': cost,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QuoteSupplyDetailImpl extends QuoteSupplyDetail {
  _QuoteSupplyDetailImpl({
    required _i2.ExtraSupply supply,
    required int quantity,
    required double cost,
  }) : super._(
          supply: supply,
          quantity: quantity,
          cost: cost,
        );

  /// Returns a shallow copy of this [QuoteSupplyDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteSupplyDetail copyWith({
    _i2.ExtraSupply? supply,
    int? quantity,
    double? cost,
  }) {
    return QuoteSupplyDetail(
      supply: supply ?? this.supply.copyWith(),
      quantity: quantity ?? this.quantity,
      cost: cost ?? this.cost,
    );
  }
}
