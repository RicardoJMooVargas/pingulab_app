import 'package:flutter/material.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../services/auth_service.dart';

class QuoteVersionsScreen extends StatefulWidget {
  final int quoteId;
  final String quoteName;

  const QuoteVersionsScreen({
    super.key,
    required this.quoteId,
    required this.quoteName,
  });

  @override
  State<QuoteVersionsScreen> createState() => _QuoteVersionsScreenState();
}

class _QuoteVersionsScreenState extends State<QuoteVersionsScreen> {
  List<QuoteVersion> _versions = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadVersions();
  }

  Future<void> _loadVersions() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final versions = await client.quoteVersion.getQuoteVersions(widget.quoteId);
      setState(() {
        _versions = versions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _createVersion() async {
    final nameController = TextEditingController();
    bool isPrimary = _versions.isEmpty; // First version is primary by default

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('📋 Crear Nueva Versión'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la versión',
                  hintText: 'Ej: Con soporte extra',
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Marcar como principal'),
                subtitle: const Text('Esta versión se mostrará en el historial'),
                value: isPrimary,
                onChanged: (val) => setDialogState(() => isPrimary = val),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Crear'),
            ),
          ],
        ),
      ),
    );

    if (result == true && mounted) {
      setState(() => _isLoading = true);
      try {
        final authService = context.read<AuthService>();
        await client.quoteVersion.createVersionFromQuote(
          widget.quoteId,
          nameController.text.isEmpty ? null : nameController.text,
          isPrimary,
          authService.userId,
        );
        _loadVersions();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Versión creada exitosamente'),
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
  }

  Future<void> _setPrimary(QuoteVersion version) async {
    try {
      await client.quoteVersion.setPrimaryVersion(version.id!);
      _loadVersions();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ "${version.versionName ?? 'Versión ${version.versionNumber}'}" marcada como principal'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
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

  Future<void> _applyVersion(QuoteVersion version) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ Aplicar Versión'),
        content: Text(
          'Esto actualizará la cotización con los datos de "${version.versionName ?? 'Versión ${version.versionNumber}'}". '
          'Los cambios actuales se perderán.\n\n¿Deseas continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      setState(() => _isLoading = true);
      try {
        final authService = context.read<AuthService>();
        await client.quoteVersion.applyVersionToQuote(version.id!, authService.userId);
        _loadVersions();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Versión aplicada a la cotización'),
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
  }

  Future<void> _deleteVersion(QuoteVersion version) async {
    if (version.isPrimary) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ No puedes eliminar la versión principal'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Eliminación'),
        content: Text(
          '¿Eliminar "${version.versionName ?? 'Versión ${version.versionNumber}'}\"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await client.quoteVersion.deleteVersion(version.id!);
        _loadVersions();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Versión eliminada'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Versiones'),
            Text(
              widget.quoteName,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.purple,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createVersion,
        backgroundColor: Colors.teal,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Versión'),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadVersions,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (_versions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay versiones',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Crea una versión para guardar el estado actual',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _versions.length,
      itemBuilder: (context, index) {
        final version = _versions[index];
        final isPrimary = version.isPrimary;

        return Card(
          elevation: isPrimary ? 4 : 2,
          color: isPrimary ? Colors.teal.shade50 : null,
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: isPrimary ? Colors.teal : Colors.grey,
              child: Text(
                'V${version.versionNumber}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    version.versionName ?? 'Versión ${version.versionNumber}',
                    style: TextStyle(
                      fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                if (isPrimary)
                  Chip(
                    label: const Text('Principal', style: TextStyle(fontSize: 11)),
                    backgroundColor: Colors.teal,
                    labelStyle: const TextStyle(color: Colors.white),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Creada: ${_formatDate(version.created)}',
                  style: const TextStyle(fontSize: 12),
                ),
                if (version.notes != null)
                  Text(
                    version.notes!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Detalles de la versión
                    _buildDetailRow('Cantidad', '${version.quantity} piezas'),
                    _buildDetailRow('Peso por pieza', '${version.pieceWeightGrams}g'),
                    _buildDetailRow('Horas de impresión', '${version.printHours}hrs'),
                    _buildDetailRow('Total', '\$${version.total.toStringAsFixed(2)}'),
                    const Divider(height: 24),
                    
                    // Acciones
                    Wrap(
                      spacing: 8,
                      children: [
                        if (!isPrimary)
                          ElevatedButton.icon(
                            onPressed: () => _setPrimary(version),
                            icon: const Icon(Icons.star, size: 18),
                            label: const Text('Marcar Principal'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ElevatedButton.icon(
                          onPressed: () => _applyVersion(version),
                          icon: const Icon(Icons.upload, size: 18),
                          label: const Text('Aplicar a Cotización'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        if (!isPrimary)
                          OutlinedButton.icon(
                            onPressed: () => _deleteVersion(version),
                            icon: const Icon(Icons.delete, size: 18),
                            label: const Text('Eliminar'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
