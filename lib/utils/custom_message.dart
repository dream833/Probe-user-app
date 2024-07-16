import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constants/color_constant.dart';

class CustomMessage {
  static showSnackBar(String message,
      {String title = 'Warning', Color? backgroundColor}) {
    Get.snackbar(
      title,
      message,
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
      backgroundColor: backgroundColor ?? AppColor.green.withOpacity(0.4),
      borderRadius: 20.r,
    );
  }

  static errorMessage(String title) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  static showSuccessSnackBar(String message,
      {String title = 'Successful', Color? backgroundColor}) {
    Get.snackbar(
      title,
      message,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      backgroundColor: backgroundColor ?? AppColor.green.withOpacity(0.4),
      borderRadius: 20.r,
    );
  }
}
