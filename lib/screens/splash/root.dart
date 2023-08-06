import 'package:anywhere/core/navigation/keys.dart';
import 'package:anywhere/core/navigation/navigation_service.dart';
import 'package:anywhere/core/startup/app_startup.dart';
import 'package:anywhere/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      serviceLocator<NavigationService>().replaceWith(
        RouteKeys.home
      );
    });
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Image.asset(
            AppAssets.splash,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
