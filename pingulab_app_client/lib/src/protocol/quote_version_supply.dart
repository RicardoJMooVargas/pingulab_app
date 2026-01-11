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

abstract class QuoteVersionSupply implements _i1.SerializableModel {
  QuoteVersionSupply._({
    this.id,
    required this.quoteVersionId,
    required this.extraSupplyId,
    required this.quantity,
    required this.cost,
  });

  factory QuoteVersionSupply({
    int? id,
    required int quoteVersionId,
    required int extraSupplyId,
    required int quantity,
    required double cost,
  }) = _QuoteVersionSupplyImpl;

  factory QuoteVersionSupply.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteVersionSupply(
      id: jsonSerialization['id'] as int?,
      quoteVersionId: jsonSerialization['quoteVersionId'] as int,
      extraSupplyId: jsonSerialization['extraSupplyId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int quoteVersionId;

  int extraSupplyId;

  int quantity;

  double cost;

  /// Returns a shallow copy of this [QuoteVersionSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteVersionSupply copyWith({
    int? id,
    int? quoteVersionId,
    int? extraSupplyId,
    int? quantity,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteVersionId': quoteVersionId,
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

class _QuoteVersionSupplyImpl extends QuoteVersionSupply {
  _QuoteVersionSupplyImpl({
    int? id,
    required int quoteVersionId,
    required int extraSupplyId,
    required int quantity,
    required double cost,
  }) : super._(
          id: id,
          quoteVersionId: quoteVersionId,
          extraSupplyId: extraSupplyId,
          quantity: quantity,
          cost: cost,
        );

  /// Returns a shallow copy of this [QuoteVersionSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteVersionSupply copyWith({
    Object? id = _Undefined,
    int? quoteVersionId,
    int? extraSupplyId,
    int? quantity,
    double? cost,
  }) {
    return QuoteVersionSupply(
      id: id is int? ? id : this.id,
      quoteVersionId: quoteVersionId ?? this.quoteVersionId,
      extraSupplyId: extraSupplyId ?? this.extraSupplyId,
      quantity: quantity ?? this.quantity,
      cost: cost ?? this.cost,
    );
  }
}
