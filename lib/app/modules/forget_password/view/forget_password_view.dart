import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/forget_password/controller/forget_password_controller.dart';
import 'package:uddipan/app/widget/Button/custom_button.dart';
import 'package:uddipan/app/widget/Text/big_text.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/TextFromField/custom_text_form.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/routes/app_pages.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgetPasswordController>();
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      appBar: AppBar(
        title: const  Text('Forget Password'),
        backgroundColor: AppColor.secondaryGreen,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40,),
            const BigText(text: 'Forget your password'),
            const SizedBox(height: 20,),
            const SmallText(text: "Now it's very easy to recover your password"),
            const SizedBox(height: 30,),
            const BigText(
              text: 'Write your email address we will send you a temporary password',
              maxLine: 3,
            ),
            const SizedBox(height: 20,),
            CustomTextForm(controller: controller.forgetEmailController, hintText: 'Email',),

            const SizedBox(height: 40,),

            CustomButton(
              onPress: () {
                // controller.forgetEmailController.text = '';
                Get.toNamed(Routes.bottomNavigationBar);
              },
              title: 'Recover Password',
            ),
          ],
        ),
      ),
    );
  }
}

