part of '../config_base.dart';


class _ProdConfig implements ConfigBase {
  _ProdConfig(this.flavour);
  @override
  String get apiHost => 'https://data.binance.com/';

  @override
  Flavour flavour;

  @override
  AppTracking get tracking => AppTracking(
      enableWriteToDownload: false, enableCrashlytics: enableCrashlytics);

  @override
  Future<dynamic> initConfig() {
    return Future.wait([
      fcmProvider.initFcm(options: options.currentPlatform, enableCrashlytics: enableCrashlytics),
      tracking.requestPermissionOnInit()
    ]);
  }

  @override
  IFcmProvider get fcmProvider => IFcmProvider();

  @override
  BaseFirebaseOptions get options => BaseFirebaseOptions(flavour);

  @override
  bool get enableCrashlytics => true;
}
