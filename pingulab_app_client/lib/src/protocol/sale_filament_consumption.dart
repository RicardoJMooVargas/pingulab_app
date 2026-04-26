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

abstract class SaleFilamentConsumption implements _i1.SerializableModel {
  SaleFilamentConsumption._({
    this.id,
    required this.saleId,
    required this.filamentId,
    required this.gramsConsumed,
  });

  factory SaleFilamentConsumption({
    int? id,
    required int saleId,
    required int filamentId,
    required double gramsConsumed,
  }) = _SaleFilamentConsumptionImpl;

  factory SaleFilamentConsumption.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SaleFilamentConsumption(
      id: jsonSerialization['id'] as int?,
      saleId: jsonSerialization['saleId'] as int,
      filamentId: jsonSerialization['filamentId'] as int,
      gramsConsumed: (jsonSerialization['gramsConsumed'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int saleId;

  int filamentId;

  double gramsConsumed;

  /// Returns a shallow copy of this [SaleFilamentConsumption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SaleFilamentConsumption copyWith({
    int? id,
    int? saleId,
    int? filamentId,
    double? gramsConsumed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'saleId': saleId,
      'filamentId': filamentId,
      'gramsConsumed': gramsConsumed,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SaleFilamentConsumptionImpl extends SaleFilamentConsumption {
  _SaleFilamentConsumptionImpl({
    int? id,
    required int saleId,
    required int filamentId,
    required double gramsConsumed,
  }) : super._(
          id: id,
          saleId: saleId,
          filamentId: filamentId,
          gramsConsumed: gramsConsumed,
        );

  /// Returns a shallow copy of this [SaleFilamentConsumption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SaleFilamentConsumption copyWith({
    Object? id = _Undefined,
    int? saleId,
    int? filamentId,
    double? gramsConsumed,
  }) {
    return SaleFilamentConsumption(
      id: id is int? ? id : this.id,
      saleId: saleId ?? this.saleId,
      filamentId: filamentId ?? this.filamentId,
      gramsConsumed: gramsConsumed ?? this.gramsConsumed,
    );
  }
}
