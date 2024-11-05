//https://api.flutter.dev/flutter/material/TextTheme-class.html
import 'package:flutter/material.dart';
import 'package:modular_themes/src/color/app_colors.dart';
import 'package:modular_themes/src/themes/app_themes.dart';

class AppThemesImpl extends AppThemes {
  const AppThemesImpl({
    required super.themeMode,
    required super.fontName,
    required super.appColors,
  });

  @override
  ThemeData get lightTheme {
    final appColors = AppColors.init(ThemeMode.light);
     return ThemeData(
        brightness: Brightness.light,
        fontFamily: fontName,
        primaryColor: appColors.primary,
        // primaryColorDark: appColors.primaryColorDark,
        // primaryColorLight: appColors.primaryColorLight,
        primaryIconTheme: IconThemeData(color: appColors.black),
        scaffoldBackgroundColor: appColors.white,
        hoverColor: appColors.transparent,
        splashColor: appColors.transparent,
        highlightColor: appColors.transparent,
        indicatorColor: appColors.primary,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: appColors.primary,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: appColors.primary,
          unselectedItemColor: appColors.lightGrey,
          selectedLabelStyle: TextStyle(
            color: appColors.transparent,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            color: appColors.transparent,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        textTheme: myTextTheme(appColors.black),
        primaryTextTheme: myTextTheme(appColors.primary),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: appColors.black,
        ),
        // colorScheme: ColorScheme(
        //   background: AppColors.lightGrey,
        //   brightness: Brightness.light,
        //   error: AppColors.warning,
        // ),
      );
  }

  @override
  ThemeData get darkTheme {
    final appColors = AppColors.init(ThemeMode.dark);
    return ThemeData(
        brightness: Brightness.dark,
        fontFamily: fontName,
        primaryColor: appColors.primary,
        // primaryColorDark: appColors.primaryColorLight,
        // primaryColorLight: appColors.primaryColorDark,
        primaryIconTheme: IconThemeData(color: appColors.white),
        scaffoldBackgroundColor: appColors.black,
        hoverColor: appColors.transparent,
        splashColor: appColors.transparent,
        highlightColor: appColors.transparent,
        indicatorColor: appColors.primary,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: appColors.primary,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: appColors.primary,
          unselectedItemColor: appColors.lightGrey,
          selectedLabelStyle: TextStyle(
            color: appColors.transparent,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            color: appColors.transparent,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        textTheme: myTextTheme(appColors.white),
        primaryTextTheme: myTextTheme(appColors.primary),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: appColors.black,
        ),
        // colorScheme: ColorScheme(
        //   background: AppColors.black,
        // ),
      );
  }
}
