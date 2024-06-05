import 'package:app_base/src/env/env.dart';

import 'dart:async';

import '../base_env_model.dart';

class EnvDev extends BaseEnvModel {
  const EnvDev() : super(env: Env.dev);

  @override
// TODO: implement apiHost
  String get apiHost => throw UnimplementedError();

  @override
  FutureOr initConfig() {
    // TODO: implement initConfig
    throw UnimplementedError();
  }
}
