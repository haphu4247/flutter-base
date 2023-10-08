import 'package:firebase_core/firebase_core.dart';

abstract class BaseFirebaseOptions {
  FirebaseOptions get currentPlatform;
}
