import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/// Lightweight representation of an authenticated user, decoupled from
/// Firebase SDK types for clean architecture and easy testing.
class AuthUser {
  const AuthUser({
    required this.uid,
    required this.email,
    this.displayName,
  });

  final String uid;
  final String email;
  final String? displayName;
}

/// Domain-level authentication exception with user-friendly messages.
class AuthFailure implements Exception {
  const AuthFailure(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => message;
}

/// Abstract authentication contract so the app can use Firebase Auth in
/// production and deterministic fakes in automated widget/unit tests.
abstract class AuthService {
  bool get isConfigured;
  AuthUser? get currentUser;
  Stream<AuthUser?> get authStateChanges;

  Future<AuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AuthUser> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

/// Production Firebase Authentication implementation.
class FirebaseAuthService implements AuthService {
  FirebaseAuth? get _firebaseAuth {
    if (Firebase.apps.isEmpty) return null;
    return FirebaseAuth.instance;
  }

  @override
  bool get isConfigured => Firebase.apps.isNotEmpty;

  @override
  AuthUser? get currentUser => _mapUser(_firebaseAuth?.currentUser);

  @override
  Stream<AuthUser?> get authStateChanges {
    final auth = _firebaseAuth;
    if (auth == null) {
      return Stream<AuthUser?>.value(null);
    }
    return auth.authStateChanges().map(_mapUser);
  }

  @override
  Future<AuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final auth = _firebaseAuth;
    if (auth == null) {
      throw const AuthFailure(
        'Firebase is not configured yet. Connect your Firebase project via `flutterfire configure` (see README.md).',
        code: 'firebase-not-configured',
      );
    }

    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = _mapUser(credential.user);
      if (user == null) {
        throw const AuthFailure('Unable to retrieve signed-in user details.');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_mapFirebaseError(e), code: e.code);
    } catch (_) {
      throw const AuthFailure(
        'An unexpected error occurred while signing in. Please try again.',
      );
    }
  }

  @override
  Future<AuthUser> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final auth = _firebaseAuth;
    if (auth == null) {
      throw const AuthFailure(
        'Firebase is not configured yet. Connect your Firebase project via `flutterfire configure` (see README.md).',
        code: 'firebase-not-configured',
      );
    }

    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = _mapUser(credential.user);
      if (user == null) {
        throw const AuthFailure('Unable to create user account.');
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(_mapFirebaseError(e), code: e.code);
    } catch (_) {
      throw const AuthFailure(
        'An unexpected error occurred during registration. Please try again.',
      );
    }
  }

  @override
  Future<void> signOut() async {
    final auth = _firebaseAuth;
    if (auth == null) return;
    await auth.signOut();
  }

  AuthUser? _mapUser(User? user) {
    if (user == null) return null;
    return AuthUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address format is invalid.';
      case 'user-disabled':
        return 'This account has been disabled. Contact your group admin.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password. Please check your credentials and try again.';
      case 'email-already-in-use':
        return 'An account already exists for this email address.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'too-many-requests':
        return 'Too many failed login attempts. Please wait a moment and try again.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'operation-not-allowed':
        return 'Email/Password sign-in is not enabled in Firebase Console.';
      default:
        return e.message ?? 'Authentication failed (${e.code}).';
    }
  }
}
