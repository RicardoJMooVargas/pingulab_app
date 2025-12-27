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

abstract class QuoteExtraSupply implements _i1.SerializableModel {
  QuoteExtraSupply._({
    this.id,
    required this.quoteId,
    required this.extraSupplyId,
    required this.quantity,
    required this.cost,
  });

  factory QuoteExtraSupply({
    int? id,
    required int quoteId,
    required int extraSupplyId,
    required int quantity,
    required double cost,
  }) = _QuoteExtraSupplyImpl;

  factory QuoteExtraSupply.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteExtraSupply(
      id: jsonSerialization['id'] as int?,
      quoteId: jsonSerialization['quoteId'] as int,
      extraSupplyId: jsonSerialization['extraSupplyId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int quoteId;

  int extraSupplyId;

  int quantity;

  double cost;

  /// Returns a shallow copy of this [QuoteExtraSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteExtraSupply copyWith({
    int? id,
    int? quoteId,
    int? extraSupplyId,
    int? quantity,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteId': quoteId,
      'extraSupplyId': extraSupplyId,
      'quantity': quantity,
      'cost': cost,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteExtraSupplyImpl extends QuoteExtraSupply {
  _QuoteExtraSupplyImpl({
    int? id,
    required int quoteId,
    required int extraSupplyId,
    required int quantity,
    required double cost,
  }) : super._(
          id: id,
          quoteId: quoteId,
          extraSupplyId: extraSupplyId,
          quantity: quantity,
          cost: cost,
        );

  /// Returns a shallow copy of this [QuoteExtraSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteExtraSupply copyWith({
    Object? id = _Undefined,
    int? quoteId,
    int? extraSupplyId,
    int? quantity,
    double? cost,
  }) {
    return QuoteExtraSupply(
      id: id is int? ? id : this.id,
      quoteId: quoteId ?? this.quoteId,
      extraSupplyId: extraSupplyId ?? this.extraSupplyId,
      quantity: quantity ?? this.quantity,
      cost: cost ?? this.cost,
    );
  }
}
