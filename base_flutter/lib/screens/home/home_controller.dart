import 'package:app_base/app_base.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/material.dart';

class HomeController extends BaseController {
  String title(BuildContext context) {
    final env = context.lang.appVariant(context.env.env.name);
    return 'Home $env';
  }

  void gotoTest(BuildContext context, String route) {
    context.navigation.nextRoute(route);
  }

  String get text {
    return 'acb';
  }
}
