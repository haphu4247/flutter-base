part of 'app_pages.dart';

enum AppRouteManager {
  splash('splash'),
  login('login'),
  home('home'),
  pageNotFound('page-not-found');

  final String name;
  const AppRouteManager(this.name);

  String get path {
    return '/$name';
  }

  @override
  String toString() {
    return name;
  }
}
