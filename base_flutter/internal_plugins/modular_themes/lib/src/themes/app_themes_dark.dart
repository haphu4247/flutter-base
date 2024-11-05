// //https://api.flutter.dev/flutter/material/TextTheme-class.html
// import 'package:flutter/material.dart';
// import 'package:modular_themes/modular_themes.dart';
// import 'package:modular_themes/src/themes/app_themes.dart';

// class AppThemesDark extends AppThemes {
//   const AppThemesDark({
//     required super.fontName,
//     required super.appColors,
//   });

//   @override
//   ThemeData get darkTheme => ThemeData(
//         brightness: Brightness.dark,
//         fontFamily: fontName,
//         primaryColor: appColors.primary,
//         // primaryColorDark: appColors.primaryColorLight,
//         // primaryColorLight: appColors.primaryColorDark,
//         primaryIconTheme: IconThemeData(color: appColors.white),
//         scaffoldBackgroundColor: appColors.black,
//         hoverColor: appColors.transparent,
//         splashColor: appColors.transparent,
//         highlightColor: appColors.transparent,
//         indicatorColor: appColors.primary,
//         appBarTheme: AppBarTheme(
//           elevation: 0,
//           color: appColors.primary,
//         ),
//         bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           type: BottomNavigationBarType.fixed,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           selectedItemColor: appColors.primary,
//           unselectedItemColor: appColors.lightGrey,
//           selectedLabelStyle: TextStyle(
//             color: appColors.transparent,
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//           ),
//           unselectedLabelStyle: TextStyle(
//             color: appColors.transparent,
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         textTheme: myTextTheme(appColors.white),
//         primaryTextTheme: myTextTheme(appColors.primary),
//         textSelectionTheme: TextSelectionThemeData(
//           cursorColor: appColors.black,
//         ),
//         // colorScheme: ColorScheme(
//         //   background: AppColors.black,
//         // ),
//       );
// }
