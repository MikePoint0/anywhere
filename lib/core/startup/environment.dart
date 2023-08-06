import 'dart:io';
import 'package:anywhere/core/config/config.dart';
import 'package:anywhere/core/enums/enviroment.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

setupConfig() async {
  // AppConfig.environment should always be the first line in this file
  AppConfig.environment = Environment.values.firstWhere(
    (element) => element.name == const String.fromEnvironment("env"),
    orElse: () => Environment.simpsonsviewer,
  );

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppConfig.version = packageInfo.version;
}
