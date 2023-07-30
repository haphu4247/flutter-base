import 'package:flutter/cupertino.dart';

class AppNavigation {
  AppNavigation._();
  // static const String _tag = 'AppNavigation';

  static void back({required BuildContext context, dynamic result}) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(result);
    }
  }
}
