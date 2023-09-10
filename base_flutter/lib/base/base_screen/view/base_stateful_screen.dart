import 'package:base_flutter/base/base_screen/controller/base_controller.dart';
import 'package:flutter/material.dart';

abstract class BaseStatefulScreen<T extends BaseController>
    extends StatefulWidget {
  const BaseStatefulScreen({
    super.key,
    required this.controller,
  });

  final T controller;
}

abstract class BaseStatefulScreenState<T extends BaseController,
    S extends BaseStatefulScreen<T>> extends State<S> {
  Widget buildView(BuildContext context);

  @override
  void initState() {
    super.initState();
    widget.controller.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.context = context;
    return buildView(context);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
