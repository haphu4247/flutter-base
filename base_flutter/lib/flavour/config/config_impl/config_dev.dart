part of '../config_base.dart';

class _DevConfig implements ConfigBase {
  _DevConfig(this.flavour);

  @override
  String get apiHost => 'https://data.binance.com/';

  @override
  Flavour flavour;

  @override
  AppTracking get tracking => AppTracking(
      enableWriteToDownload: true, enableCrashlytics: enableCrashlytics);

  @override
  Future<dynamic> initConfig() {
    return Future.wait([
      fcmManager.initFcm(
        options: options.currentPlatform,
        enableCrashlytics: enableCrashlytics,
      ),
      tracking.requestPermissionOnInit()
    ]);
  }

  @override
  IFcmManager get fcmManager => IFcmManager();

  @override
  BaseFirebaseOptions get options => BaseFirebaseOptions(flavour);

  @override
  bool get enableCrashlytics => false;
}
