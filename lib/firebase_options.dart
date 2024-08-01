// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCsjg9pfMVV954mFGWYETpr7T3OaPYcnUM',
    appId: '1:451457109865:web:58271adc7432c56692b7f8',
    messagingSenderId: '451457109865',
    projectId: 'waste-management-b5f21',
    authDomain: 'waste-management-b5f21.firebaseapp.com',
    storageBucket: 'waste-management-b5f21.appspot.com',
    measurementId: 'G-2H5WHCY9PD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkKHWPh6HYpyGr4EH0x9z7DxnCrQleWxU',
    appId: '1:451457109865:android:67933631cc0ec44492b7f8',
    messagingSenderId: '451457109865',
    projectId: 'waste-management-b5f21',
    storageBucket: 'waste-management-b5f21.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCP7BJbk4xaWgDfT2PdqHMnaLpiILnn42M',
    appId: '1:451457109865:ios:f57512c74963f21d92b7f8',
    messagingSenderId: '451457109865',
    projectId: 'waste-management-b5f21',
    storageBucket: 'waste-management-b5f21.appspot.com',
    iosBundleId: 'com.example.wasteManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCP7BJbk4xaWgDfT2PdqHMnaLpiILnn42M',
    appId: '1:451457109865:ios:f57512c74963f21d92b7f8',
    messagingSenderId: '451457109865',
    projectId: 'waste-management-b5f21',
    storageBucket: 'waste-management-b5f21.appspot.com',
    iosBundleId: 'com.example.wasteManagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCsjg9pfMVV954mFGWYETpr7T3OaPYcnUM',
    appId: '1:451457109865:web:9d0fe126ec17870292b7f8',
    messagingSenderId: '451457109865',
    projectId: 'waste-management-b5f21',
    authDomain: 'waste-management-b5f21.firebaseapp.com',
    storageBucket: 'waste-management-b5f21.appspot.com',
    measurementId: 'G-BHBVQC000X',
  );
}