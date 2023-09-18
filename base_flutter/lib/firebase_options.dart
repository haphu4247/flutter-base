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
    apiKey: 'AIzaSyBgpBRb5asCCZohbU3KpF4Gk9-xjxDb1RA',
    appId: '1:974751150135:web:6e1dc6a2607f1844264fb2',
    messagingSenderId: '974751150135',
    projectId: 'base-flutter-81a44',
    authDomain: 'base-flutter-81a44.firebaseapp.com',
    storageBucket: 'base-flutter-81a44.appspot.com',
    measurementId: 'G-JWF12B0P21',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJ3gcQEmuDJSI9v3e5Wy-kneEWG2UPUO8',
    appId: '1:974751150135:android:36dd24283bd64b4b264fb2',
    messagingSenderId: '974751150135',
    projectId: 'base-flutter-81a44',
    storageBucket: 'base-flutter-81a44.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIvVIMsZlQh8PsKJ0cn0Cm4l28m5Xl8jU',
    appId: '1:974751150135:ios:197a94894fce8b15264fb2',
    messagingSenderId: '974751150135',
    projectId: 'base-flutter-81a44',
    storageBucket: 'base-flutter-81a44.appspot.com',
    iosBundleId: 'com.phuhp.base.flutter.dev',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIvVIMsZlQh8PsKJ0cn0Cm4l28m5Xl8jU',
    appId: '1:974751150135:ios:666c0f81ccfbd5f2264fb2',
    messagingSenderId: '974751150135',
    projectId: 'base-flutter-81a44',
    storageBucket: 'base-flutter-81a44.appspot.com',
    iosBundleId: 'com.phuhp.base.flutter.baseFlutter.RunnerTests',
  );
}
