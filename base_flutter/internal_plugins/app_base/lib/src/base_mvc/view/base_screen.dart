import '../controller/base_controller.dart';
import 'package:flutter/material.dart';

abstract class BaseScreen<T extends BaseController> extends StatelessWidget {
  const BaseScreen({super.key, required T controller})
      : _controller = controller;
  final T _controller;

  T get controller => _controller;

  Widget buildView(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildView(context);
  }
}
