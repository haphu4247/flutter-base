import 'base_config.dart';
import 'flavour.dart';

class ProdConfig implements BaseConfig {
  ProdConfig(this.env);
  @override
  String get apiHost => 'https://phuhp.com';

  @override
  bool get showBanner => false;

  @override
  Flavour env;
}
