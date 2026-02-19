import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'quotes_list_screen.dart';
import 'sales_list_screen.dart';
import 'catalogs_screen.dart';

/// Pantalla principal con navegación lateral entre secciones
class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return const QuotesListContent();
      case 1:
        return const SalesListScreen();
      case 2:
        return const CatalogsScreen();
      default:
        return const QuotesListContent();
    }
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Cotizaciones';
      case 1:
        return 'Ventas';
      case 2:
        return 'Catálogos';
      default:
        return 'PinguLab';
    }
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.receipt_long;
      case 1:
        return Icons.sell;
      case 2:
        return Icons.category;
      default:
        return Icons.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    
    // Detectar si es móvil o tablet/desktop
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        
        if (isMobile) {
          // Navegación inferior para móviles
          return Scaffold(
            appBar: AppBar(
              title: Text(_getTitle()),
              backgroundColor: Colors.teal,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Cerrar sesión',
                  onPressed: () => _showLogoutDialog(context, authService),
                ),
              ],
            ),
            body: _getSelectedScreen(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onDestinationSelected,
              selectedItemColor: Colors.teal,
              unselectedItemColor: Colors.grey.shade600,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(_getIcon(0)),
                  label: 'Cotizaciones',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_getIcon(1)),
                  label: 'Ventas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(_getIcon(2)),
                  label: 'Catálogos',
                ),
              ],
            ),
          );
        } else {
          // Navegación lateral para tablets y desktop
          return Scaffold(
            body: Row(
              children: [
                // Barra de navegación lateral
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                  backgroundColor: Colors.teal.shade50,
                  selectedIconTheme: const IconThemeData(
                    color: Colors.teal,
                    size: 32,
                  ),
                  selectedLabelTextStyle: const TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: Colors.grey.shade600,
                    size: 28,
                  ),
                  unselectedLabelTextStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                  labelType: NavigationRailLabelType.all,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.teal,
                          radius: 24,
                          child: Text(
                            authService.currentUser?.email.substring(0, 1).toUpperCase() ?? 'U',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (authService.currentUser != null)
                          SizedBox(
                            width: 80,
                            child: Text(
                              authService.currentUser!.email,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade700,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),
                  trailing: Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: IconButton(
                          icon: const Icon(Icons.logout),
                          tooltip: 'Cerrar sesión',
                          color: Colors.red.shade400,
                          onPressed: () => _showLogoutDialog(context, authService),
                        ),
                      ),
                    ),
                  ),
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(_getIcon(0)),
                      selectedIcon: Icon(_getIcon(0)),
                      label: const Text('Cotizaciones'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(_getIcon(1)),
                      selectedIcon: Icon(_getIcon(1)),
                      label: const Text('Ventas'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(_getIcon(2)),
                      selectedIcon: Icon(_getIcon(2)),
                      label: const Text('Catálogos'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                // Contenido principal
                Expanded(
                  child: _getSelectedScreen(),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> _showLogoutDialog(BuildContext context, AuthService authService) async {
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
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await authService.logout();
    }
  }
}
