import 'dart:io';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'screens/quotes_list_screen.dart';

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late final Client client;

late String serverUrl;

void main() {
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
    return MaterialApp(
      title: 'PinguLab - Cotizaciones 3D',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const QuotesListScreen(),
    );
  }
}

