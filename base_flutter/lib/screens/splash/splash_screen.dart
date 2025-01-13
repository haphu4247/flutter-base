import 'package:app_base/app_base.dart';
import 'package:base_flutter/base/widgets/lottie_view.dart';
import 'package:flutter/material.dart';

import 'splash_controller.dart';

class SplashScreen extends BaseScreen<SplashController> {
  SplashScreen({super.key,})
      : super(controller: SplashController());

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieView(
          name: 'anim_splash',
          repeat: false,
          controller: controller.anim,
          onLoaded: (p0) {
            controller.onLoaded(p0, context);
          },
        ),
      ),
    );
  }
}
