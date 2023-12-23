import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension AppNavigationExt on BuildContext {
  AppNavigationManager get appNavigation =>
      AppNavigationManager._(context: this);
}

class AppNavigationManager {
  AppNavigationManager._({required this.context});
  BuildContext context;

  void back({dynamic result}) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(result);
    }
  }

  void nextRoute(String route) {
    context.goNamed(route);
  }

  void replaceNamed(String route) {
    context.replaceNamed(route);
  }
}
