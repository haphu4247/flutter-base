import 'package:base_flutter/base/base_screen/view/base_stateful_screen.dart';
import 'package:base_flutter/base/widgets/loading_view.dart';
import 'package:base_flutter/data/models/public_api/coin_list_response.dart';
import 'package:base_flutter/screens/test/public_api/public_api_controller.dart';
import 'package:base_flutter/shared/colors/app_colors.dart';
import 'package:base_flutter/shared/extension/response_extension.dart';
import 'package:base_flutter/shared/widgets/my_appbar.dart';
import 'package:flutter/material.dart';

class PublicApiScreen extends BaseStatefulScreen<PublicApiController> {
  PublicApiScreen({super.key}) : super(controller: PublicApiController());

  @override
  State<PublicApiScreen> createState() => _PublicApiScreenState();
}

class _PublicApiScreenState
    extends BaseStatefulScreenState<PublicApiController, PublicApiScreen> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar.title(title: widget.controller.title),
      body: FutureBuilder(
        future: widget.controller.list(),
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data != null) {
            final result = data.checkResultList<CoinListResponse, CoinModel>(
              jsonParser: CoinListResponse.new,
              itemParser: CoinModel.fromJson,
              onSuccess: (value) {},
            );
            if (result != null) {
              return ListView.builder(
                itemCount: result.length,
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
                                      color: AppColors.primary),
                              children: [
                                TextSpan(
                                  text: '${e.key}: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.link),
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
            }
            return const SizedBox.shrink();
          }
          return const LoadingView();
        },
      ),
    );
  }
}
