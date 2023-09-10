import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/routes/app_navigation.dart';
import 'package:flutter/material.dart';

abstract class BaseController {
  BuildContext? context;

  final getIt = DIConfig().getIt;
  //for state full widget
  void initState() {}
  //for state full widget
  void dispose() {}

  void onBack() {
    if (context != null) {
      AppNavigation.back(context: context!);
    }
  }

  void nextRoute(String route) {
    if (context != null) {
      AppNavigation.nextRoute(context!, route);
    }
  }

  void replaceNamed(String route) {
    if (context != null) {
      AppNavigation.replaceNamed(context!, route);
    }
  }
}
