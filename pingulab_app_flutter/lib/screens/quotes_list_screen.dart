import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../services/auth_service.dart';
import 'quote_form_screen.dart';
import 'quote_details_screen.dart';
import 'catalogs_screen.dart';
import 'sales_list_screen.dart';

class QuotesListScreen extends StatefulWidget {
  const QuotesListScreen({super.key});

  @override
  State<QuotesListScreen> createState() => _QuotesListScreenState();
}

class _QuotesListScreenState extends State<QuotesListScreen> {
  List<Quote> _quotes = [];
  List<Quote>? _filteredQuotes;
  List<Customer> _customers = [];
  Map<int, QuoteDetails> _quoteDetailsMap = {};
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _error;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int? _filterCustomerId;
  String? _filterCustomerName;
  QuoteStatus? _filterStatus;
  
  // Paginación
  final int _pageSize = 20;
  int _currentPage = 0;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadCustomers();
    _loadQuotes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      if (!_isLoadingMore && _hasMore && _filteredQuotes == null) {
        _loadMoreQuotes();
      }
    }
  }

  Future<void> _loadCustomers() async {
    try {
      final customers = await client.catalogs.getCustomers();
      setState(() {
        _customers = customers;
      });
    } catch (e) {
      debugPrint('Error loading customers: $e');
    }
  }

  Future<void> _loadQuotes() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _currentPage = 0;
      _hasMore = true;
      _quotes = [];
      _quoteDetailsMap = {};
    });

    try {
      final quotes = await client.quote.getQuotesPaginated(
        limit: _pageSize,
        offset: 0,
      );
      
      // Cargar detalles para obtener información de clientes
      for (var quote in quotes) {
        try {
          final detail = await client.quote.getQuoteDetails(quote.id!);
          if (detail != null) {
            _quoteDetailsMap[quote.id!] = detail;
          }
        } catch (e) {
          debugPrint('Error loading quote details for ${quote.id}: $e');
        }
      }
      
      setState(() {
        _quotes = quotes;
        _hasMore = quotes.length == _pageSize;
        _isLoading = false;
      });
      
      _applyFilters();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreQuotes() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      _currentPage++;
      final newQuotes = await client.quote.getQuotesPaginated(
        limit: _pageSize,
        offset: _currentPage * _pageSize,
      );
      
      // Cargar detalles para las nuevas cotizaciones
      for (var quote in newQuotes) {
        try {
          final detail = await client.quote.getQuoteDetails(quote.id!);
          if (detail != null) {
            _quoteDetailsMap[quote.id!] = detail;
          }
        } catch (e) {
          debugPrint('Error loading quote details for ${quote.id}: $e');
        }
      }
      
      setState(() {
        _quotes.addAll(newQuotes);
        _hasMore = newQuotes.length == _pageSize;
        _isLoadingMore = false;
      });
    } catch (e) {
      debugPrint('Error loading more quotes: $e');
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _applyFilters() {
    List<Quote> filtered = List.from(_quotes);

    // Filtrar por estado
    if (_filterStatus != null) {
      filtered = filtered.where((quote) => quote.status == _filterStatus).toList();
    }

    // Filtrar por cliente
    if (_filterCustomerId != null) {
      filtered = filtered.where((quote) => quote.customerId == _filterCustomerId).toList();
    }

    // Filtrar por búsqueda de texto
    final searchQuery = _searchController.text.toLowerCase().trim();
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((quote) {
        final quoteName = quote.name.toLowerCase();
        final quoteId = 'cotización #${quote.id}';
        final quoteIdAlt = '#${quote.id}';
        
        // Buscar por nombre de cliente si existe
        final detail = _quoteDetailsMap[quote.id];
        final customerName = (detail?.customer?.apodo ?? '').toLowerCase();
        
        return quoteName.contains(searchQuery) ||
               quoteId.contains(searchQuery) ||
               quoteIdAlt.contains(searchQuery) ||
               customerName.contains(searchQuery);
      }).toList();
    }

    setState(() {
      _filteredQuotes = filtered;
    });
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
    final authService = context.watch<AuthService>();
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cotizaciones'),
            if (authService.currentUser != null)
              Text(
                authService.currentUser!.email,
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.sell),
            tooltip: 'Ventas',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SalesListScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.category),
            tooltip: 'Gestionar Catálogos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CatalogsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('¿Cerrar sesión?'),
                  content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Cerrar sesión'),
                    ),
                  ],
                ),
              );
              
              if (confirm == true && mounted) {
                await authService.logout();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por nombre, cliente o #...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _applyFilters();
                        },
                      ),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: _showFilterDialog,
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                _applyFilters();
              },
            ),
          ),
          // Filtros activos
          if (_filterStatus != null || _filterCustomerId != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              color: Colors.teal.shade50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text('Filtros: '),
                    if (_filterStatus != null) ...[
                      Chip(
                        label: Text(_getStatusText(_filterStatus!)),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          setState(() {
                            _filterStatus = null;
                            _applyFilters();
                          });
                        },
                      ),
                      const SizedBox(width: 4),
                    ],
                    if (_filterCustomerId != null) ...[
                      Chip(
                        label: Text('Cliente: $_filterCustomerName'),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          setState(() {
                            _filterCustomerId = null;
                            _filterCustomerName = null;
                            _applyFilters();
                          });
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          Expanded(child: _buildBody()),
        ],
      ),
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

    final quotesToShow = _filteredQuotes ?? _quotes;

    if (quotesToShow.isEmpty && !_isLoading) {
      if (_searchController.text.isNotEmpty || _filterCustomerId != null || _filterStatus != null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No se encontraron cotizaciones',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                'Intenta con otros filtros',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          ),
        );
      }
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

    // Agrupar cotizaciones por cliente
    final Map<String, List<Quote>> groupedQuotes = {};
    for (var quote in quotesToShow) {
      final detail = _quoteDetailsMap[quote.id];
      final customerKey = detail?.customer?.apodo ?? 'Sin cliente';
      if (!groupedQuotes.containsKey(customerKey)) {
        groupedQuotes[customerKey] = [];
      }
      groupedQuotes[customerKey]!.add(quote);
    }

    return RefreshIndicator(
      onRefresh: _loadQuotes,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calcular número de columnas basado en el ancho
          int crossAxisCount;
          if (constraints.maxWidth >= 1400) {
            crossAxisCount = 4; // Pantallas muy grandes: 4 columnas
          } else if (constraints.maxWidth >= 1000) {
            crossAxisCount = 3; // Pantallas grandes: 3 columnas
          } else if (constraints.maxWidth >= 700) {
            crossAxisCount = 2; // Tablets: 2 columnas
          } else {
            crossAxisCount = 1; // Móviles: 1 columna
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Agrupar por cliente si hay múltiples cotizaciones del mismo cliente
              ...groupedQuotes.entries.map((entry) {
                final customerName = entry.key;
                final quotes = entry.value;
                
                return SliverMainAxisGroup(
                  slivers: [
                    // Header del grupo si hay más de 1 cotización del mismo cliente
                    if (quotes.length > 1)
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.teal.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.person, color: Colors.teal.shade700, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                '$customerName (${quotes.length} cotizaciones)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Grid de cotizaciones del cliente
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        16,
                        quotes.length > 1 ? 0 : 16,
                        16,
                        16,
                      ),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final quote = quotes[index];
                            final detail = _quoteDetailsMap[quote.id];
                            return Card(
                              elevation: 2,
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuoteDetailsScreen(quoteId: quote.id!),
                                    ),
                                  );
                                  _loadQuotes();
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Imagen de la cotización si existe
                                    if (quote.imageUrl != null)
                                      Container(
                                        width: double.infinity,
                                        height: 200,
                                        color: Colors.grey[200],
                                        child: Image.memory(
                                          base64Decode(quote.imageUrl!),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[300],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.broken_image,
                                                  size: 48,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    
                                    // Contenido de la tarjeta
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Avatar con número de cotización
                                          CircleAvatar(
                                            backgroundColor: _getStatusColor(quote.status),
                                            child: Text(
                                              '#${quote.id}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          
                                          // Información de la cotización
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  quote.name,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '\$${quote.total.toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.teal,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '${quote.pieceWeightGrams}g • ${quote.printHours}hrs',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
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
                                                if (detail?.customer != null && quotes.length == 1) ...[
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.person, size: 14, color: Colors.grey[600]),
                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          detail!.customer!.apodo,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey[700],
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                          
                                          // Icono de navegación
                                          const Icon(
                                            Icons.chevron_right,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: quotes.length,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
              // Indicador de carga al final
              if (_isLoadingMore)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        QuoteStatus? tempFilterStatus = _filterStatus;
        int? tempFilterCustomerId = _filterCustomerId;
        String? tempFilterCustomerName = _filterCustomerName;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Filtrar Cotizaciones'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cliente:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int?>(
                      value: tempFilterCustomerId,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      hint: const Text('Todos los clientes'),
                      items: [
                        const DropdownMenuItem<int?>(
                          value: null,
                          child: Text('Todos los clientes'),
                        ),
                        ..._customers.map((customer) {
                          return DropdownMenuItem<int?>(
                            value: customer.id,
                            child: Text(customer.apodo),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          tempFilterCustomerId = value;
                          if (value != null) {
                            final customer = _customers.firstWhere((c) => c.id == value);
                            tempFilterCustomerName = customer.apodo;
                          } else {
                            tempFilterCustomerName = null;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('Estado:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('Todos'),
                          selected: tempFilterStatus == null,
                          onSelected: (selected) {
                            setDialogState(() {
                              tempFilterStatus = null;
                            });
                          },
                        ),
                        ...QuoteStatus.values.map((status) {
                          return ChoiceChip(
                            label: Text(_getStatusText(status)),
                            selected: tempFilterStatus == status,
                            onSelected: (selected) {
                              setDialogState(() {
                                tempFilterStatus = selected ? status : null;
                              });
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filterStatus = tempFilterStatus;
                      _filterCustomerId = tempFilterCustomerId;
                      _filterCustomerName = tempFilterCustomerName;
                    });
                    _applyFilters();
                    Navigator.pop(context);
                  },
                  child: const Text('Aplicar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
