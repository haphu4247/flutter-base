import 'package:app_base/app_base.dart';
import 'package:base_flutter/base/widgets/no_data_widget.dart';
import 'package:base_flutter/plugin/auto_size_text_plugin.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:base_flutter/shared/widgets/buttons/my_app_button.dart';
import 'package:base_flutter/shared/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

import '../vm/page_not_found_vm.dart';

class PageNotFoundScreen extends BaseScreen<PageNotFoundVM> {
  PageNotFoundScreen({super.key}) : super(vm: PageNotFoundVM());

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.title(
        title: vm.title,
        titleStyle: TextStyle(color: context.appColors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NoDataView.page404(),
          AutoSizeTextPlugin(context.lang.page_not_found,
              style: Theme.of(context).textTheme.headlineMedium)
        ],
      ),
      bottomNavigationBar: MyAppButton.rectangle(
        title: context.lang.back,
        textColor: context.appColors.white,
        onTap: () => vm.onBack(context),
        btnPadding: const EdgeInsets.symmetric(vertical: 28),
      ),
    );
  }
}
