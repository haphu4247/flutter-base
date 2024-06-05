import 'package:app_base/app_base.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/shared/widgets/buttons/my_app_button.dart';
import 'package:base_flutter/shared/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
  HomeScreen({super.key}) : super(controller: HomeController());

  @override
  Widget buildView(BuildContext context) {
    controller.text;
    return Scaffold(
      appBar: MyAppbar.title(
        title: controller.title,
        leading: const SizedBox.shrink(),
      ),
      body: ListView(
        children: [
          MyAppButton.rectangle(
            title: 'Test Lottie',
            onTap: () => controller.gotoTest(AppRouteManager.testLottie),
          ),
          MyAppButton.rectangle(
            title: 'Test Fetching API',
            onTap: () => controller.gotoTest(AppRouteManager.testFetchingApi),
          )
        ],
      ),
    );
  }
}
