import 'package:app_base/app_base.dart';
import 'package:base_flutter/base/widgets/lottie_view.dart';
import 'package:flutter/material.dart';

import '../vm/splash_vm.dart';

class SplashScreen extends BaseScreen<SplashVM> {
  SplashScreen({super.key,})
      : super(vm: SplashVM());

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieView(
          name: 'anim_splash',
          repeat: false,
          controller: vm.anim,
          onLoaded: (p0) {
            vm.onLoaded(p0, context);
          },
        ),
      ),
    );
  }
}
