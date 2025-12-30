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

abstract class FilamentUsage
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  FilamentUsage._({
    required this.filamentId,
    required this.gramsUsed,
  });

  factory FilamentUsage({
    required int filamentId,
    required double gramsUsed,
  }) = _FilamentUsageImpl;

  factory FilamentUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return FilamentUsage(
      filamentId: jsonSerialization['filamentId'] as int,
      gramsUsed: (jsonSerialization['gramsUsed'] as num).toDouble(),
    );
  }

  int filamentId;

  double gramsUsed;

  /// Returns a shallow copy of this [FilamentUsage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FilamentUsage copyWith({
    int? filamentId,
    double? gramsUsed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'filamentId': filamentId,
      'gramsUsed': gramsUsed,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'filamentId': filamentId,
      'gramsUsed': gramsUsed,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FilamentUsageImpl extends FilamentUsage {
  _FilamentUsageImpl({
    required int filamentId,
    required double gramsUsed,
  }) : super._(
          filamentId: filamentId,
          gramsUsed: gramsUsed,
        );

  /// Returns a shallow copy of this [FilamentUsage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FilamentUsage copyWith({
    int? filamentId,
    double? gramsUsed,
  }) {
    return FilamentUsage(
      filamentId: filamentId ?? this.filamentId,
      gramsUsed: gramsUsed ?? this.gramsUsed,
    );
  }
}
