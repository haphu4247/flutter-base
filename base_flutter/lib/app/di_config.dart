import 'package:app_base/app_base.dart';
import 'package:base_flutter/data/api_repositories/public/public_repository.dart';
import 'package:get_it/get_it.dart';

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
    final envModel = BaseEnvModel.instance(env: env);
    final baseApi = BaseApiService(apiHost: envModel.apiHost);
    getIt.registerFactory<BaseEnvModel>(() => envModel);
    getIt.registerSingleton(() => PublicRepository(baseApi));
  }
}
