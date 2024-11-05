import 'package:app_base/src/env/env.dart';

import 'dart:async';

import '../base_env_model.dart';

class EnvProd extends BaseEnvModel {
  const EnvProd() : super(env: Env.prod);

  @override
  String get apiHost => 'https://api.binance.com/';

  @override
  FutureOr initConfig() {
    return Future.value(null);
  }
}
