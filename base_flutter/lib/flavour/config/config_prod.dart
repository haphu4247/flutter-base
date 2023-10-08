import 'package:base_flutter/flavour/flavour.dart';

import 'config_base.dart';

class ProdConfig implements ConfigBase {
  ProdConfig(this.env);
  @override
  String get apiHost => 'https://data.binance.com/';

  @override
  Flavour env;
}
