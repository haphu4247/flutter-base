import 'package:app_base/app_base.dart';
import 'package:base_flutter/base/widgets/my_state_view.dart';
import 'package:base_flutter/base/widgets/no_data_widget.dart';
import 'package:base_flutter/data/api_repositories/public/models/public_api/coin_list_response.dart';
import 'package:base_flutter/screens/test/public_api/public_api_controller.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:base_flutter/shared/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class PublicApiScreen extends BaseScreen<PublicApiController> {
  PublicApiScreen({super.key}) : super(controller: PublicApiController());

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.title(title: controller.title),
      body: MyStateView<List<CoinModel>?>(
        listener: controller.coins,
        child: (result) {
          if (result!.isEmpty) {
            return const Center(
              child: NoDataView(),
            );
          }
          return ListView.builder(
            itemCount: result!.length,
            itemBuilder: (context, index) {
              final model = result.elementAt(index);
              return Card(
                elevation: 8,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: model.toJson().entries.map<Widget>((e) {
                      return RichText(
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.appColors.primary),
                          children: [
                            TextSpan(
                              text: '${e.key}: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: context.appColors.link),
                            ),
                            TextSpan(text: e.value.toString()),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
