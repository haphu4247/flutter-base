import 'package:base_flutter/base/tracking_logger/app_tracking.dart';
import 'package:base_flutter/flavour/config/config_dev.dart';
import 'package:base_flutter/flavour/firebase/env/firebase_options_base.dart';
import 'package:base_flutter/flavour/firebase/fcm_handler/fcm_provider.dart';
import 'package:base_flutter/flavour/flavour.dart';

import 'config_prod.dart';
import 'config_staging.dart';

abstract class ConfigBase {
  factory ConfigBase(Flavour environment) {
    switch (environment) {
      case Flavour.prod:
        return ProdConfig(environment);
      case Flavour.dev:
        return DevConfig(environment);
      case Flavour.staging:
        return StagingConfig(environment);
    }
  }
  Future<dynamic> initConfig();

  String get apiHost;

  Flavour get env;

  AppTracking get tracking;

  IFcmProvider get fcmProvider;

  BaseFirebaseOptions get options;
}
