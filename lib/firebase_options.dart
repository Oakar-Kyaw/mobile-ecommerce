// lib/firebase_options.dart
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA-msfmFlTgI8LBqcaYLgPNuCvi9i_DfMA',
    appId: '1:566223411513:web:57fb61cd2ac62f994cb0e8',
    messagingSenderId: '566223411513',
    projectId: 'megasmartcart-771d3',
    authDomain: 'megasmartcart-771d3.firebaseapp.com',
    storageBucket: 'megasmartcart-771d3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASfbzwMvS8_12u5ViMpiAm2xga-wkE5tM',
    appId: '1:566223411513:android:5a5412fea0a1ecde4cb0e8',
    messagingSenderId: '566223411513',
    projectId: 'megasmartcart-771d3',
    storageBucket: 'megasmartcart-771d3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwr5pIjGQdnOuRJA4n6mEZjUAFQC-cHUg',
    appId: '1:566223411513:ios:89cb7a87733f87604cb0e8',
    messagingSenderId: '566223411513',
    projectId: 'megasmartcart-771d3',
    storageBucket: 'megasmartcart-771d3.appspot.com',
    iosBundleId: 'com.example.ecommerceMobile',
  );
}