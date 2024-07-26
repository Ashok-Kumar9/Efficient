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
    apiKey: 'AIzaSyBz4gsCVlbK8xSwFSN_zdkOZPTdwhyv2yQ',
    appId: '1:125698354499:web:c38c261d6f6408ae4c53f6',
    messagingSenderId: '125698354499',
    projectId: 'efficient-school-fb114',
    authDomain: 'efficient-school-fb114.firebaseapp.com',
    storageBucket: 'efficient-school-fb114.appspot.com',
    measurementId: 'G-9X8BR7W4Y4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEI3BX8unDI8Yu027eiW0oEgLAYlc18BA',
    appId: '1:125698354499:android:dd2383c8f9bcb9b14c53f6',
    messagingSenderId: '125698354499',
    projectId: 'efficient-school-fb114',
    storageBucket: 'efficient-school-fb114.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBikoslu4fsXUSrWcuWeihLTtUn_-yQN0M',
    appId: '1:125698354499:ios:bc7357970ad664c34c53f6',
    messagingSenderId: '125698354499',
    projectId: 'efficient-school-fb114',
    storageBucket: 'efficient-school-fb114.appspot.com',
    iosBundleId: 'com.example.efficientSchool',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBikoslu4fsXUSrWcuWeihLTtUn_-yQN0M',
    appId: '1:125698354499:ios:bc7357970ad664c34c53f6',
    messagingSenderId: '125698354499',
    projectId: 'efficient-school-fb114',
    storageBucket: 'efficient-school-fb114.appspot.com',
    iosBundleId: 'com.example.efficientSchool',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBz4gsCVlbK8xSwFSN_zdkOZPTdwhyv2yQ',
    appId: '1:125698354499:web:8d3a4d9f06d935a04c53f6',
    messagingSenderId: '125698354499',
    projectId: 'efficient-school-fb114',
    authDomain: 'efficient-school-fb114.firebaseapp.com',
    storageBucket: 'efficient-school-fb114.appspot.com',
    measurementId: 'G-LTMC91T76C',
  );
}
