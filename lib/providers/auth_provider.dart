import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:group_profile_app/constants/app_constants.dart';
import 'package:group_profile_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages Firebase authentication state, loading indicators, error messages,
/// session persistence, and remembered email convenience.
class AuthProvider extends ChangeNotifier {
  AuthProvider({required this._authService}) {
    _user = _authService.currentUser;
    _authSubscription = _authService.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
    _loadRememberedEmail();
  }

  final AuthService _authService;
  StreamSubscription<AuthUser?>? _authSubscription;

  AuthUser? _user;
  bool _isLoading = false;
  String? _errorMessage;
  String _rememberedEmail = '';
  bool _rememberEmail = true;

  AuthUser? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isFirebaseConfigured => _authService.isConfigured;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get rememberedEmail => _rememberedEmail;
  bool get rememberEmail => _rememberEmail;

  Future<void> _loadRememberedEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(AppConstants.prefLastEmail);
      if (saved != null && saved.isNotEmpty) {
        _rememberedEmail = saved;
        notifyListeners();
      }
    } catch (_) {
      // Ignore storage errors on unsupported test environments.
    }
  }

  void setRememberEmail(bool value) {
    _rememberEmail = value;
    notifyListeners();
  }

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final signedInUser = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = signedInUser;
      await _persistEmailIfEnabled(email.trim());
      return true;
    } on AuthFailure catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (_) {
      _errorMessage = 'Unable to sign in right now. Please try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final createdUser = await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = createdUser;
      await _persistEmailIfEnabled(email.trim());
      return true;
    } on AuthFailure catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (_) {
      _errorMessage = 'Unable to create account right now. Please try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signOut();
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _persistEmailIfEnabled(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_rememberEmail) {
        _rememberedEmail = email;
        await prefs.setString(AppConstants.prefLastEmail, email);
      } else {
        _rememberedEmail = '';
        await prefs.remove(AppConstants.prefLastEmail);
      }
    } catch (_) {
      // Ignore storage errors on unsupported test environments.
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
