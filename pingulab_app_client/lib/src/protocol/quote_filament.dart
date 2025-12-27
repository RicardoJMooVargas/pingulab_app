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

abstract class QuoteFilament implements _i1.SerializableModel {
  QuoteFilament._({
    this.id,
    required this.quoteId,
    required this.filamentId,
    required this.gramsUsed,
    required this.cost,
  });

  factory QuoteFilament({
    int? id,
    required int quoteId,
    required int filamentId,
    required double gramsUsed,
    required double cost,
  }) = _QuoteFilamentImpl;

  factory QuoteFilament.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteFilament(
      id: jsonSerialization['id'] as int?,
      quoteId: jsonSerialization['quoteId'] as int,
      filamentId: jsonSerialization['filamentId'] as int,
      gramsUsed: (jsonSerialization['gramsUsed'] as num).toDouble(),
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int quoteId;

  int filamentId;

  double gramsUsed;

  double cost;

  /// Returns a shallow copy of this [QuoteFilament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteFilament copyWith({
    int? id,
    int? quoteId,
    int? filamentId,
    double? gramsUsed,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteId': quoteId,
      'filamentId': filamentId,
      'gramsUsed': gramsUsed,
      'cost': cost,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteFilamentImpl extends QuoteFilament {
  _QuoteFilamentImpl({
    int? id,
    required int quoteId,
    required int filamentId,
    required double gramsUsed,
    required double cost,
  }) : super._(
          id: id,
          quoteId: quoteId,
          filamentId: filamentId,
          gramsUsed: gramsUsed,
          cost: cost,
        );

  /// Returns a shallow copy of this [QuoteFilament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteFilament copyWith({
    Object? id = _Undefined,
    int? quoteId,
    int? filamentId,
    double? gramsUsed,
    double? cost,
  }) {
    return QuoteFilament(
      id: id is int? ? id : this.id,
      quoteId: quoteId ?? this.quoteId,
      filamentId: filamentId ?? this.filamentId,
      gramsUsed: gramsUsed ?? this.gramsUsed,
      cost: cost ?? this.cost,
    );
  }
}
