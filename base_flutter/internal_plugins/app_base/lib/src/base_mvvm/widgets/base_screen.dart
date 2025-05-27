import 'package:flutter/material.dart';
import '../viewmodel/base_viewmodel.dart';

abstract class BaseScreen<T extends BaseViewModel> extends StatefulWidget {
  const BaseScreen({super.key, required this.vm});
  final T vm;

  Widget buildView(BuildContext context);

  @override
  State<BaseScreen<T>> createState() => _BaseScreenState<T>();
}

class _BaseScreenState<T extends BaseViewModel> extends State<BaseScreen<T>> {
  @override
  void initState() {
    super.initState();
    widget.vm.onInit(onRefresh: _onRefresh, context: context);
  }

  @override
  void dispose() {
    super.dispose();
    widget.vm.onDispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      fn.call();
    }
  }

  void _onRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildView(context);
  }
}
