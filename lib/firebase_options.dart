// Template Firebase configuration generated for Group 09 BioHub.
// Replace this file by running:
//   dart pub global activate flutterfire_cli
//   flutterfire configure
//
// Do NOT commit production secrets or private service account keys.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAtw7u6D_L3FKK2W_jYrZXNMk6EP-tAg3E',
    appId: '1:751111458973:web:36e5c14d2442f29ee74474',
    messagingSenderId: '751111458973',
    projectId: 'nexa-profile',
    authDomain: 'nexa-profile.firebaseapp.com',
    storageBucket: 'nexa-profile.firebasestorage.app',
    measurementId: 'G-W431N1RXL4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFR7TshBCnPNM9SFe5P-AKmLxsLOqa764',
    appId: '1:751111458973:android:95ddb6ea0a33ef1be74474',
    messagingSenderId: '751111458973',
    projectId: 'nexa-profile',
    storageBucket: 'nexa-profile.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDS9f3cNGsuEEiWuyK4xlK0ddp0xd05rfQ',
    appId: '1:751111458973:ios:a1f7ae18d0fe2084e74474',
    messagingSenderId: '751111458973',
    projectId: 'nexa-profile',
    storageBucket: 'nexa-profile.firebasestorage.app',
    iosBundleId: 'com.mobilecomm.ca02.groupProfileApp',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDS9f3cNGsuEEiWuyK4xlK0ddp0xd05rfQ',
    appId: '1:751111458973:ios:a1f7ae18d0fe2084e74474',
    messagingSenderId: '751111458973',
    projectId: 'nexa-profile',
    storageBucket: 'nexa-profile.firebasestorage.app',
    iosBundleId: 'com.mobilecomm.ca02.groupProfileApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAtw7u6D_L3FKK2W_jYrZXNMk6EP-tAg3E',
    appId: '1:751111458973:web:73efbc50e964dabde74474',
    messagingSenderId: '751111458973',
    projectId: 'nexa-profile',
    authDomain: 'nexa-profile.firebaseapp.com',
    storageBucket: 'nexa-profile.firebasestorage.app',
    measurementId: 'G-D7JS62FXF6',
  );
}
