import 'package:base_flutter/base/flavour/config/base_config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../data/local_repositories/local_repository.dart';
import '../styles/themes/app_themes.dart';
import 'flavour.dart';

final Environment _singleton = Environment._internal();

class Environment {
  static Environment get instance => _singleton;

  Environment._internal();

  late final BaseConfig config;

  late Locale selectedLocales;

  late ThemeMode themeMode = ThemeMode.system;

  bool isWeb = kIsWeb;
  Future<void> initConfig(Flavour environment) async {
    LocalRepository().initData();

    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    config = BaseConfig(environment);

    selectedLocales = await _loadLocales();

    final AppThemes appTheme = AppThemes.instance;
    themeMode = await appTheme.loadTheme();
  }

  String get initial {
    // if (_firstTimeOpenApp == null || _firstTimeOpenApp == false) {
    // return Routes.SPLASH;
    // }
    // return Routes.SPLASH;
    return '/';
  }

  Future<Locale> _loadLocales() async {
    // final String? myLocale = await LocalRepository().appLocale();
    // return AppLanguages.getLocaleFromLanguage(langCode: myLocale);
    return const Locale('en');
  }
}
