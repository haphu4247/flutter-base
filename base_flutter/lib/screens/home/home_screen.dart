import 'package:base_flutter/base/screen/view/base_screen.dart';
import 'package:base_flutter/base/widgets/loading_view.dart';
import 'package:base_flutter/base/widgets/no_data_widget.dart';
import 'package:base_flutter/shared/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
  HomeScreen({super.key}) : super(controller: HomeController());

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar.Title(title: controller.title),
      body: ListView(
        children: [
          const NoDataView(),
          NoDataView.page404(),
          const LoadingView(),
          LoadingView.search()
        ],
      ),
    );
  }
}
