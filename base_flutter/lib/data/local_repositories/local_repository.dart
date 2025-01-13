import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:modular_storage/modular_storage.dart';

import '../../shared/utils/date_time_utils.dart';
import 'local_data_key/local_data_key_impl.dart';

class LocalRepository {
  factory LocalRepository(BaseStorage storage) {
    return LocalRepository._internal(storage);
  }
  final BaseStorage storage;

  LocalRepository._internal(this.storage);

  Future<void> initData() async {
    await _initHive();
  }

  Future<bool> clearData() {
    return storage.clear();
  }

  Future<void> _initHive() async {
    if (kIsWeb) {
      return;
    }
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    // Hive.init(appDocPath);
    // Hive.registerAdapter<AccountEntity>(AccountEntityAdapter());
    // Hive.registerAdapter<UserRole>(UserRoleAdapter());
  }

  Future<bool?> firstTimeOpenApp() async {
    return await storage.read(LocalDataKey.bFirstTimeOpenApp) == 'true';
    // return LocalDataKey.bFirstTimeOpenApp.instance.getBool();
  }

  Future<String?> appLocale() {
    return storage.read(LocalDataKey.sAppLocale);
    // return LocalDataKey.sAppLocale.instance.getString();
  }

  Future<bool> saveFcmToken(String fcmToken) {
    return storage.write(LocalDataKey.fcmToken, fcmToken);
    // return LocalDataKey.fcmToken.instance.setString(fcmToken);
  }

  Future<bool> setAppLocale(String langCode) {
    return storage.write(LocalDataKey.sAppLocale, langCode);
    // return LocalDataKey.sAppLocale.instance.setString(langCode);
  }

  Future<String?> appCurrency() {
    return storage.read(LocalDataKey.sAppCurrency);
    // return LocalDataKey.sAppCurrency.instance.getString();
  }

  Future<bool> setAppCurrency(String langCode) {
    return storage.write(LocalDataKey.sAppCurrency, langCode);
    // return LocalDataKey.sAppCurrency.instance.setString(langCode);
  }

  Future<ThemeMode> themes() async {
    final result = await storage.read(LocalDataKey.sThemes);
    // final result = await LocalDataKey.sThemes.instance.getString();
    if (result != null) {
      return ThemeMode.values.byName(result);
    } else {
      return ThemeMode.light;
    }
  }

  Future<bool> saveTheme(ThemeMode theme) {
    return storage.write(LocalDataKey.sThemes, theme.name);
    // return LocalDataKey.sThemes.instance.setString(theme.name);
  }

  Future<bool> saveNotificationPermission() {
    final now = DateTimeUtils.formatDateyyyyMMdd(DateTime.now());
    return storage.write(LocalDataKey.requestNotificationPermission, now);
    // return LocalDataKey.requestNotificationPermission.instance.setString(now);
  }

  Future<String?> getNotificationPermission() {
    return storage.read(LocalDataKey.requestNotificationPermission);
    // return LocalDataKey.requestNotificationPermission.instance.getString();
  }
}
