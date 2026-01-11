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

abstract class BackupData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  BackupData._({
    required this.version,
    required this.exportDate,
    required this.jsonData,
  });

  factory BackupData({
    required String version,
    required DateTime exportDate,
    required String jsonData,
  }) = _BackupDataImpl;

  factory BackupData.fromJson(Map<String, dynamic> jsonSerialization) {
    return BackupData(
      version: jsonSerialization['version'] as String,
      exportDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['exportDate']),
      jsonData: jsonSerialization['jsonData'] as String,
    );
  }

  String version;

  DateTime exportDate;

  String jsonData;

  /// Returns a shallow copy of this [BackupData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BackupData copyWith({
    String? version,
    DateTime? exportDate,
    String? jsonData,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'exportDate': exportDate.toJson(),
      'jsonData': jsonData,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'version': version,
      'exportDate': exportDate.toJson(),
      'jsonData': jsonData,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _BackupDataImpl extends BackupData {
  _BackupDataImpl({
    required String version,
    required DateTime exportDate,
    required String jsonData,
  }) : super._(
          version: version,
          exportDate: exportDate,
          jsonData: jsonData,
        );

  /// Returns a shallow copy of this [BackupData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BackupData copyWith({
    String? version,
    DateTime? exportDate,
    String? jsonData,
  }) {
    return BackupData(
      version: version ?? this.version,
      exportDate: exportDate ?? this.exportDate,
      jsonData: jsonData ?? this.jsonData,
    );
  }
}
