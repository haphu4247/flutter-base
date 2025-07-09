import 'package:base_flutter/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteNavigation {
  factory RouteNavigation.of(BuildContext context) =>
      RouteNavigation._(context: context);
  const RouteNavigation._({required this.context});
  final BuildContext context;

  void back({dynamic result}) {
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
  }

  void nextRoute(AppRouteManager route) {
    GoRouter.of(context).goNamed(route.name);
  }

  void replaceNamed(AppRouteManager route) {
    GoRouter.of(context).replaceNamed(route.name);
  }

  void pushRoute(AppRouteManager route) {
    GoRouter.of(context).pushNamed(route.name);
  }
}
