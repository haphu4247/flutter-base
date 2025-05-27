import 'package:app_base/app_base.dart';
import 'package:base_flutter/data/api_repositories/authentication/models/login_response.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

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
  }

  Future<String?> appLocale() {
    return storage.read(LocalDataKey.sAppLocale);
  }

  Future<bool> saveFcmToken(String fcmToken) {
    return storage.write(LocalDataKey.fcmToken, fcmToken);
  }

  Future<bool> setAppLocale(String langCode) {
    return storage.write(LocalDataKey.sAppLocale, langCode);
  }

  Future<String?> appCurrency() {
    return storage.read(LocalDataKey.sAppCurrency);
  }

  Future<bool> setAppCurrency(String langCode) {
    return storage.write(LocalDataKey.sAppCurrency, langCode);
  }

  Future<ThemeMode> themes() async {
    final result = await storage.read(LocalDataKey.sThemes);
    if (result != null) {
      return ThemeMode.values.byName(result);
    } else {
      return ThemeMode.light;
    }
  }

  Future<bool> saveTheme(ThemeMode theme) {
    return storage.write(LocalDataKey.sThemes, theme.name);
  }

  Future<bool> saveNotificationPermission() {
    final now =
        DateTimeUtils.formatDate(DateTime.now(), type: AppDateFormat.yyyyMMdd);
    return storage.write(LocalDataKey.requestNotificationPermission, now);
  }

  Future<String?> getNotificationPermission() {
    return storage.read(LocalDataKey.requestNotificationPermission);
  }

  Future<bool> saveLoginInfo(LoginResponse login) {
    return storage.writeObj(LocalDataKey.loginInfo, login);
  }

  Future<LoginResponse?> getLoginInfo() {
    return storage.readObj(
      LocalDataKey.loginInfo,
      LoginResponse.fromJson,
    );
  }
}
