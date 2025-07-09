import 'package:app_base/app_base.dart';
import 'package:base_flutter/data/local_repositories/local_repository.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/material.dart';

class HomeVM extends BaseViewModel {
  const HomeVM(this._localRepo);

  final LocalRepository _localRepo;

  @override
  void onInit(
      {required void Function() onRefresh, required BuildContext context}) {
    checkLogin(context);
  }

  void checkLogin(BuildContext context) {
    _localRepo.getLoginInfo().then(
      (value) {
        if (value == null) {
          showLoginDialog(context);
        } else {
          showDefaultDialog(
            context.lang.hello(value.username?.toUpperCase() ?? 'Guest'),
            icon: context.envConfig.appIcon,
          );
        }
      },
    );
  }

  String title(BuildContext context) {
    final env = context.lang.appVariant(context.envConfig.env.name);
    return 'Home $env';
  }

  void gotoTest(BuildContext context, AppRouteManager route) {
    context.navigation.nextRoute(route);
  }

  void gotoPushNext(BuildContext context, AppRouteManager route) {
    context.navigation.pushRoute(route);
  }

  void showLoginDialog(BuildContext screenContext) {
    showCustomDialog(
      (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              const Text(
                'You need to login first',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  dismissDialog().then((_) {
                    screenContext.navigation.pushRoute(AppRouteManager.login);
                  });
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
