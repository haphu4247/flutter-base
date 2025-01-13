import 'package:app_base/app_base.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/routes/route_navigation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class SplashController extends BaseController {
  AnimationController? anim;

  @override
  void onInit() {
    anim = AnimationController(vsync: TickerProviderExt());
  }

  // void dispose(BuildContext context) {
  //   anim?.removeListener(() => onListen(context));
  //   anim?.dispose();
  // }

  void onLoaded(LottieComposition composition, BuildContext context) {
    // AppLogger.console(this, 'onLoaded: ${composition.toString()}');
    anim?.addListener(() => onListen(context));
    anim?.duration = composition.duration;
    anim?.forward();
  }

  void onListen(BuildContext context) {
    AppLogger.console(this, anim?.status);
    if (anim?.isCompleted == true) {
      RouteNavigation.of(context).replaceNamed('/${AppRouteManager.home}');
    }
  }

}

class TickerProviderExt extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
