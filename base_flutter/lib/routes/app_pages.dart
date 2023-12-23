import 'package:base_flutter/screens/home/home_screen.dart';
import 'package:base_flutter/screens/page_not_found/page_not_found_screen.dart';
import 'package:base_flutter/screens/splash/splash_screen.dart';
import 'package:base_flutter/screens/test/public_api/public_api_screen.dart';
import 'package:base_flutter/screens/test/test_lottie/test_lottie_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'app_route_manager.dart';

class AppPages {
  // GoRouter configuration
  static final router = GoRouter(
    initialLocation: '/${AppRouteManager.splash}',
    errorPageBuilder: (_, state) => MaterialPage(
      key: state.pageKey,
      name: '/not-found',
      child: PageNotFoundScreen(),
    ),
    routes: [
      GoRoute(
        name: AppRouteManager.splash,
        path: '/${AppRouteManager.splash}',
        builder: (context, state) => SplashScreen(),
        // routes: [
        //   GoRoute(
        //     name: Routes.home,
        //     path: Routes.home,
        //     builder: (context, state) => HomeScreen(),
        //   )
        // ],
      ),
      GoRoute(
        name: AppRouteManager.home,
        path: '/${AppRouteManager.home}',
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            name: AppRouteManager.testLottie,
            path: AppRouteManager.testLottie,
            builder: (context, state) => TestLottieScreen(),
          ),
          GoRoute(
            name: AppRouteManager.testFetchingApi,
            path: AppRouteManager.testFetchingApi,
            builder: (context, state) => PublicApiScreen(),
          )
        ],
      )
    ],
  );
}
