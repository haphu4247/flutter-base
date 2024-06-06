import 'package:app_base/src/base_mvc/controller/base_controller.dart';
import 'package:flutter/material.dart';

abstract class BaseStatefulScreen<T extends BaseController>
    extends StatefulWidget {
  const BaseStatefulScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final T controller;
}

abstract class BaseStatefulScreenState<T extends BaseController,
    S extends BaseStatefulScreen<T>> extends State<S> {
  Widget buildView(BuildContext context);

  @override
  void initState() {
    widget.controller.initState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.initContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildView(context);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
