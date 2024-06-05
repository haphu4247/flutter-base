import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter/material.dart';


class LoggerView {
  LoggerView._();
  static final instance = LoggerView._();

  final _talker = TalkerFlutter.init();
  Talker get talker => _talker;
  TalkerRouteObserver get talkerRouteObserver =>
      TalkerRouteObserver(this._talker);

  bool _enable = false;
  set enable(bool value) => this._enable = value;
  bool get enable => this._enable;

  Widget loggerWidget({
    required Widget child,
    required GlobalKey<NavigatorState> navigator,
  }) {
    if (enable == false) {
      return child;
    }
    return _CustomLoggerView(
      talker: talker,
      child: child,
      navigator: navigator,
    );
  }

  void observeLogger(Interceptors interceptors) {
    if (enable == false) {
      return;
    }
    interceptors.add(TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        //request
        printRequestHeaders: true,
        //response
        printResponseHeaders: true,
      ),
    ));
  }
}

class _CustomLoggerView extends StatefulWidget {
  const _CustomLoggerView({
    required this.child,
    required this.talker,
    required this.navigator,
  });

  final Widget child;
  final Talker talker;
  final GlobalKey<NavigatorState> navigator;

  @override
  State<_CustomLoggerView> createState() => _CustomLoggerViewState();
}

class _CustomLoggerViewState extends State<_CustomLoggerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TalkerWrapper(
            talker: widget.talker,
            options: const TalkerWrapperOptions(
              enableErrorAlerts: true,
              enableExceptionAlerts: true,
            ),
            child: widget.child,
          ),
          Positioned(
            left: 0,
            bottom: 100,
            child: TextButton(
              onPressed: gotoLogView,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                foregroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
              child: Text(
                'log'.toUpperCase(),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void gotoLogView() {
    widget.navigator.currentState?.push(
      MaterialPageRoute(
        builder: (context) =>
            TalkerScreen(talker: widget.talker, appBarTitle: 'Log View'),
      ),
    );
  }
}
