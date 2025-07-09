import 'package:app_base/app_base.dart';
import 'package:base_flutter/app/di_config.dart';
import 'package:base_flutter/data/local_repositories/local_repository.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/shared/widgets/buttons/my_app_button.dart';
import 'package:base_flutter/shared/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

import '../vm/home_vm.dart';

class HomeScreen extends BaseScreen<HomeVM> {
  HomeScreen({super.key}) : super(vm: HomeVM(getIt.get<LocalRepository>()));

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.title(
        title: vm.title(context),
        leading: const SizedBox.shrink(),
      ),
      body: ListView(
        children: [
          MyAppButton.rectangle(
            title: 'Test Page Not Found',
            onTap: () => vm.gotoPushNext(context, AppRouteManager.pageNotFound),
          ),
          MyAppButton.rectangle(
            title: 'Login Page',
            onTap: () => vm.checkLogin(context),
          ),
        ],
      ),
    );
  }
}
