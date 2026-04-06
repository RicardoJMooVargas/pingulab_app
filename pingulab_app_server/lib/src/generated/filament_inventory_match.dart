/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'filament.dart' as _i2;

abstract class FilamentInventoryMatch
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FilamentInventoryMatch._({
    required this.filament,
    required this.requiredGrams,
    required this.remainingGrams,
    required this.isSufficient,
    required this.shortageGrams,
  });

  factory FilamentInventoryMatch({
    required _i2.Filament filament,
    required double requiredGrams,
    required double remainingGrams,
    required bool isSufficient,
    required double shortageGrams,
  }) = _FilamentInventoryMatchImpl;

  factory FilamentInventoryMatch.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FilamentInventoryMatch(
      filament: _i2.Filament.fromJson(
          (jsonSerialization['filament'] as Map<String, dynamic>)),
      requiredGrams: (jsonSerialization['requiredGrams'] as num).toDouble(),
      remainingGrams: (jsonSerialization['remainingGrams'] as num).toDouble(),
      isSufficient: jsonSerialization['isSufficient'] as bool,
      shortageGrams: (jsonSerialization['shortageGrams'] as num).toDouble(),
    );
  }

  _i2.Filament filament;

  double requiredGrams;

  double remainingGrams;

  bool isSufficient;

  double shortageGrams;

  /// Returns a shallow copy of this [FilamentInventoryMatch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FilamentInventoryMatch copyWith({
    _i2.Filament? filament,
    double? requiredGrams,
    double? remainingGrams,
    bool? isSufficient,
    double? shortageGrams,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'filament': filament.toJson(),
      'requiredGrams': requiredGrams,
      'remainingGrams': remainingGrams,
      'isSufficient': isSufficient,
      'shortageGrams': shortageGrams,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'filament': filament.toJsonForProtocol(),
      'requiredGrams': requiredGrams,
      'remainingGrams': remainingGrams,
      'isSufficient': isSufficient,
      'shortageGrams': shortageGrams,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FilamentInventoryMatchImpl extends FilamentInventoryMatch {
  _FilamentInventoryMatchImpl({
    required _i2.Filament filament,
    required double requiredGrams,
    required double remainingGrams,
    required bool isSufficient,
    required double shortageGrams,
  }) : super._(
          filament: filament,
          requiredGrams: requiredGrams,
          remainingGrams: remainingGrams,
          isSufficient: isSufficient,
          shortageGrams: shortageGrams,
        );

  /// Returns a shallow copy of this [FilamentInventoryMatch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FilamentInventoryMatch copyWith({
    _i2.Filament? filament,
    double? requiredGrams,
    double? remainingGrams,
    bool? isSufficient,
    double? shortageGrams,
  }) {
    return FilamentInventoryMatch(
      filament: filament ?? this.filament.copyWith(),
      requiredGrams: requiredGrams ?? this.requiredGrams,
      remainingGrams: remainingGrams ?? this.remainingGrams,
      isSufficient: isSufficient ?? this.isSufficient,
      shortageGrams: shortageGrams ?? this.shortageGrams,
    );
  }
}
