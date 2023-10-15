import 'package:base_flutter/base/widgets/loading_view.dart';
import 'package:flutter/material.dart';

class FutureView<T> extends StatelessWidget {
  const FutureView({
    super.key,
    required this.future,
    required this.view,
  });
  final Future<T> future;
  final Widget view;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return view;
        }
        return const LoadingView();
      },
    );
  }
}
