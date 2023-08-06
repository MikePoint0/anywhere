import 'package:anywhere/core/utils/colors.dart';
import 'package:flutter/material.dart';

import 'font_family.dart';

class AppTheme {
  static ThemeData lightThemeData = ThemeData(
    // accentColor: Colors.black
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryActive,
    ),
    colorScheme: const ColorScheme.light(primary: AppColors.primaryActive),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.primaryActive),
    fontFamily: FontFamily.hankenGrotesk,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    focusColor: AppColors.secondaryActive,
    hintColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerColor: Colors.transparent,
  );
}
