import 'package:base_flutter/base/base_screen/controller/base_controller.dart';
import 'package:flutter/material.dart';

abstract class BaseScreen<T extends BaseController> extends StatelessWidget {
  const BaseScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final T controller;

  Widget buildView(BuildContext context);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return buildView(context);
  }
}
