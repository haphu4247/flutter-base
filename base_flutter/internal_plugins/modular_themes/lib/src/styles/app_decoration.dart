import 'package:flutter/material.dart';
import 'package:modular_themes/src/color/app_colors.dart';

class AppDecoration {
  const AppDecoration(this.appColors);
  final AppColors appColors;

  BoxDecoration get roundedShadow => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [defaultShadowBox],
      );

  BoxDecoration get roundedShadowCriteria => BoxDecoration(
      color: appColors.primary30,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [defaultShadowBox]);

  BoxShadow get defaultShadowBox => BoxShadow(
        color: appColors.black.withValues(alpha: 0.15),
        offset: const Offset(1, 1),
        blurRadius: 5,
      );

  BoxDecoration get topRoundedShadow => BoxDecoration(
        color: appColors.white,
        boxShadow: [defaultShadowBox],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      );
}
