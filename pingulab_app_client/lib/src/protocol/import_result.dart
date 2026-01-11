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

abstract class ImportResult implements _i1.SerializableModel {
  ImportResult._({
    required this.success,
    required this.importedTables,
    required this.skippedTables,
    required this.errors,
    required this.warnings,
  });

  factory ImportResult({
    required bool success,
    required String importedTables,
    required List<String> skippedTables,
    required List<String> errors,
    required List<String> warnings,
  }) = _ImportResultImpl;

  factory ImportResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return ImportResult(
      success: jsonSerialization['success'] as bool,
      importedTables: jsonSerialization['importedTables'] as String,
      skippedTables: (jsonSerialization['skippedTables'] as List)
          .map((e) => e as String)
          .toList(),
      errors: (jsonSerialization['errors'] as List)
          .map((e) => e as String)
          .toList(),
      warnings: (jsonSerialization['warnings'] as List)
          .map((e) => e as String)
          .toList(),
    );
  }

  bool success;

  String importedTables;

  List<String> skippedTables;

  List<String> errors;

  List<String> warnings;

  /// Returns a shallow copy of this [ImportResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ImportResult copyWith({
    bool? success,
    String? importedTables,
    List<String>? skippedTables,
    List<String>? errors,
    List<String>? warnings,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'importedTables': importedTables,
      'skippedTables': skippedTables.toJson(),
      'errors': errors.toJson(),
      'warnings': warnings.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ImportResultImpl extends ImportResult {
  _ImportResultImpl({
    required bool success,
    required String importedTables,
    required List<String> skippedTables,
    required List<String> errors,
    required List<String> warnings,
  }) : super._(
          success: success,
          importedTables: importedTables,
          skippedTables: skippedTables,
          errors: errors,
          warnings: warnings,
        );

  /// Returns a shallow copy of this [ImportResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ImportResult copyWith({
    bool? success,
    String? importedTables,
    List<String>? skippedTables,
    List<String>? errors,
    List<String>? warnings,
  }) {
    return ImportResult(
      success: success ?? this.success,
      importedTables: importedTables ?? this.importedTables,
      skippedTables:
          skippedTables ?? this.skippedTables.map((e0) => e0).toList(),
      errors: errors ?? this.errors.map((e0) => e0).toList(),
      warnings: warnings ?? this.warnings.map((e0) => e0).toList(),
    );
  }
}
