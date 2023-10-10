import 'package:base_flutter/base/tracking_logger/app_tracking.dart';
import 'package:base_flutter/flavour/firebase/env/firebase_options_base.dart';
import 'package:base_flutter/flavour/firebase/env/firebase_options_dev.dart';
import 'package:base_flutter/flavour/firebase/fcm_handler/fcm_provider.dart';
import 'package:base_flutter/flavour/flavour.dart';

import 'config_base.dart';

class DevConfig implements ConfigBase {
  DevConfig(this.env);

  @override
  String get apiHost => 'https://data.binance.com/';

  @override
  Flavour env;

  @override
  AppTracking get tracking =>
      AppTracking(enableWriteToDownload: true, enableWriteToFirebaseLog: true);

  @override
  Future<dynamic> initConfig() {
    return Future.wait([
      fcmProvider.initFcm(options: options.currentPlatform),
      tracking.requestPermissionOnInit()
    ]);
  }

  @override
  IFcmProvider get fcmProvider => IFcmProvider();

  @override
  BaseFirebaseOptions get options => DefaultFirebaseOptionsDev.instance;
}
