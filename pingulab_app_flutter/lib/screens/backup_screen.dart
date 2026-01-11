import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../main.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  bool _isLoading = false;
  String? _lastBackupDate;
  Map<String, dynamic>? _lastImportResult;

  Future<void> _exportDatabase() async {
    setState(() {
      _isLoading = true;
      _lastImportResult = null;
    });

    try {
      // Exportar base de datos
      final jsonData = await client.backup.exportDatabase();
      
      // Crear archivo temporal
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.')[0];
      final filePath = '${directory.path}/backup_$timestamp.json';
      final file = File(filePath);
      await file.writeAsString(jsonData);

      setState(() {
        _lastBackupDate = DateTime.now().toString();
        _isLoading = false;
      });

      if (mounted) {
        // Compartir archivo
        await Share.shareXFiles(
          [XFile(filePath)],
          subject: 'Backup PinguLab - $timestamp',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Backup exportado: ${(await file.length() / 1024).toStringAsFixed(2)} KB'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _importDatabase() async {
    try {
      // Seleccionar archivo
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.isEmpty) return;

      final file = File(result.files.first.path!);
      final jsonData = await file.readAsString();

      // Confirmar importación
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('⚠️ Confirmar Importación'),
          content: const Text(
            'Esta acción importará los datos del archivo seleccionado a la base de datos actual.\n\n'
            '- Las columnas que no existan se omitirán\n'
            '- Las columnas nuevas se rellenarán con datos dummy\n'
            '- Los datos actuales no se eliminarán (se agregarán)\n\n'
            '¿Deseas continuar?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Importar'),
            ),
          ],
        ),
      );

      if (confirm != true) return;

      setState(() {
        _isLoading = true;
        _lastImportResult = null;
      });

      // Importar datos
      final resultJson = await client.backup.importDatabase(jsonData);
      final resultMap = jsonDecode(resultJson) as Map<String, dynamic>;

      setState(() {
        _lastImportResult = resultMap;
        _isLoading = false;
      });

      if (mounted) {
        _showImportResults(resultMap);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showImportResults(Map<String, dynamic> result) {
    final success = result['success'] as bool;
    final importedTables = result['importedTables'] as Map<String, dynamic>;
    final errors = (result['errors'] as List).cast<String>();
    final warnings = (result['warnings'] as List).cast<String>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              color: success ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(success ? 'Importación Exitosa' : 'Importación con Errores'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (importedTables.isNotEmpty) ...[
                const Text(
                  '📦 Tablas Importadas:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...importedTables.entries.map((e) => Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 4),
                      child: Text('• ${e.key}: ${e.value} registros'),
                    )),
                const SizedBox(height: 16),
              ],
              if (warnings.isNotEmpty) ...[
                const Text(
                  '⚠️  Advertencias:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                ),
                const SizedBox(height: 8),
                ...warnings.map((w) => Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 4),
                      child: Text(
                        '• $w',
                        style: const TextStyle(fontSize: 12),
                      ),
                    )),
                const SizedBox(height: 16),
              ],
              if (errors.isNotEmpty) ...[
                const Text(
                  '❌ Errores:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 8),
                ...errors.map((e) => Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 4),
                      child: Text(
                        '• $e',
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    )),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup e Importación'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Información
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.blue.shade700),
                            const SizedBox(width: 8),
                            Text(
                              'Información',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Este sistema permite exportar e importar datos de forma segura, '
                          'con compatibilidad hacia versiones futuras del esquema de base de datos.',
                        ),
                        const SizedBox(height: 8),
                        if (_lastBackupDate != null)
                          Text(
                            'Último backup: $_lastBackupDate',
                            style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Exportar
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.file_download, color: Colors.white),
                    ),
                    title: const Text(
                      'Exportar Base de Datos',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'Crea una copia de seguridad de todos los datos',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _exportDatabase,
                  ),
                ),
                const SizedBox(height: 8),

                // Importar
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.file_upload, color: Colors.white),
                    ),
                    title: const Text(
                      'Importar Base de Datos',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'Restaura datos desde un archivo de backup',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _importDatabase,
                  ),
                ),
                const SizedBox(height: 24),

                // Reglas de importación
                Card(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '📋 Reglas de Importación',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildRule('✅', 'Columnas inexistentes en destino se omiten'),
                        _buildRule('✅', 'Columnas nuevas se rellenan con datos dummy'),
                        _buildRule('✅', 'Tablas inexistentes en destino se omiten'),
                        _buildRule('⚠️ ', 'Los datos actuales NO se eliminan'),
                        _buildRule('❌', 'FK obligatorias requieren valores manuales'),
                      ],
                    ),
                  ),
                ),

                // Resultados del último import
                if (_lastImportResult != null) ...[
                  const SizedBox(height: 16),
                  Card(
                    color: (_lastImportResult!['success'] as bool)
                        ? Colors.green.shade50
                        : Colors.red.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Último Resultado',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: (_lastImportResult!['success'] as bool)
                                  ? Colors.green.shade700
                                  : Colors.red.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            (_lastImportResult!['success'] as bool)
                                ? '✅ Importación exitosa'
                                : '❌ Importación con errores',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildRule(String icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
