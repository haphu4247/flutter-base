import 'package:base_flutter/flavour/flavour.dart';

import 'base_config.dart';

class ProdConfig implements BaseConfig {
  ProdConfig(this.env);
  @override
  String get apiHost => 'https://data.binance.com/';

  @override
  bool get showBanner => false;

  @override
  Flavour env;
}
