import 'package:base_flutter/screens/authentication/login/widgets/login_screen.dart';
import 'package:base_flutter/screens/home/widgets/home_screen.dart';
import 'package:base_flutter/screens/page_not_found/widgets/page_not_found_screen.dart';
import 'package:base_flutter/screens/splash/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';

part 'all_routes_manager.dart';

class AppPages {
  // GoRouter configuration
  static final router = GoRouter(
    initialLocation: '/${AppRouteManager.splash}',
    observers: [
      FlutterSmartDialog.observer,
    ],
    errorPageBuilder: (_, state) => MaterialPage(
      key: state.pageKey,
      name: AppRouteManager.pageNotFound.name,
      child: PageNotFoundScreen(),
    ),
    routes: [
      GoRoute(
        name: AppRouteManager.splash.name,
        path: AppRouteManager.splash.path,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        name: AppRouteManager.home.name,
        path: AppRouteManager.home.path,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        name: AppRouteManager.login.name,
        path: AppRouteManager.login.path,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: AppRouteManager.pageNotFound.name,
        path: AppRouteManager.pageNotFound.path,
        builder: (context, state) => PageNotFoundScreen(),
      )
    ],
  );
}
