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

abstract class Customer implements _i1.SerializableModel {
  Customer._({
    this.id,
    required this.apodo,
    this.nombre,
    this.apellido,
    this.numero,
    this.direccion,
    this.notes,
    required this.created,
    this.updated,
  });

  factory Customer({
    int? id,
    required String apodo,
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
    required DateTime created,
    DateTime? updated,
  }) = _CustomerImpl;

  factory Customer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Customer(
      id: jsonSerialization['id'] as int?,
      apodo: jsonSerialization['apodo'] as String,
      nombre: jsonSerialization['nombre'] as String?,
      apellido: jsonSerialization['apellido'] as String?,
      numero: jsonSerialization['numero'] as String?,
      direccion: jsonSerialization['direccion'] as String?,
      notes: jsonSerialization['notes'] as String?,
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

  String apodo;

  String? nombre;

  String? apellido;

  String? numero;

  String? direccion;

  String? notes;

  DateTime created;

  DateTime? updated;

  /// Returns a shallow copy of this [Customer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Customer copyWith({
    int? id,
    String? apodo,
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
    DateTime? created,
    DateTime? updated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'apodo': apodo,
      if (nombre != null) 'nombre': nombre,
      if (apellido != null) 'apellido': apellido,
      if (numero != null) 'numero': numero,
      if (direccion != null) 'direccion': direccion,
      if (notes != null) 'notes': notes,
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

class _CustomerImpl extends Customer {
  _CustomerImpl({
    int? id,
    required String apodo,
    String? nombre,
    String? apellido,
    String? numero,
    String? direccion,
    String? notes,
    required DateTime created,
    DateTime? updated,
  }) : super._(
          id: id,
          apodo: apodo,
          nombre: nombre,
          apellido: apellido,
          numero: numero,
          direccion: direccion,
          notes: notes,
          created: created,
          updated: updated,
        );

  /// Returns a shallow copy of this [Customer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Customer copyWith({
    Object? id = _Undefined,
    String? apodo,
    Object? nombre = _Undefined,
    Object? apellido = _Undefined,
    Object? numero = _Undefined,
    Object? direccion = _Undefined,
    Object? notes = _Undefined,
    DateTime? created,
    Object? updated = _Undefined,
  }) {
    return Customer(
      id: id is int? ? id : this.id,
      apodo: apodo ?? this.apodo,
      nombre: nombre is String? ? nombre : this.nombre,
      apellido: apellido is String? ? apellido : this.apellido,
      numero: numero is String? ? numero : this.numero,
      direccion: direccion is String? ? direccion : this.direccion,
      notes: notes is String? ? notes : this.notes,
      created: created ?? this.created,
      updated: updated is DateTime? ? updated : this.updated,
    );
  }
}
