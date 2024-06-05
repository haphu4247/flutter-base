import 'package:app_base/app_base.dart';
import 'package:get_it/get_it.dart';

final _DIConfigImpl _instance = _DIConfigImpl(GetIt.instance);

abstract class DIConfig {
  factory DIConfig() {
    return _instance;
  }
  DIConfig._internal();

  Future<dynamic> initConfig(Env env);

  GetIt get getIt;
}

class _DIConfigImpl extends DIConfig {
  _DIConfigImpl(this._getIt) : super._internal();

  final GetIt _getIt;

  @override
  GetIt get getIt => _getIt;

  @override
  Future<dynamic> initConfig(Env env) async {
    final envModel = BaseEnvModel.instance(env: env);
    _getIt.registerFactory<BaseEnvModel>(() => envModel);
    if (!_getIt.isRegistered<BaseApiService>()) {
      _getIt.registerLazySingleton<BaseApiService>(
          () => BaseApiService(apiHost: envModel.apiHost));
    }
  }

}
