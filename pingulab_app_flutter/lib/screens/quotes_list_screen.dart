import 'package:flutter/material.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import '../main.dart';
import 'quote_form_screen.dart';
import 'quote_details_screen.dart';

class QuotesListScreen extends StatefulWidget {
  const QuotesListScreen({super.key});

  @override
  State<QuotesListScreen> createState() => _QuotesListScreenState();
}

class _QuotesListScreenState extends State<QuotesListScreen> {
  List<Quote>? _quotes;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final quotes = await client.quote.getAllQuotes();
      setState(() {
        _quotes = quotes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Color _getStatusColor(QuoteStatus status) {
    switch (status) {
      case QuoteStatus.PENDIENTE:
        return Colors.orange;
      case QuoteStatus.PROCESO:
        return Colors.blue;
      case QuoteStatus.FINALIZADO:
        return Colors.green;
      case QuoteStatus.CANCELADO:
        return Colors.red;
    }
  }

  String _getStatusText(QuoteStatus status) {
    switch (status) {
      case QuoteStatus.PENDIENTE:
        return 'Pendiente';
      case QuoteStatus.PROCESO:
        return 'En Proceso';
      case QuoteStatus.FINALIZADO:
        return 'Finalizado';
      case QuoteStatus.CANCELADO:
        return 'Cancelado';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotizaciones'),
        backgroundColor: Colors.teal,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuoteFormScreen(),
            ),
          );
          _loadQuotes();
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
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
              onPressed: _loadQuotes,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (_quotes == null || _quotes!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description_outlined,
                size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay cotizaciones',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Presiona + para crear una',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadQuotes,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _quotes!.length,
        itemBuilder: (context, index) {
          final quote = _quotes![index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(quote.status),
                child: Text(
                  '#${quote.id}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                '\$${quote.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('${quote.gramsPrinted}g • ${quote.printHours}hrs'),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(quote.status).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusText(quote.status),
                      style: TextStyle(
                        color: _getStatusColor(quote.status),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuoteDetailsScreen(quoteId: quote.id!),
                  ),
                );
                _loadQuotes();
              },
            ),
          );
        },
      ),
    );
  }
}
