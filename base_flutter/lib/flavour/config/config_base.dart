import 'package:base_flutter/base/tracking_logger/app_tracking.dart';
import 'package:base_flutter/flavour/firebase/fcm_handler/fcm_managerdmanagerart';
import 'package:base_flutter/flavour/firebase/firebase_options/firebase_options_base.dart';
import 'package:base_flutter/flavour/flavour.dart';

part './config_impl/config_dev.dart';
part './config_impl/config_prod.dart';
part './config_impl/config_staging.dart';

abstract class ConfigBase {
  factory ConfigBase(Flavour environment) {
    switch (environment) {
      case Flavour.prod:
        return _ProdConfig(environment);
      case Flavour.dev:
        return _DevConfig(environment);
      case Flavour.staging:
        return _StagingConfig(environment);
    }
  }

  Future<dynamic> initConfig();

  String get apiHost;

  Flavour get flavour;

  AppTracking get tracking;

  IFcmProvider get fcmProvider;

  BaseFirebaseOptions get options;

  bool get enableCrashlytics;
}
