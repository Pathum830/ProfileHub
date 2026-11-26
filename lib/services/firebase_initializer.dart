import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:group_profile_app/firebase_options.dart';

/// Handles safe Firebase initialization across configured and unconfigured
/// local clones so contributors never hit an unhandled startup crash.
class FirebaseInitializer {
  FirebaseInitializer._();

  static bool _isReady = false;
  static String? _lastError;

  static bool get isReady => _isReady;
  static String? get lastError => _lastError;

  static bool _hasValidOptions(FirebaseOptions options) {
    return !options.apiKey.startsWith('YOUR_') &&
        !options.projectId.startsWith('YOUR_') &&
        options.apiKey.isNotEmpty &&
        options.appId.isNotEmpty;
  }

  /// Initializes Firebase if valid FlutterFire options or native config files
  /// (e.g., `google-services.json` on Android) are present.
  static Future<bool> initialize() async {
    if (Firebase.apps.isNotEmpty) {
      _isReady = true;
      _lastError = null;
      return true;
    }

    try {
      final options = DefaultFirebaseOptions.currentPlatform;
      if (_hasValidOptions(options)) {
        await Firebase.initializeApp(options: options);
        _isReady = true;
        _lastError = null;
        return true;
      }

      // On Android/iOS, native google-services.json / GoogleService-Info.plist
      // may exist even if firebase_options.dart still has placeholders.
      if (!kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS)) {
        await Firebase.initializeApp();
        _isReady = Firebase.apps.isNotEmpty;
        _lastError = null;
        return _isReady;
      }

      _isReady = false;
      _lastError =
          'Firebase configuration not found. Run `flutterfire configure` or add google-services.json.';
      return false;
    } catch (e) {
      _isReady = false;
      _lastError =
          'Firebase is not yet configured for this environment. See README.md for setup steps.';
      return false;
    }
  }
}
