import 'package:flutter/material.dart';
import '../config/config.dart';

class UserInteraction {
  UserInteraction._();
  static DateTime? _lastinteractionTime;

  static UserInteraction get it => UserInteraction._();

  void checkLastInteraction() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    checkUserActivity();
  }

  void checkUserActivity() {
    // if (userNotifier.value == null) {
    //   _lastinteractionTime = null;
    //   return;
    // }
    // _lastinteractionTime ??= DateTime.now();
    // int differenceInMinutes = DateTime.now().difference(_lastinteractionTime!).inMinutes;
    // int timeOutTime = AppConfig.environment == Environment.dev ? 360 : 5;
    // if (differenceInMinutes >= timeOutTime) {
    //   logoutUser(LoginSource.timeout);
    // } else {
    //   _lastinteractionTime = DateTime.now();
    // }
  }
}
