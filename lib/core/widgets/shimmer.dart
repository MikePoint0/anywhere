import 'package:anywhere/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final Color? color;

  const ShimmerWidget({
    Key? key,
    this.color,
    this.radius = 0,
    required this.width,
    required this.height,
  }) : super(key: key);

  // const ShimmerWidget.rectangle(
  //     {Key? key,
  //     this.width = double.infinity,
  //     this.color,this.radius = 0,
  //     required this.height})
  //     : shapeBorder = const RoundedRectangleBorder(),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color ?? const Color(0xffEEEFF2),
      highlightColor: color ?? const Color(0xffEEEFF2).withOpacity(0.4),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class ShimmerTextWidget extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ShimmerTextWidget({
    Key? key,
    this.text = '#.##',
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: style.color ?? AppColors.primaryActive,
        highlightColor: const Color(0xffEEEFF2).withOpacity(0.4),
        child: Text(text, style: style));
  }
}
