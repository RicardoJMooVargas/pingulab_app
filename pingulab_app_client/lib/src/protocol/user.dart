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
import 'user_role.dart' as _i2;

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    required this.email,
    required this.passwordHash,
    required this.nombre,
    this.apellido,
    required this.rol,
    required this.activo,
    required this.created,
    this.updated,
  });

  factory User({
    int? id,
    required String email,
    required String passwordHash,
    required String nombre,
    String? apellido,
    required _i2.UserRole rol,
    required bool activo,
    required DateTime created,
    DateTime? updated,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      email: jsonSerialization['email'] as String,
      passwordHash: jsonSerialization['passwordHash'] as String,
      nombre: jsonSerialization['nombre'] as String,
      apellido: jsonSerialization['apellido'] as String?,
      rol: _i2.UserRole.fromJson((jsonSerialization['rol'] as int)),
      activo: jsonSerialization['activo'] as bool,
      created: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['created']),
      updated: jsonSerialization['updated'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updated']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String email;

  String passwordHash;

  String nombre;

  String? apellido;

  _i2.UserRole rol;

  bool activo;

  DateTime created;

  DateTime? updated;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? email,
    String? passwordHash,
    String? nombre,
    String? apellido,
    _i2.UserRole? rol,
    bool? activo,
    DateTime? created,
    DateTime? updated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'email': email,
      'passwordHash': passwordHash,
      'nombre': nombre,
      if (apellido != null) 'apellido': apellido,
      'rol': rol.toJson(),
      'activo': activo,
      'created': created.toJson(),
      if (updated != null) 'updated': updated?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String email,
    required String passwordHash,
    required String nombre,
    String? apellido,
    required _i2.UserRole rol,
    required bool activo,
    required DateTime created,
    DateTime? updated,
  }) : super._(
          id: id,
          email: email,
          passwordHash: passwordHash,
          nombre: nombre,
          apellido: apellido,
          rol: rol,
          activo: activo,
          created: created,
          updated: updated,
        );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? email,
    String? passwordHash,
    String? nombre,
    Object? apellido = _Undefined,
    _i2.UserRole? rol,
    bool? activo,
    DateTime? created,
    Object? updated = _Undefined,
  }) {
    return User(
      id: id is int? ? id : this.id,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      nombre: nombre ?? this.nombre,
      apellido: apellido is String? ? apellido : this.apellido,
      rol: rol ?? this.rol,
      activo: activo ?? this.activo,
      created: created ?? this.created,
      updated: updated is DateTime? ? updated : this.updated,
    );
  }
}
