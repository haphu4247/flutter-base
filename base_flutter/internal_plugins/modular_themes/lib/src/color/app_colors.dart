import 'package:flutter/material.dart';

import 'app_colors_dark.dart';
import 'app_colors_light.dart';

abstract class AppColors {
  const AppColors();
  factory AppColors.init(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return const AppColorsDark();
      default:
        return const AppColorsLight();
    }
  }
  final white = Colors.white;
  final black = Colors.black;
  Color get primary95;
  Color get primary90;
  Color get primary85;
  Color get primary80;
  Color get primary75;
  Color get primary70;
  Color get primary65;
  Color get primary60;
  Color get primary55;
  Color get primary50;
  Color get primary45;
  Color get primary40;
  Color get primary35;
  Color get primary30;
  Color get primary25;
  Color get primary20;
  Color get primary15;
  Color get primary10;
  Color get primary5;
  Color get primary;

  final link = Colors.blueAccent;
  final lightBlue = Colors.lightBlueAccent;
  final transparent = Colors.transparent;
  final red = Colors.red;

  final oke = Colors.orange;
  final failed = Colors.transparent;
  final warning = Colors.red;

  final grey = Colors.grey;
  final lightGrey = const Color.fromRGBO(200, 200, 200, 0.8);
  final lightGrey1 = const Color.fromRGBO(200, 200, 200, 0.6);
  final lightGrey2 = const Color.fromARGB(255, 240, 236, 236);
  final unknown = Colors.blueGrey;
}
