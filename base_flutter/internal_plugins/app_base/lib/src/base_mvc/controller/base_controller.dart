import 'package:flutter/material.dart';

abstract class BaseController {
  BaseController();

  BuildContext? _context;
  BuildContext? get context => _context;
  void initContext(BuildContext context) {
    _context = context;
  }

  //for state full widget
  void initState() {}
  void dispose() {}

  void onBack() {
    // context?.appNavigation.back();
  }

  void nextRoute(String route) {
    // context.appNavigation.nextRoute(route);
  }

  void replaceNamed(String route) {
    // context?.appNavigation.replaceNamed(route);
  }
}
