import 'package:app_base/app_base.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/material.dart';

class PageNotFoundVM extends BaseViewModel {
  String get title => '404';

  void onBack(BuildContext context) {
    // Navigate back to the previous screen
    context.navigation.back();
  }
}
