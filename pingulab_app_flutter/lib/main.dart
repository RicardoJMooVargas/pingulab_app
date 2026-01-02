import 'dart:io';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'screens/quotes_list_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late final Client client;

late String serverUrl;

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Allow self-signed certificates for development/testing
  // Remove this in production once SSL is properly configured
  HttpOverrides.global = MyHttpOverrides();
  
  // Production URL - change this when deploying
  // For development, use: http://$localhost:8080/
  // For production, use your deployed URL
  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  
  String defaultUrl;
  // Use production URL by default for release builds
  if (const bool.fromEnvironment('dart.vm.product')) {
    defaultUrl = 'https://api3d.mogastisolutions.engineer/';
  } else {
    defaultUrl = 'http://$localhost:8080/';
  }
  
  final serverUrl = serverUrlFromEnv.isEmpty ? defaultUrl : serverUrlFromEnv;

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor();

  // Inicializar base de datos si es necesario
  try {
    await client.init.initializeDatabase();
    if (kDebugMode) {
      print('✅ Base de datos inicializada');
    }
  } catch (e) {
    if (kDebugMode) {
      print('⚠️  Error al inicializar base de datos: $e');
    }
  }

  runApp(const MyApp());
}

/// Allows self-signed or invalid certificates
/// WARNING: Only use this for development/testing
/// Remove or comment out for production with valid SSL
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        if (kDebugMode) {
          print('⚠️  Accepting certificate for $host:$port');
        }
        return true; // Accept all certificates
      };
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'PinguLab - Cotizaciones 3D',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

/// Wrapper to handle authentication state
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, _) {
        // Show loading while checking auth status
        if (authService.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Show login if not authenticated
        if (!authService.isAuthenticated) {
          return const LoginScreen();
        }

        // Show main app if authenticated
        return const QuotesListScreen();
      },
    );
  }
}

