import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key, this.btnClose = false});
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
        color: context.appColors.white,
        onPressed: () => context.navigation.back(),
      );
    }
    return BackButton(
      color: context.appColors.white,
      onPressed: () => context.navigation.back(),
    );
  }
}
