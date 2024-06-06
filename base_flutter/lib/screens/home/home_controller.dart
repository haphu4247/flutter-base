import 'package:app_base/app_base.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeController extends BaseController {
  String get title {
    final env = context?.localize.appVariant(context?.env.env.name ?? 'dev');
    return 'Home $env';
  }

  void gotoTest(String route) {
    nextRoute(route);
  }

  String get text {
    return 'acb';
  }
}
