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

abstract class ElectricityRate implements _i1.SerializableModel {
  ElectricityRate._({
    this.id,
    required this.costPerKwh,
    required this.active,
  });

  factory ElectricityRate({
    int? id,
    required double costPerKwh,
    required bool active,
  }) = _ElectricityRateImpl;

  factory ElectricityRate.fromJson(Map<String, dynamic> jsonSerialization) {
    return ElectricityRate(
      id: jsonSerialization['id'] as int?,
      costPerKwh: (jsonSerialization['costPerKwh'] as num).toDouble(),
      active: jsonSerialization['active'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  double costPerKwh;

  bool active;

  /// Returns a shallow copy of this [ElectricityRate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ElectricityRate copyWith({
    int? id,
    double? costPerKwh,
    bool? active,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'costPerKwh': costPerKwh,
      'active': active,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ElectricityRateImpl extends ElectricityRate {
  _ElectricityRateImpl({
    int? id,
    required double costPerKwh,
    required bool active,
  }) : super._(
          id: id,
          costPerKwh: costPerKwh,
          active: active,
        );

  /// Returns a shallow copy of this [ElectricityRate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ElectricityRate copyWith({
    Object? id = _Undefined,
    double? costPerKwh,
    bool? active,
  }) {
    return ElectricityRate(
      id: id is int? ? id : this.id,
      costPerKwh: costPerKwh ?? this.costPerKwh,
      active: active ?? this.active,
    );
  }
}
