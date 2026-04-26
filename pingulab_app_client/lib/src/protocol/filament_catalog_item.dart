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

abstract class FilamentCatalogItem implements _i1.SerializableModel {
  FilamentCatalogItem._({
    this.id,
    required this.materialType,
    required this.color,
    required this.active,
  });

  factory FilamentCatalogItem({
    int? id,
    required String materialType,
    required String color,
    required bool active,
  }) = _FilamentCatalogItemImpl;

  factory FilamentCatalogItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return FilamentCatalogItem(
      id: jsonSerialization['id'] as int?,
      materialType: jsonSerialization['materialType'] as String,
      color: jsonSerialization['color'] as String,
      active: jsonSerialization['active'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String materialType;

  String color;

  bool active;

  /// Returns a shallow copy of this [FilamentCatalogItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FilamentCatalogItem copyWith({
    int? id,
    String? materialType,
    String? color,
    bool? active,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'materialType': materialType,
      'color': color,
      'active': active,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FilamentCatalogItemImpl extends FilamentCatalogItem {
  _FilamentCatalogItemImpl({
    int? id,
    required String materialType,
    required String color,
    required bool active,
  }) : super._(
          id: id,
          materialType: materialType,
          color: color,
          active: active,
        );

  /// Returns a shallow copy of this [FilamentCatalogItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FilamentCatalogItem copyWith({
    Object? id = _Undefined,
    String? materialType,
    String? color,
    bool? active,
  }) {
    return FilamentCatalogItem(
      id: id is int? ? id : this.id,
      materialType: materialType ?? this.materialType,
      color: color ?? this.color,
      active: active ?? this.active,
    );
  }
}
