import 'package:base_flutter/base/widgets/lottie_view.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
    this.name = 'anim_loading',
  }) : super(key: key);

  factory LoadingView.search() => const LoadingView(
        name: 'anim_search',
      );

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(child: LottieView(name: name));
  }
}
