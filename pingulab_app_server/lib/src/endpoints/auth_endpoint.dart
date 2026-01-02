import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AuthEndpoint extends Endpoint {
  /// Register a new user
  Future<User> register(
    Session session,
    String email,
    String password,
    String nombre,
    String? apellido,
    UserRole rol,
  ) async {
    // Check if email already exists
    final existingUser = await User.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    
    if (existingUser != null) {
      throw Exception('Email already registered');
    }
    
    // Hash password
    final passwordHash = _hashPassword(password);
    
    // Create user
    final user = User(
      email: email,
      passwordHash: passwordHash,
      nombre: nombre,
      apellido: apellido,
      rol: rol,
      activo: true,
      created: DateTime.now(),
    );
    
    // Insert user
    final createdUser = await User.db.insertRow(session, user);
    
    return createdUser;
  }

  /// Login user
  Future<User?> login(Session session, String email, String password) async {
    // Find user by email
    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    
    if (user == null) {
      return null;
    }
    
    // Check if user is active
    if (!user.activo) {
      throw Exception('User account is deactivated');
    }
    
    // Verify password
    final passwordHash = _hashPassword(password);
    if (user.passwordHash != passwordHash) {
      return null;
    }
    
    return user;
  }

  /// Change password
  Future<bool> changePassword(
    Session session,
    int userId,
    String oldPassword,
    String newPassword,
  ) async {
    // Find user
    final user = await User.db.findById(session, userId);
    
    if (user == null) {
      throw Exception('User not found');
    }
    
    // Verify old password
    final oldPasswordHash = _hashPassword(oldPassword);
    if (user.passwordHash != oldPasswordHash) {
      return false;
    }
    
    // Update password
    user.passwordHash = _hashPassword(newPassword);
    user.updated = DateTime.now();
    await User.db.updateRow(session, user);
    
    return true;
  }

  /// Get user by ID
  Future<User?> getUserById(Session session, int userId) async {
    return await User.db.findById(session, userId);
  }

  /// Get all users
  Future<List<User>> getAllUsers(Session session) async {
    final users = await User.db.find(
      session,
      orderBy: (t) => t.nombre,
    );
    
    return users;
  }

  /// Update user
  Future<User> updateUser(
    Session session,
    int userId,
    String nombre,
    String? apellido,
    UserRole rol,
    bool activo,
  ) async {
    final user = await User.db.findById(session, userId);
    
    if (user == null) {
      throw Exception('User not found');
    }
    
    user.nombre = nombre;
    user.apellido = apellido;
    user.rol = rol;
    user.activo = activo;
    user.updated = DateTime.now();
    
    final updatedUser = await User.db.updateRow(session, user);
    
    return updatedUser;
  }

  /// Deactivate user
  Future<User> deactivateUser(Session session, int userId) async {
    final user = await User.db.findById(session, userId);
    
    if (user == null) {
      throw Exception('User not found');
    }
    
    user.activo = false;
    user.updated = DateTime.now();
    
    final updatedUser = await User.db.updateRow(session, user);
    
    return updatedUser;
  }

  /// Activate user
  Future<User> activateUser(Session session, int userId) async {
    final user = await User.db.findById(session, userId);
    
    if (user == null) {
      throw Exception('User not found');
    }
    
    user.activo = true;
    user.updated = DateTime.now();
    
    final updatedUser = await User.db.updateRow(session, user);
    
    return updatedUser;
  }

  /// Reset password (admin only)
  Future<String> resetPassword(Session session, int userId) async {
    final user = await User.db.findById(session, userId);
    
    if (user == null) {
      throw Exception('User not found');
    }
    
    // Generate temporary password
    final tempPassword = _generateTemporaryPassword();
    
    // Update password
    user.passwordHash = _hashPassword(tempPassword);
    user.updated = DateTime.now();
    await User.db.updateRow(session, user);
    
    return tempPassword;
  }

  /// Helper method to hash password using SHA256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  /// Helper method to generate temporary password
  String _generateTemporaryPassword() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    return List.generate(10, (index) => chars[(random + index) % chars.length]).join();
  }
}
