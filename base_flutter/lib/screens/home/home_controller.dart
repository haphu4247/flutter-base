import 'package:base_flutter/app/app_config.dart';
import 'package:base_flutter/base/base_screen/controller/base_controller.dart';
import 'package:base_flutter/shared/languages/context_extension.dart';

class HomeController extends BaseController {
  String get title {
    final env =
        context?.localize.appVariant(getIt.get<IAppConfig>().config.flavour.name);
    return 'Home $env';
  }

  void gotoTest(String route) {
    nextRoute(route);
  }
}
