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
import 'filament.dart' as _i2;

abstract class QuoteFilamentDetail implements _i1.SerializableModel {
  QuoteFilamentDetail._({
    required this.filament,
    required this.gramsUsed,
    required this.cost,
  });

  factory QuoteFilamentDetail({
    required _i2.Filament filament,
    required double gramsUsed,
    required double cost,
  }) = _QuoteFilamentDetailImpl;

  factory QuoteFilamentDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteFilamentDetail(
      filament: _i2.Filament.fromJson(
          (jsonSerialization['filament'] as Map<String, dynamic>)),
      gramsUsed: (jsonSerialization['gramsUsed'] as num).toDouble(),
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  _i2.Filament filament;

  double gramsUsed;

  double cost;

  /// Returns a shallow copy of this [QuoteFilamentDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteFilamentDetail copyWith({
    _i2.Filament? filament,
    double? gramsUsed,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'filament': filament.toJson(),
      'gramsUsed': gramsUsed,
      'cost': cost,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QuoteFilamentDetailImpl extends QuoteFilamentDetail {
  _QuoteFilamentDetailImpl({
    required _i2.Filament filament,
    required double gramsUsed,
    required double cost,
  }) : super._(
          filament: filament,
          gramsUsed: gramsUsed,
          cost: cost,
        );

  /// Returns a shallow copy of this [QuoteFilamentDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteFilamentDetail copyWith({
    _i2.Filament? filament,
    double? gramsUsed,
    double? cost,
  }) {
    return QuoteFilamentDetail(
      filament: filament ?? this.filament.copyWith(),
      gramsUsed: gramsUsed ?? this.gramsUsed,
      cost: cost ?? this.cost,
    );
  }
}
