import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../constants/image_contant.dart';

class AppBarLeadingIcon extends StatelessWidget {
  final Color? iconColor;

  const AppBarLeadingIcon({super.key, this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        // height: 50,
        // color: Colors.red,
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          Platform.isAndroid
              ? AppImage.arrowBackAndroid
              : AppImage.arrowBackIos,

          // color: isSelected ? AppColor.secondaryGreen : Colors.blue,
        ),
      ),
    );
  }
}

class AppBarLeadingIcon2 extends StatelessWidget {
  final Color? iconColor;

  const AppBarLeadingIcon2({super.key, this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10.w, top: 5.h),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: SvgPicture.asset(
          Platform.isAndroid
              ? AppImage.arrowBackAndroid
              : AppImage.arrowBackIos,
        ),
      ),
    );
  }
}
