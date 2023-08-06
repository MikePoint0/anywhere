import 'package:anywhere/core/utils/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../enums/button.dart';

class AppButton extends StatelessWidget {
  final Widget? child;
  final String? buttonText;
  final ButtonType buttonType;
  final VoidCallback? onPressed;
  final bool? isLoading;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? verticalPadding;
  final TextStyle? textStyle;
  final double? radius;
  const AppButton(
      {Key? key,
      this.child,
      this.radius,
      this.color,
      this.textColor,
      this.buttonText,
      this.borderColor,
      this.buttonType = ButtonType.primary,
      this.onPressed,
      this.isLoading,
      this.verticalPadding,
      this.textStyle})
      : assert(buttonText != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key ?? (buttonText == null ? UniqueKey() : ValueKey(buttonText!)),
      onPressed: () {
        if (onPressed != null) {
          FocusScope.of(context).unfocus();
          onPressed!();
        }
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
        padding: MaterialStateProperty.resolveWith<EdgeInsets>(
          (states) => EdgeInsets.symmetric(vertical: verticalPadding ?? 12.h),
        ),
        fixedSize: MaterialStateProperty.resolveWith<Size>(
          (states) => Size(335.w, 48.h),
        ),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (states) => RoundedRectangleBorder(
            side: BorderSide(
              color: onPressed == null
                  ? Colors.transparent
                  : borderColor ?? color ?? buttonType.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(radius ?? 8.r),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled) || onPressed == null) {
              return buttonType.disabledColor;
            }
            return color ??
                buttonType.buttonColor; // Use the component's default.
          },
        ),
      ),
      child: (isLoading ?? false)
          ? _loadingWidget()
          : child ??
              Text(
                buttonText!,
                style: textStyle ??
                    TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      fontFamily: FontFamily.hankenGrotesk,
                      color: textColor ?? buttonType.textColor,
                    ),
              ),
    );
  }
}

Widget _loadingWidget() => const Center(
      child: CircularProgressIndicator(
        color: Color(0xFFF4F4F4),
      ),
    );
