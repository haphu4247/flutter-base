import 'package:base_flutter/app/app_config.dart';
import 'package:base_flutter/base/api_client/base_api_service.dart';
import 'package:base_flutter/flavour/flavour.dart';
import 'package:get_it/get_it.dart';

abstract class DIConfig {
  factory DIConfig() {
    return _instance;
  }
  DIConfig._internal();

  Future<dynamic> initConfig(Flavour flavour);

  GetIt get getIt;
}

final _DIConfigImpl _instance = _DIConfigImpl(GetIt.instance);

class _DIConfigImpl extends DIConfig {
  _DIConfigImpl(this._getIt) : super._internal();

  final GetIt _getIt;

  @override
  GetIt get getIt => _getIt;

  @override
  Future<dynamic> initConfig(Flavour flavour) {
    _getIt.registerLazySingleton<BaseApiService>(BaseApiService.new);
    final config = IAppConfig();
    _getIt.registerLazySingleton<IAppConfig>(
      () => config,
    );

    return config.initConfig(flavour);
  }
}
