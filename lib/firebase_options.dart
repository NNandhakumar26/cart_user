// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCPUykVYAhpoXAH7cUjvw1BTJ2JKP-pi1A',
    appId: '1:726622323469:web:dac41c9873da6e96516644',
    messagingSenderId: '726622323469',
    projectId: 'mercurytoysuser',
    authDomain: 'mercurytoysuser.firebaseapp.com',
    storageBucket: 'mercurytoysuser.appspot.com',
    measurementId: 'G-ED34J01NPS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcZBQ00PcxhQPD_WpITeStWkDKeQXia2E',
    appId: '1:726622323469:android:8f67e9c8931f452f516644',
    messagingSenderId: '726622323469',
    projectId: 'mercurytoysuser',
    storageBucket: 'mercurytoysuser.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMl9lw7HU3FoBRxMTqCpvLDmRdSZT6p0o',
    appId: '1:726622323469:ios:fa7a0d23c84dcb1a516644',
    messagingSenderId: '726622323469',
    projectId: 'mercurytoysuser',
    storageBucket: 'mercurytoysuser.appspot.com',
    androidClientId: '726622323469-9enk7aeq9e970igkn7c1pjh5mi3p309d.apps.googleusercontent.com',
    iosBundleId: 'com.mercurytoysshop.toyskart',
  );
}