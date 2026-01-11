import 'dart:convert';
import 'package:serverpod/serverpod.dart';

class BackupEndpoint extends Endpoint {
  /// Exporta todos los datos de todas las tablas en formato JSON
  Future<String> exportDatabase(Session session) async {
    try {
      final export = <String, dynamic>{
        'version': '1.0',
        'exportDate': DateTime.now().toIso8601String(),
        'tables': <String, List<Map<String, dynamic>>>{},
      };

      // Lista de tablas a exportar
      final tables = [
        'customers',
        'filaments',
        'printers',
        'shippings',
        'electricity_rates',
        'extra_supplies',
        'quotes',
        'quote_filaments',
        'quote_extra_supplies',
        'users',
      ];

      for (var table in tables) {
        try {
          final result = await session.db.unsafeQuery('SELECT * FROM $table');
          export['tables'][table] = result.map((row) => row.toColumnMap()).toList();
          session.log('✅ Exportada tabla $table: ${result.length} registros');
        } catch (e) {
          session.log('⚠️ Error exportando tabla $table: $e');
        }
      }

      return jsonEncode(export);
    } catch (e) {
      session.log('❌ Error en exportDatabase: $e');
      throw Exception('Error al exportar base de datos: $e');
    }
  }

  /// Importa datos con validación de esquema y compatibilidad
  Future<String> importDatabase(Session session, String jsonData) async {
    var success = true;
    final importedTables = <String, int>{};
    final skippedTables = <String>[];
    final errors = <String>[];
    final warnings = <String>[];

    try {
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      final tables = data['tables'] as Map<String, dynamic>;

      session.log('📦 Iniciando importación de ${tables.length} tablas');

      final importOrder = [
        'users',
        'customers',
        'filaments',
        'printers',
        'shippings',
        'electricity_rates',
        'extra_supplies',
        'quotes',
        'quote_filaments',
        'quote_extra_supplies',
      ];

      for (var tableName in importOrder) {
        if (!tables.containsKey(tableName)) continue;

        final rows = tables[tableName] as List<dynamic>;
        if (rows.isEmpty) continue;

        try {
          final result = await _importTable(session, tableName, rows);
          importedTables[tableName] = result['imported'] as int;
          
          if (result['warnings'] != null) {
            warnings.addAll((result['warnings'] as List<dynamic>).cast<String>());
          }
        } catch (e) {
          final errorMsg = 'Error importando tabla $tableName: $e';
          session.log('❌ $errorMsg');
          errors.add(errorMsg);
          success = false;
        }
      }

      return jsonEncode({
        'success': success,
        'importedTables': importedTables,
        'skippedTables': skippedTables,
        'errors': errors,
        'warnings': warnings,
      });
    } catch (e) {
      return jsonEncode({
        'success': false,
        'importedTables': importedTables,
        'errors': [e.toString()],
        'warnings': warnings,
      });
    }
  }

  Future<Map<String, dynamic>> _importTable(
    Session session,
    String tableName,
    List<dynamic> rows,
  ) async {
    final result = {'imported': 0, 'warnings': <String>[]};

    final schemaQuery = await session.db.unsafeQuery('''
      SELECT column_name, is_nullable, data_type
      FROM information_schema.columns
      WHERE table_name = '$tableName'
    ''');

    if (schemaQuery.isEmpty) return result;

    final targetColumns = <String, String>{};
    for (var col in schemaQuery) {
      final colMap = col.toColumnMap();
      targetColumns[colMap['column_name'] as String] = colMap['data_type'] as String;
    }

    for (var rowData in rows) {
      final row = rowData as Map<String, dynamic>;
      final cleanRow = <String, dynamic>{};

      for (var entry in row.entries) {
        if (targetColumns.containsKey(entry.key) && entry.key != 'id') {
          cleanRow[entry.key] = entry.value;
        }
      }

      if (cleanRow.isEmpty) continue;

      final columns = cleanRow.keys.toList();
      final values = cleanRow.values.toList();
      
      // Construir valores escapados manualmente
      final escapedValues = values.map((v) {
        if (v == null) return 'NULL';
        if (v is String) return "'${v.replaceAll("'", "''")}'";
        if (v is DateTime) return "'${v.toIso8601String()}'";
        return v.toString();
      }).join(', ');

      await session.db.unsafeQuery(
        'INSERT INTO $tableName (${columns.join(', ')}) VALUES ($escapedValues)',
      );

      result['imported'] = (result['imported'] as int) + 1;
    }

    return result;
  }
}
