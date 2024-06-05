import 'package:app_base/src/env/env.dart';

import 'dart:async';

import '../base_env_model.dart';

class EnvProd extends BaseEnvModel {
  const EnvProd() : super(env: Env.prod);

  @override
// TODO: implement apiHost
  String get apiHost => throw UnimplementedError();

  @override
  FutureOr initConfig() {
    // TODO: implement initConfig
    throw UnimplementedError();
  }
}
