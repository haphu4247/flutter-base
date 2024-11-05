import 'package:app_base/app_base.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';

class HomeController extends BaseController {
  String get title {
    final env = context?.lang.appVariant(context?.env.env.name ?? 'dev');
    return 'Home $env';
  }

  void gotoTest(String route) {
    context?.navigation.nextRoute(route);
  }

  String get text {
    return 'acb';
  }
}
