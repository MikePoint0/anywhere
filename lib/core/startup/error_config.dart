import 'dart:async';
import 'package:anywhere/core/config/config.dart';
import 'package:anywhere/core/enums/enviroment.dart';
import 'package:flutter/foundation.dart';

errorLogConfig() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    final exception = details.exception;
    final stackTrace = details.stack;
    if (AppConfig.environment == Environment.simpsonsviewer) {
      FlutterError.dumpErrorToConsole(details);
      // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      if (stackTrace == null) return;
      Zone.current.handleUncaughtError(exception, stackTrace);
      // await FirebaseCrashlytics.instance
      //     .recordError(exception, stackTrace, reason: '');
    }
  };
}
