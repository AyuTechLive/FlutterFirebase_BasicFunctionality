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
        return macos;
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
    apiKey: 'AIzaSyAkJ0jUmYs9uCwR66DgJBo31HNlWMoOXZI',
    appId: '1:308306754014:web:53ee5ebf4a405fef0fc54f',
    messagingSenderId: '308306754014',
    projectId: 'fir-d8752',
    authDomain: 'fir-d8752.firebaseapp.com',
    storageBucket: 'fir-d8752.appspot.com',
    measurementId: 'G-2J8G9TCP75',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDftHxGBpfF4ypflzMR2DuReZJRvy3kMG0',
    appId: '1:308306754014:android:a8f81c6f3f9899fa0fc54f',
    messagingSenderId: '308306754014',
    projectId: 'fir-d8752',
    storageBucket: 'fir-d8752.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbKgVPWYThunUg43enG3SeHpy46KZcYV8',
    appId: '1:308306754014:ios:472b0bef16e3fc4c0fc54f',
    messagingSenderId: '308306754014',
    projectId: 'fir-d8752',
    storageBucket: 'fir-d8752.appspot.com',
    iosBundleId: 'com.example.testappfirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbKgVPWYThunUg43enG3SeHpy46KZcYV8',
    appId: '1:308306754014:ios:a593dab14caa77ae0fc54f',
    messagingSenderId: '308306754014',
    projectId: 'fir-d8752',
    storageBucket: 'fir-d8752.appspot.com',
    iosBundleId: 'com.example.testappfirebase.RunnerTests',
  );
}