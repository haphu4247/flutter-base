import 'package:app_base/app_base.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/shared/extension/context_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class SplashController extends BaseController {
  AnimationController? anim;

  @override
  void initState() {
    anim?.addListener(onListen);
  }

  @override
  void dispose() {
    anim?.removeListener(onListen);
    anim?.dispose();
  }

  void onLoaded(LottieComposition composition) {
    AppLogger.console(this, 'onLoaded: ${composition.toString()}');
    anim?.addListener(onListen);
    anim?.duration = composition.duration;
    anim?.forward();
  }

  void onListen() {
    AppLogger.console(this, anim?.status);
    if (anim?.isCompleted == true) {
      context?.navigation.replaceNamed(AppRouteManager.home);
    }
  }
}
