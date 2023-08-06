import 'package:anywhere/core/utils/colors.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
  tertiary,
  ghost,
  dialog,
}

extension ButtonTypeExt on ButtonType {
  Color get buttonColor {
    switch (this) {
      case ButtonType.primary:
        return AppColors.primaryActive;
      case ButtonType.secondary:
        return AppColors.black;
      case ButtonType.tertiary:
        return Colors.transparent;
      case ButtonType.ghost:
        return Colors.transparent;
      case ButtonType.dialog:
        return AppColors.black;
    }
  }

  Color get disabledColor {
    switch (this) {
      case ButtonType.primary:
        return AppColors.primaryDisabled;
      case ButtonType.secondary:
        return AppColors.black;
      case ButtonType.tertiary:
        return Colors.transparent;
      case ButtonType.ghost:
        return Colors.transparent;
      case ButtonType.dialog:
        return AppColors.black;
    }
  }

  Color get borderColor {
    switch (this) {
      case ButtonType.primary:
        return AppColors.primaryActive;
      case ButtonType.secondary:
        return AppColors.black;
      case ButtonType.tertiary:
        return Colors.black;
      case ButtonType.ghost:
        return Colors.transparent;
      case ButtonType.dialog:
        return AppColors.black;
    }
  }

  Color get textColor {
    switch (this) {
      case ButtonType.primary:
        return Colors.white;
      case ButtonType.secondary:
        return AppColors.white;
      case ButtonType.tertiary:
        return AppColors.white;
      case ButtonType.ghost:
        return AppColors.primaryActive;
      case ButtonType.dialog:
        return AppColors.black;
    }
  }
}
