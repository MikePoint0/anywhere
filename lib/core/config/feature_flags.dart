import 'package:anywhere/core/config/config.dart';
import 'package:anywhere/core/enums/enviroment.dart';
import 'package:anywhere/core/enums/features_flags.dart';

extension FeaturesExt on Features {
  Environment get featureEnvironment {
    switch (this) {
      case Features.chat:
        return Environment.simpsonsviewer;
      case Features.login:
        return Environment.simpsonsviewer;
      case Features.signup:
        return Environment.wireviewer;
      case Features.fbLogin:
        return Environment.wireviewer;
      case Features.etc:
        return Environment.wireviewer;
    }
  }

  bool get isActive => featureEnvironment.rank >= AppConfig.environment.rank;
}