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

abstract class Filament implements _i1.SerializableModel {
  Filament._({
    this.id,
    required this.name,
    required this.brand,
    required this.materialType,
    required this.color,
    required this.spoolWeightKg,
    required this.spoolCost,
  });

  factory Filament({
    int? id,
    required String name,
    required String brand,
    required String materialType,
    required String color,
    required double spoolWeightKg,
    required double spoolCost,
  }) = _FilamentImpl;

  factory Filament.fromJson(Map<String, dynamic> jsonSerialization) {
    return Filament(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      brand: jsonSerialization['brand'] as String,
      materialType: jsonSerialization['materialType'] as String,
      color: jsonSerialization['color'] as String,
      spoolWeightKg: (jsonSerialization['spoolWeightKg'] as num).toDouble(),
      spoolCost: (jsonSerialization['spoolCost'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String brand;

  String materialType;

  String color;

  double spoolWeightKg;

  double spoolCost;

  /// Returns a shallow copy of this [Filament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Filament copyWith({
    int? id,
    String? name,
    String? brand,
    String? materialType,
    String? color,
    double? spoolWeightKg,
    double? spoolCost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'brand': brand,
      'materialType': materialType,
      'color': color,
      'spoolWeightKg': spoolWeightKg,
      'spoolCost': spoolCost,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FilamentImpl extends Filament {
  _FilamentImpl({
    int? id,
    required String name,
    required String brand,
    required String materialType,
    required String color,
    required double spoolWeightKg,
    required double spoolCost,
  }) : super._(
          id: id,
          name: name,
          brand: brand,
          materialType: materialType,
          color: color,
          spoolWeightKg: spoolWeightKg,
          spoolCost: spoolCost,
        );

  /// Returns a shallow copy of this [Filament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Filament copyWith({
    Object? id = _Undefined,
    String? name,
    String? brand,
    String? materialType,
    String? color,
    double? spoolWeightKg,
    double? spoolCost,
  }) {
    return Filament(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      materialType: materialType ?? this.materialType,
      color: color ?? this.color,
      spoolWeightKg: spoolWeightKg ?? this.spoolWeightKg,
      spoolCost: spoolCost ?? this.spoolCost,
    );
  }
}
