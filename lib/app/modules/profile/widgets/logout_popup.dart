import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/widget/Button/custom_outline_button.dart';
import 'package:uddipan/app/widget/Button/custom_rounded_button.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';

import '../controllers/profile_controller.dart';

logoutPopup() {
  final controller = Get.put(ProfileController());
  Get.defaultDialog(
      barrierDismissible: false,
      title: "Warning",
      titlePadding: EdgeInsets.only(top: 15.h),
      contentPadding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h, bottom: 5.h),
      content: Column(
        children: [
          SmallText(
            text: "Do you want to logout?",
            fontSize: 13.sp,
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Expanded(
                child: CustomOutlineButton(
                  height: 30.h,
                  onPress: () {
                    Get.back();
                  },
                  title: 'Cancel',
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: CustomRoundedButton(
                  height: 30.h,
                  onPress: () {
                    controller.userLogout();
                  },
                  title: "Logout",
                ),
              ),
            ],
          ),
        ],
      ));
}
