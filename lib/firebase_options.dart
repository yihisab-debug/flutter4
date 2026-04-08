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
    apiKey: 'AIzaSyBvurptTBjVd2xe1WZIbpKIbSOo4g-tUvE',
    appId: '1:865152300647:web:5dc25d9e806198607906c2',
    messagingSenderId: '865152300647',
    projectId: 'flutter4-4b1b8',
    authDomain: 'flutter4-4b1b8.firebaseapp.com',
    storageBucket: 'flutter4-4b1b8.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXGI68AOQj5eGQm_wyetOAD_bve6WElpw',
    appId: '1:865152300647:android:6193aa95e55348217906c2',
    messagingSenderId: '865152300647',
    projectId: 'flutter4-4b1b8',
    storageBucket: 'flutter4-4b1b8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZdxYF7tsutQIHlZg3l_8tfcUeEAw-MRc',
    appId: '1:865152300647:ios:c7c0917d6180e1d07906c2',
    messagingSenderId: '865152300647',
    projectId: 'flutter4-4b1b8',
    storageBucket: 'flutter4-4b1b8.firebasestorage.app',
    androidClientId:
        '865152300647-h6sq96kuik3ln8qdb9v8e4llrbiiemn3.apps.googleusercontent.com',
    iosClientId:
        '865152300647-jjee6u2dhn13t9rcd4m59fougtja8hha.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutter4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZdxYF7tsutQIHlZg3l_8tfcUeEAw-MRc',
    appId: '1:865152300647:ios:c7c0917d6180e1d07906c2',
    messagingSenderId: '865152300647',
    projectId: 'flutter4-4b1b8',
    storageBucket: 'flutter4-4b1b8.firebasestorage.app',
    androidClientId:
        '865152300647-h6sq96kuik3ln8qdb9v8e4llrbiiemn3.apps.googleusercontent.com',
    iosClientId:
        '865152300647-jjee6u2dhn13t9rcd4m59fougtja8hha.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutter4',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBvurptTBjVd2xe1WZIbpKIbSOo4g-tUvE',
    appId: '1:865152300647:web:cff5a3a6270fd0a27906c2',
    messagingSenderId: '865152300647',
    projectId: 'flutter4-4b1b8',
    authDomain: 'flutter4-4b1b8.firebaseapp.com',
    storageBucket: 'flutter4-4b1b8.firebasestorage.app',
  );
}
