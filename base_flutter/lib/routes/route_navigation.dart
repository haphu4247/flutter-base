import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteNavigation {
  factory RouteNavigation.of(BuildContext context) =>
      RouteNavigation._(context: context);
  const RouteNavigation._({required this.context});
  final BuildContext context;

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
