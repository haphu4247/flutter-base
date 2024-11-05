import 'package:flutter/material.dart';
import 'package:modular_themes/src/color/app_colors.dart';

class AppTextStyles {
  const AppTextStyles(this.appColors);
  final AppColors appColors;

  TextStyle get error => TextStyle(
    fontSize: 12,
    height: 1.17,
    fontWeight: FontWeight.w400,
    color: appColors.primary,
  );

  TextStyle get hintText => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: appColors.grey,
  );
}
