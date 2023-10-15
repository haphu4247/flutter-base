import 'package:base_flutter/flavour/flavour.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

part './impl/firebase_options_dev.dart';
part './impl/firebase_options_prod.dart';
part './impl/firebase_options_staging.dart';

abstract class BaseFirebaseOptions {
  factory BaseFirebaseOptions(Flavour flavour) {
    switch (flavour) {
      case Flavour.prod:
        return _DefaultFirebaseOptionsProd();
      case Flavour.staging:
        return _DefaultFirebaseOptionsStaging();
      case Flavour.dev:
        return _DefaultFirebaseOptionsDev();
    }
  }
  
  FirebaseOptions get currentPlatform;
}
