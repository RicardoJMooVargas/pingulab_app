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
  Map<int, Customer> _customerMap = {};
  Map<String, bool> _expandedGroups = {}; // Control de grupos expandidos
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _error;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int? _filterCustomerId;
  String? _filterCustomerName;
  QuoteStatus? _filterStatus;

  static const int _pageSize = 20;
  int _currentOffset = 0;

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
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _loadMoreQuotes();
    }
  }

  Future<void> _loadCustomers() async {
    try {
      final customers = await client.catalogs.getCustomers();
      if (mounted) {
        setState(() {
          _customers = customers;
          _customerMap = {for (var c in customers) c.id!: c};
        });
      }
    } catch (e) {
      debugPrint('Error loading customers: $e');
    }
  }

  Future<void> _loadQuotes() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _quotes = [];
      _currentOffset = 0;
      _hasMore = true;
    });

    try {
      final quotes = await client.quote.getQuotesPaginated(
        limit: _pageSize,
        offset: 0,
        status: _filterStatus,
        customerId: _filterCustomerId,
      );

      setState(() {
        _quotes = quotes;
        _currentOffset = quotes.length;
        _hasMore = quotes.length >= _pageSize;
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
    if (_isLoadingMore || !_hasMore || _isLoading) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final quotes = await client.quote.getQuotesPaginated(
        limit: _pageSize,
        offset: _currentOffset,
        status: _filterStatus,
        customerId: _filterCustomerId,
      );

      setState(() {
        _quotes.addAll(quotes);
        _currentOffset += quotes.length;
        _hasMore = quotes.length >= _pageSize;
        _isLoadingMore = false;
      });

      _applyFilters();
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _applyFilters() {
    List<Quote> filtered = List.from(_quotes);

    // Text search (client-side on loaded data)
    final searchQuery = _searchController.text.toLowerCase().trim();
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((quote) {
        final quoteName = quote.name.toLowerCase();
        final quoteId = 'cotización #${quote.id}';
        final quoteIdAlt = '#${quote.id}';
        
        // Use customer map for name lookup
        final customerName = quote.customerId != null
            ? (_customerMap[quote.customerId]?.apodo ?? '').toLowerCase()
            : '';
        
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
      final customerKey = quote.customerId != null
          ? (_customerMap[quote.customerId]?.apodo ?? 'Sin cliente')
          : 'Sin cliente';
      if (!groupedQuotes.containsKey(customerKey)) {
        groupedQuotes[customerKey] = [];
      }
      groupedQuotes[customerKey]!.add(quote);
    }
    
    // Inicializar estado de expansión para nuevos grupos
    for (var entry in groupedQuotes.entries) {
      _expandedGroups.putIfAbsent(entry.key, () => entry.value.length == 1);
    }

    return RefreshIndicator(
      onRefresh: _loadQuotes,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: groupedQuotes.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == groupedQuotes.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          final entry = groupedQuotes.entries.elementAt(index);
          final customerName = entry.key;
          final quotes = entry.value;
          final isExpanded = _expandedGroups[customerName] ?? false;
          
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Header desplegable
                InkWell(
                  onTap: () {
                    setState(() {
                      _expandedGroups[customerName] = !isExpanded;
                    });
                  },
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.vertical(
                        top: const Radius.circular(12),
                        bottom: isExpanded ? Radius.zero : const Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.teal.shade700,
                          radius: 20,
                          child: Text(
                            quotes.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customerName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade900,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${quotes.length} ${quotes.length == 1 ? 'cotización' : 'cotizaciones'}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.teal.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.teal.shade700,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                // Contenido expandible
                if (isExpanded)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Calcular columnas según ancho disponible
                      int crossAxisCount;
                      if (constraints.maxWidth >= 1200) {
                        crossAxisCount = 3;
                      } else if (constraints.maxWidth >= 800) {
                        crossAxisCount = 2;
                      } else {
                        crossAxisCount = 1;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: quotes.length,
                        itemBuilder: (context, quoteIndex) {
                          final quote = quotes[quoteIndex];
                          
                          return Card(
                            elevation: 1,
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
                                      height: 150,
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
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            // Avatar con número de cotización
                                            CircleAvatar(
                                              backgroundColor: _getStatusColor(quote.status),
                                              radius: 18,
                                              child: Text(
                                                '#${quote.id}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                quote.name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
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
                                            fontSize: 13,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
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
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
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

/// Versión sin AppBar para usar con MainNavigationScreen
class QuotesListContent extends StatefulWidget {
  const QuotesListContent({super.key});

  @override
  State<QuotesListContent> createState() => _QuotesListContentState();
}

class _QuotesListContentState extends State<QuotesListContent> {
  List<Quote> _quotes = [];
  List<Quote>? _filteredQuotes;
  List<Customer> _customers = [];
  Map<int, Customer> _customerMap = {};
  Map<String, bool> _expandedGroups = {};
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _error;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int? _filterCustomerId;
  String? _filterCustomerName;
  QuoteStatus? _filterStatus;

  static const int _pageSize = 20;
  int _currentOffset = 0;

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
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _loadMoreQuotes();
    }
  }

  Future<void> _loadCustomers() async {
    try {
      final customers = await client.catalogs.getCustomers();
      if (mounted) {
        setState(() {
          _customers = customers;
          _customerMap = {for (var c in customers) c.id!: c};
        });
      }
    } catch (e) {
      debugPrint('Error loading customers: $e');
    }
  }

  Future<void> _loadQuotes() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _quotes = [];
      _currentOffset = 0;
      _hasMore = true;
    });

    try {
      final quotes = await client.quote.getQuotesPaginated(
        limit: _pageSize,
        offset: 0,
        status: _filterStatus,
        customerId: _filterCustomerId,
      );

      setState(() {
        _quotes = quotes;
        _currentOffset = quotes.length;
        _hasMore = quotes.length >= _pageSize;
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
    if (_isLoadingMore || !_hasMore || _isLoading) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final quotes = await client.quote.getQuotesPaginated(
        limit: _pageSize,
        offset: _currentOffset,
        status: _filterStatus,
        customerId: _filterCustomerId,
      );

      setState(() {
        _quotes.addAll(quotes);
        _currentOffset += quotes.length;
        _hasMore = quotes.length >= _pageSize;
        _isLoadingMore = false;
      });

      _applyFilters();
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _applyFilters() {
    List<Quote> filtered = List.from(_quotes);

    // Text search (client-side on loaded data)
    final searchQuery = _searchController.text.toLowerCase().trim();
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((quote) {
        final quoteName = quote.name.toLowerCase();
        final quoteId = 'cotización #${quote.id}';
        final quoteIdAlt = '#${quote.id}';

        final customerName = quote.customerId != null
            ? (_customerMap[quote.customerId]?.apodo ?? '').toLowerCase()
            : '';

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
    return Scaffold(
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

    final Map<String, List<Quote>> groupedQuotes = {};
    for (var quote in quotesToShow) {
      final customerKey = quote.customerId != null
          ? (_customerMap[quote.customerId]?.apodo ?? 'Sin cliente')
          : 'Sin cliente';
      if (!groupedQuotes.containsKey(customerKey)) {
        groupedQuotes[customerKey] = [];
      }
      groupedQuotes[customerKey]!.add(quote);
    }
    
    for (var entry in groupedQuotes.entries) {
      _expandedGroups.putIfAbsent(entry.key, () => entry.value.length == 1);
    }

    return RefreshIndicator(
      onRefresh: _loadQuotes,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: groupedQuotes.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == groupedQuotes.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          final entry = groupedQuotes.entries.elementAt(index);
          final customerName = entry.key;
          final quotes = entry.value;
          final isExpanded = _expandedGroups[customerName] ?? false;
          
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _expandedGroups[customerName] = !isExpanded;
                    });
                  },
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.vertical(
                        top: const Radius.circular(12),
                        bottom: isExpanded ? Radius.zero : const Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.teal.shade700,
                          radius: 20,
                          child: Text(
                            quotes.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customerName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade900,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${quotes.length} ${quotes.length == 1 ? 'cotización' : 'cotizaciones'}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.teal.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.teal.shade700,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                if (isExpanded)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount;
                      if (constraints.maxWidth >= 1200) {
                        crossAxisCount = 3;
                      } else if (constraints.maxWidth >= 800) {
                        crossAxisCount = 2;
                      } else {
                        crossAxisCount = 1;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: quotes.length,
                        itemBuilder: (context, quoteIndex) {
                          final quote = quotes[quoteIndex];
                          
                          return Card(
                            elevation: 1,
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
                                  if (quote.imageUrl != null)
                                    Container(
                                      width: double.infinity,
                                      height: 150,
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
                                  
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: _getStatusColor(quote.status),
                                              radius: 18,
                                              child: Text(
                                                '#${quote.id}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                quote.name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
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
                                            fontSize: 13,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
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
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
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
