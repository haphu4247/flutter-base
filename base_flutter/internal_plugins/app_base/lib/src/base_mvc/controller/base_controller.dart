import 'package:flutter/material.dart';

abstract class BaseController {
  late BuildContext context;

  // final getIt = DIConfig().getIt;
  //for state full widget
  void initState() {}
  //for state full widget
  void dispose() {}

  void onBack() {
    // context?.appNavigation.back();
  }

  void nextRoute(String route) {
    // context?.appNavigation.nextRoute(route);
  }

  void replaceNamed(String route) {
    // context?.appNavigation.replaceNamed(route);
  }
}
