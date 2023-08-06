import 'package:anywhere/core/config/config.dart';
import 'package:anywhere/core/network/keys.dart';
import 'package:anywhere/core/startup/app_startup.dart';
import 'package:anywhere/core/utils/colors.dart';
import 'package:anywhere/core/utils/constants.dart';
import 'package:anywhere/core/utils/response_message.dart';
import 'package:anywhere/core/utils/styles.dart';
import 'package:anywhere/core/widgets/button.dart';
import 'package:anywhere/screens/Home/cubit/home_cubit.dart';
import 'package:anywhere/screens/Home/models/character_list_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DetailsScreen extends StatefulWidget {
  RelatedTopics relatedTopics;
  DetailsScreen({Key? key, required this.relatedTopics});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final topContent = Stack(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.4,
            padding: EdgeInsets.all(40.w),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.primaryActive,
                image: DecorationImage(
                    image: NetworkImage(widget
                                .relatedTopics.icon!.uRL!.length ==
                            0
                        ? "http://via.placeholder.com/200x150"
                        : '${ApiConstants.imageUrl}${widget.relatedTopics.icon!.uRL}'),
                    fit: BoxFit.fitHeight))),
        Positioned(
          left: 8.w,
          top: 60.h,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      widget.relatedTopics.text!,
      style: TextStyle(fontSize: 16),
    );
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          topContent,
          Text(
            widget.relatedTopics.text!.split(" - ").first,
            style: TextStyle(color: AppColors.secondaryActive, fontSize: 35.sp),
          ),
          bottomContent
        ],
      ),
    );
  }
}
