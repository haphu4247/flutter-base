import 'package:flutter/material.dart';
import 'buttons/my_back_button.dart';

class MyAppBar extends AppBar {
  MyAppBar({
    super.key,
    super.title,
    final Widget? leading,
    super.actions,
    final bool btnClose = false,
  }) : super(
          leading: leading ??
              MyBackButton(
                btnClose: btnClose,
              ),
          centerTitle: true,
        );

  factory MyAppBar.title({
    required String title,
    Widget? leading,
    bool btnClose = false,
  }) {
    return MyAppBar(
      title: Text(
        title,
        // style: const TextStyle(color: AppColors.white),
      ),
      btnClose: btnClose,
      leading: leading,
    );
  }
}
