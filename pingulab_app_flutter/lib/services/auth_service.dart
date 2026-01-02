import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pingulab_app_client/pingulab_app_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = true;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  int? get userId => _currentUser?.id;
  String? get userName => _currentUser?.nombre;
  UserRole? get userRole => _currentUser?.rol;

  static const String _userKey = 'cached_user';

  AuthService() {
    _loadUserFromCache();
  }

  /// Load user from cache on app start
  Future<void> _loadUserFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);

      if (userJson != null) {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        _currentUser = User.fromJson(userMap);
        if (kDebugMode) {
          print('✅ User loaded from cache: ${_currentUser?.email}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('⚠️  Error loading user from cache: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final user = await client.auth.login(email, password);

      if (user != null) {
        _currentUser = user;
        await _saveUserToCache(user);
        
        if (kDebugMode) {
          print('✅ Login successful: ${user.email} (${user.rol})');
        }
        
        _isLoading = false;
        notifyListeners();
        return true;
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Login error: $e');
      }
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Save user to cache
  Future<void> _saveUserToCache(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(user.toJson());
      await prefs.setString(_userKey, userJson);
      
      if (kDebugMode) {
        print('💾 User saved to cache');
      }
    } catch (e) {
      if (kDebugMode) {
        print('⚠️  Error saving user to cache: $e');
      }
    }
  }

  /// Logout and clear cache
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      
      _currentUser = null;
      notifyListeners();
      
      if (kDebugMode) {
        print('👋 User logged out');
      }
    } catch (e) {
      if (kDebugMode) {
        print('⚠️  Error during logout: $e');
      }
    }
  }

  /// Change password
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    if (_currentUser == null) return false;

    try {
      final success = await client.auth.changePassword(
        _currentUser!.id!,
        oldPassword,
        newPassword,
      );

      if (kDebugMode) {
        print(success
            ? '✅ Password changed successfully'
            : '❌ Password change failed');
      }

      return success;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error changing password: $e');
      }
      return false;
    }
  }

  /// Check if user has specific role
  bool hasRole(UserRole role) {
    return _currentUser?.rol == role;
  }

  /// Check if user is admin
  bool get isAdmin => hasRole(UserRole.ADMIN);

  /// Check if user is operator
  bool get isOperator => hasRole(UserRole.OPERADOR);

  /// Check if user is viewer
  bool get isViewer => hasRole(UserRole.VIEWER);
}
