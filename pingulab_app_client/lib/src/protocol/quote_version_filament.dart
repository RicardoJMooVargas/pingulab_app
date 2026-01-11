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

abstract class QuoteVersionFilament implements _i1.SerializableModel {
  QuoteVersionFilament._({
    this.id,
    required this.quoteVersionId,
    required this.filamentId,
    required this.gramsUsed,
    required this.cost,
  });

  factory QuoteVersionFilament({
    int? id,
    required int quoteVersionId,
    required int filamentId,
    required double gramsUsed,
    required double cost,
  }) = _QuoteVersionFilamentImpl;

  factory QuoteVersionFilament.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return QuoteVersionFilament(
      id: jsonSerialization['id'] as int?,
      quoteVersionId: jsonSerialization['quoteVersionId'] as int,
      filamentId: jsonSerialization['filamentId'] as int,
      gramsUsed: (jsonSerialization['gramsUsed'] as num).toDouble(),
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int quoteVersionId;

  int filamentId;

  double gramsUsed;

  double cost;

  /// Returns a shallow copy of this [QuoteVersionFilament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteVersionFilament copyWith({
    int? id,
    int? quoteVersionId,
    int? filamentId,
    double? gramsUsed,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteVersionId': quoteVersionId,
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

class _QuoteVersionFilamentImpl extends QuoteVersionFilament {
  _QuoteVersionFilamentImpl({
    int? id,
    required int quoteVersionId,
    required int filamentId,
    required double gramsUsed,
    required double cost,
  }) : super._(
          id: id,
          quoteVersionId: quoteVersionId,
          filamentId: filamentId,
          gramsUsed: gramsUsed,
          cost: cost,
        );

  /// Returns a shallow copy of this [QuoteVersionFilament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteVersionFilament copyWith({
    Object? id = _Undefined,
    int? quoteVersionId,
    int? filamentId,
    double? gramsUsed,
    double? cost,
  }) {
    return QuoteVersionFilament(
      id: id is int? ? id : this.id,
      quoteVersionId: quoteVersionId ?? this.quoteVersionId,
      filamentId: filamentId ?? this.filamentId,
      gramsUsed: gramsUsed ?? this.gramsUsed,
      cost: cost ?? this.cost,
    );
  }
}
