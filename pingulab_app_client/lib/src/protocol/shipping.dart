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

abstract class Shipping implements _i1.SerializableModel {
  Shipping._({
    this.id,
    required this.shippingType,
    required this.carrierName,
    required this.cost,
  });

  factory Shipping({
    int? id,
    required String shippingType,
    required String carrierName,
    required double cost,
  }) = _ShippingImpl;

  factory Shipping.fromJson(Map<String, dynamic> jsonSerialization) {
    return Shipping(
      id: jsonSerialization['id'] as int?,
      shippingType: jsonSerialization['shippingType'] as String,
      carrierName: jsonSerialization['carrierName'] as String,
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String shippingType;

  String carrierName;

  double cost;

  /// Returns a shallow copy of this [Shipping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Shipping copyWith({
    int? id,
    String? shippingType,
    String? carrierName,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'shippingType': shippingType,
      'carrierName': carrierName,
      'cost': cost,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShippingImpl extends Shipping {
  _ShippingImpl({
    int? id,
    required String shippingType,
    required String carrierName,
    required double cost,
  }) : super._(
          id: id,
          shippingType: shippingType,
          carrierName: carrierName,
          cost: cost,
        );

  /// Returns a shallow copy of this [Shipping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Shipping copyWith({
    Object? id = _Undefined,
    String? shippingType,
    String? carrierName,
    double? cost,
  }) {
    return Shipping(
      id: id is int? ? id : this.id,
      shippingType: shippingType ?? this.shippingType,
      carrierName: carrierName ?? this.carrierName,
      cost: cost ?? this.cost,
    );
  }
}
