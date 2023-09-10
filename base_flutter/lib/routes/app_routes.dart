part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const splash = _Paths.splash;
  static const introView = _Paths.introView;
  static const home = _Paths.home;
  static const testLottie = _Paths.testLottie;
  static const testFetchingApi = _Paths.testFetchingApi;
}

abstract class _Paths {
  _Paths._();
  static const splash = 'splash';
  static const introView = 'intro-view';
  static const home = 'home';
  static const testLottie = 'test-lottie';
  static const testFetchingApi = 'test-fetching-api';
}
