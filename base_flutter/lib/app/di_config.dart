import 'package:app_base/app_base.dart';
import 'package:base_flutter/data/api_repositories/authentication/authentication_repository.dart';
import 'package:base_flutter/data/api_repositories/public/public_repository.dart';
import 'package:base_flutter/data/local_repositories/local_repository.dart';
import 'package:base_flutter/languages/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:modular_themes/modular_themes.dart';

final DIConfig _instance = _DIConfigImpl();
final getIt = GetIt.asNewInstance();

abstract class DIConfig {
  static DIConfig get instance => _instance;
  DIConfig._internal();

  Future<dynamic> initConfig(Env env);
}

class _DIConfigImpl extends DIConfig {
  _DIConfigImpl() : super._internal();

  @override
  Future<dynamic> initConfig(Env env) async {
    AppLogger.init(env: env);
    final envModel = BaseEnvModel.instance(env: env);

    final baseApi = BaseApiService(apiHost: envModel.apiHost);
    getIt.registerSingleton<LocaleProvider>(LocaleProvider());
    getIt.registerFactory<BaseEnvModel>(() => envModel);
    getIt.registerSingleton<PublicRepository>(PublicRepository(baseApi));
    getIt.registerFactory<AppThemes>(() =>
        AppThemes.init(themeMode: ThemeMode.light, font: AppFonts.roboto));
    getIt.registerSingleton<AuthenticationRepository>(
        AuthenticationRepository(baseApi));
    getIt.registerFactory<LocalRepository>(
      () => LocalRepository(BaseStorage.instance()),
    );
  }
}
