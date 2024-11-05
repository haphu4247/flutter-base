import 'package:app_base/app_base.dart';
import 'package:base_flutter/base/widgets/loading_view.dart';
import 'package:base_flutter/screens/test/public_api/public_api_controller.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
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
      body: ValueListenableBuilder(
        valueListenable: widget.controller.coins,
        builder: (context, result, child) {
          if (result != null) {
            if (result.isNotEmpty) {
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
            }
            return const SizedBox.shrink();
          }
          return const LoadingView();
        },
      ),
    );
  }
}
