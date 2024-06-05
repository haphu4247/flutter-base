import 'package:app_base/app_base.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

part 'impl/firebase_options_dev.dart';
part 'impl/firebase_options_prod.dart';
part 'impl/firebase_options_staging.dart';

abstract class BaseFirebaseOptions {
  factory BaseFirebaseOptions(Env flavour) {
    switch (flavour) {
      case Env.prod:
        return _DefaultFirebaseOptionsProd();
      case Env.staging:
        return _DefaultFirebaseOptionsStaging();
      case Env.dev:
        return _DefaultFirebaseOptionsDev();
    }
  }

  FirebaseOptions get currentPlatform;
}
