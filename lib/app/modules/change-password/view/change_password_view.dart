import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/change-password/controller/change_password_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/app/widget/loader_button.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
   final controller = Get.put(ChangePasswordController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const SmallText(
            text: 'Change Password',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            SmallText(text: 'Old Password', textColor: Colors.grey.shade700),
            SizedBox(height: 10.h),
            CustomTextField(
                controller: controller.oldPasswordController,
                hintText: 'Old Password',
                prefixIcon: Icons.key),
            SizedBox(height: 20.h),
            SmallText(text: 'New Password', textColor: Colors.grey.shade700),
            SizedBox(height: 10.h),
            CustomTextField(
                controller: controller.newPasswordController,
                hintText: 'New Password',
                prefixIcon: Icons.key),
            const Spacer(),
            LoaderButton(
                btnText: 'Update Password',
                onTap: () async {
                  await controller.changePassword();
                }),
          ],
        ),
      ),
    );
  }
}
