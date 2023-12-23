import 'package:flutter/material.dart';

import '../../../routes/app_navigation_manager.dart';
import '../../colors/app_colors.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key, this.btnClose = false}) : super(key: key);
  factory MyBackButton.btnClose() {
    return const MyBackButton(
      btnClose: true,
    );
  }
  final bool btnClose;
  @override
  Widget build(BuildContext context) {
    if (btnClose) {
      return CloseButton(
        color: AppColors.white,
        onPressed: () => context.appNavigation.back(),
      );
    }
    return BackButton(
      color: AppColors.white,
      onPressed: () => context.appNavigation.back(),
    );
  }
}
