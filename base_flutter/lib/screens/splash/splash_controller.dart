import 'package:base_flutter/base/screen/controller/base_stateful_controller.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SplashController extends BaseStatefulController {
  late final AnimationController anim;

  @override
  void dispose() {
  }

  @override
  void initState(TickerProvider? vsync) {
    if (vsync != null) {
      anim = AnimationController(vsync: vsync);
      anim.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          context.goNamed(Routes.home);
        }
      });
    }
  }
}
