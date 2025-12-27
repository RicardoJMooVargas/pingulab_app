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

abstract class SupplyUsage implements _i1.SerializableModel {
  SupplyUsage._({
    required this.extraSupplyId,
    required this.quantity,
  });

  factory SupplyUsage({
    required int extraSupplyId,
    required int quantity,
  }) = _SupplyUsageImpl;

  factory SupplyUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupplyUsage(
      extraSupplyId: jsonSerialization['extraSupplyId'] as int,
      quantity: jsonSerialization['quantity'] as int,
    );
  }

  int extraSupplyId;

  int quantity;

  /// Returns a shallow copy of this [SupplyUsage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupplyUsage copyWith({
    int? extraSupplyId,
    int? quantity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'extraSupplyId': extraSupplyId,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SupplyUsageImpl extends SupplyUsage {
  _SupplyUsageImpl({
    required int extraSupplyId,
    required int quantity,
  }) : super._(
          extraSupplyId: extraSupplyId,
          quantity: quantity,
        );

  /// Returns a shallow copy of this [SupplyUsage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupplyUsage copyWith({
    int? extraSupplyId,
    int? quantity,
  }) {
    return SupplyUsage(
      extraSupplyId: extraSupplyId ?? this.extraSupplyId,
      quantity: quantity ?? this.quantity,
    );
  }
}
