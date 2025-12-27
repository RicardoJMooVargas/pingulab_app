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

abstract class Printer implements _i1.SerializableModel {
  Printer._({
    this.id,
    required this.name,
    required this.powerConsumptionWatts,
    required this.available,
  });

  factory Printer({
    int? id,
    required String name,
    required int powerConsumptionWatts,
    required bool available,
  }) = _PrinterImpl;

  factory Printer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Printer(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      powerConsumptionWatts: jsonSerialization['powerConsumptionWatts'] as int,
      available: jsonSerialization['available'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  int powerConsumptionWatts;

  bool available;

  /// Returns a shallow copy of this [Printer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Printer copyWith({
    int? id,
    String? name,
    int? powerConsumptionWatts,
    bool? available,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'powerConsumptionWatts': powerConsumptionWatts,
      'available': available,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrinterImpl extends Printer {
  _PrinterImpl({
    int? id,
    required String name,
    required int powerConsumptionWatts,
    required bool available,
  }) : super._(
          id: id,
          name: name,
          powerConsumptionWatts: powerConsumptionWatts,
          available: available,
        );

  /// Returns a shallow copy of this [Printer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Printer copyWith({
    Object? id = _Undefined,
    String? name,
    int? powerConsumptionWatts,
    bool? available,
  }) {
    return Printer(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      powerConsumptionWatts:
          powerConsumptionWatts ?? this.powerConsumptionWatts,
      available: available ?? this.available,
    );
  }
}
