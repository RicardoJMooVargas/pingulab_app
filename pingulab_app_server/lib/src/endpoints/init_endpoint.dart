import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'auth_endpoint.dart';

/// Endpoint para inicialización de la base de datos
/// Crea datos por defecto si no existen
class InitEndpoint extends Endpoint {
  /// Inicializa la base de datos con datos por defecto
  /// Retorna true si se inicializó, false si ya estaba inicializada
  Future<bool> initializeDatabase(Session session) async {
    try {
      // Verificar si ya existe el usuario admin
      final existingAdmin = await User.db.findFirstRow(
        session,
        where: (t) => t.email.equals('admin@pingulab.com'),
      );

      // Si existe, la DB ya está inicializada
      if (existingAdmin != null) {
        session.log('Base de datos ya inicializada', level: LogLevel.info);
        return false;
      }

      session.log('Inicializando base de datos...', level: LogLevel.info);
      
      // Insertar usuarios directamente con SQL
      // Los roles son: 0=ADMIN, 1=OPERADOR, 2=VIEWER
      await session.db.unsafeQuery(
        '''
        INSERT INTO users (email, "passwordHash", nombre, apellido, rol, activo, created)
        VALUES 
          ('admin@pingulab.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Administrator', NULL, 0, TRUE, NOW()),
          ('operador@pingulab.com', '6ca8a22e2505b0f287869f82fb146d30b98e37c1bdb30ad8d9e97dea2de55936', 'Operador', 'Principal', 1, TRUE, NOW()),
          ('viewer@pingulab.com', '2c2da6f8f7ef82fd0c32b57a6f09c5d8cc0a6908b0cfe5b5d97dfa96c09f27e4', 'Visualizador', 'Test', 2, TRUE, NOW())
        ON CONFLICT (email) DO NOTHING;
        ''',
      );

      session.log(
        'Base de datos inicializada con éxito. Usuarios creados: admin, operador, viewer',
        level: LogLevel.info,
      );

      return true;
    } catch (e, stackTrace) {
      session.log(
        'Error al inicializar base de datos: $e',
        level: LogLevel.error,
        exception: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  /// Verifica si la base de datos está inicializada
  Future<bool> isDatabaseInitialized(Session session) async {
    try {
      final existingAdmin = await User.db.findFirstRow(
        session,
        where: (t) => t.email.equals('admin@pingulab.com'),
      );

      return existingAdmin != null;
    } catch (e) {
      session.log(
        'Error al verificar inicialización de base de datos: $e',
        level: LogLevel.error,
      );
      return false;
    }
  }
}
