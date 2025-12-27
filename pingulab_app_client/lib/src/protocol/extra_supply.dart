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

abstract class ExtraSupply implements _i1.SerializableModel {
  ExtraSupply._({
    this.id,
    required this.name,
    required this.cost,
  });

  factory ExtraSupply({
    int? id,
    required String name,
    required double cost,
  }) = _ExtraSupplyImpl;

  factory ExtraSupply.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExtraSupply(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  double cost;

  /// Returns a shallow copy of this [ExtraSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExtraSupply copyWith({
    int? id,
    String? name,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'cost': cost,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExtraSupplyImpl extends ExtraSupply {
  _ExtraSupplyImpl({
    int? id,
    required String name,
    required double cost,
  }) : super._(
          id: id,
          name: name,
          cost: cost,
        );

  /// Returns a shallow copy of this [ExtraSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExtraSupply copyWith({
    Object? id = _Undefined,
    String? name,
    double? cost,
  }) {
    return ExtraSupply(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
    );
  }
}
