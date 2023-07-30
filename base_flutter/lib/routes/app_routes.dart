part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const splash = _Paths.splash;
  static const introView = _Paths.introView;
  static const home = _Paths.home;
}

abstract class _Paths {
  _Paths._();
  static const splash = 'splash';
  static const introView = 'intro-view';
  static const home = 'home';
}
