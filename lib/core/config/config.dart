import 'package:anywhere/core/enums/enviroment.dart';

class AppConfig {
  AppConfig._();
  // WARNING: Do not modify this set values inside this file
  static late Environment environment;
  static String? sessionTime;
  static late String version;

  static const String appPackageAndroid = "com.sample";

  static const String appIDIOS = "0000000000";
}

extension EnvironmentExt on Environment {
  int get rank {
    switch (this) {
      case Environment.simpsonsviewer:
        return 0;
      case Environment.wireviewer:
        return 1;
    }
  }
}
