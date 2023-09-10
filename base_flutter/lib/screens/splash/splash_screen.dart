import 'package:base_flutter/base/base_screen/view/base_stateful_screen.dart';
import 'package:base_flutter/base/widgets/lottie_view.dart';
import 'package:flutter/material.dart';

import 'splash_controller.dart';

class SplashScreen extends BaseStatefulScreen<SplashController> {
  SplashScreen({super.key}) : super(controller: SplashController());

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState
    extends BaseStatefulScreenState<SplashController, SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    widget.controller.anim = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieView(
          name: 'anim_splash',
          repeat: false,
          controller: widget.controller.anim,
          onLoaded: widget.controller.onLoaded,
        ),
      ),
    );
  }
}
