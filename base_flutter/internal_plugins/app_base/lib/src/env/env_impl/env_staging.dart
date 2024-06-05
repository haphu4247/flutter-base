import 'package:app_base/src/env/env.dart';

import 'dart:async';

import '../base_env_model.dart';

class EnvStaging extends BaseEnvModel {
  const EnvStaging() : super(env: Env.staging);

  @override
// TODO: implement apiHost
  String get apiHost => throw UnimplementedError();

  @override
  FutureOr initConfig() {
    // TODO: implement initConfig
    throw UnimplementedError();
  }
}
