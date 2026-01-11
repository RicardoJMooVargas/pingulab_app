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

abstract class QuoteCategory implements _i1.SerializableModel {
  QuoteCategory._({
    this.id,
    required this.name,
    this.description,
    this.icon,
    this.color,
    required this.active,
  });

  factory QuoteCategory({
    int? id,
    required String name,
    String? description,
    String? icon,
    String? color,
    required bool active,
  }) = _QuoteCategoryImpl;

  factory QuoteCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      icon: jsonSerialization['icon'] as String?,
      color: jsonSerialization['color'] as String?,
      active: jsonSerialization['active'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? description;

  String? icon;

  String? color;

  bool active;

  /// Returns a shallow copy of this [QuoteCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteCategory copyWith({
    int? id,
    String? name,
    String? description,
    String? icon,
    String? color,
    bool? active,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      'active': active,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteCategoryImpl extends QuoteCategory {
  _QuoteCategoryImpl({
    int? id,
    required String name,
    String? description,
    String? icon,
    String? color,
    required bool active,
  }) : super._(
          id: id,
          name: name,
          description: description,
          icon: icon,
          color: color,
          active: active,
        );

  /// Returns a shallow copy of this [QuoteCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteCategory copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    Object? icon = _Undefined,
    Object? color = _Undefined,
    bool? active,
  }) {
    return QuoteCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      icon: icon is String? ? icon : this.icon,
      color: color is String? ? color : this.color,
      active: active ?? this.active,
    );
  }
}
