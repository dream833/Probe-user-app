import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uddipan/app/modules/signup/views/widget/profile_picture_widget.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/color_constant.dart';
import '../../../widget/custom_textfield.dart';
import '../controllers/signup_controller.dart';

enum Gender { male, female }

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const SmallText(
            text: 'Create Your Account',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  const Center(child: ProfilePictureWidget()),
                  SizedBox(height: 15.h),
                  SmallText(text: 'Name', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  CustomTextField(
                      hintText: 'Name',
                      controller: controller.nameController,
                      prefixIcon: Icons.person,
                      prefixIconSize: 20),
                  SizedBox(height: 15.h),
                  SmallText(text: 'Phone', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          offset: Offset(-1, 1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: IntlPhoneField(
                      languageCode: "en",
                      autofocus: false,
                      initialCountryCode: controller.selectedCountryCode.value,
                      disableLengthCheck: true,
                      controller: controller.phoneController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        contentPadding:
                            const EdgeInsets.only(bottom: 5, top: 10),
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 14, color: greyColor),
                        border: InputBorder.none,
                      ),
                      onChanged: (phone) {},
                      onCountryChanged: (country) {
                        log('country code + ${country.code} + country dial ${country.dialCode}');
                        controller.selectedCountryCode.value = country.code;
                        controller.selectedDigitalCode.value = country.dialCode;
                      },
                    ),
                  ),
                  SizedBox(height: 15.h),
                  SmallText(text: 'Email', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  CustomTextField(
                      maxLine: 1,
                      hintText: 'Email',
                      prefixIcon: Icons.email,
                      controller: controller.emailController,
                      prefixIconSize: 20),
                  SizedBox(height: 20.h),
                  SmallText(
                      text: 'Select Gender', textColor: Colors.grey.shade700),
                  Row(
                    children: controller.radioItems
                        .asMap()
                        .entries
                        .map((entry) => buildRadioTile(entry.key, entry.value))
                        .toList(),
                  ),
                  SizedBox(height: 10.h),

                  SmallText(text: 'Password', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    maxLine: 1,
                    hintText: 'Password',
                    controller: controller.passwordController,
                    prefixIcon: Icons.lock,
                    suffixIcon: Icons.visibility,
                    suffixIcon2: Icons.visibility_off,
                    prefixIconSize: 22,
                    isVisible: true,
                  ),
                  SizedBox(height: 15.h),
                  SmallText(
                      text: 'Confrim Password',
                      textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    maxLine: 1,
                    hintText: 'Confirm Password',
                    controller: controller.confirmPasswordController,
                    prefixIcon: Icons.lock,
                    suffixIcon: Icons.visibility,
                    suffixIcon2: Icons.visibility_off,
                    prefixIconSize: 22,
                    isVisible: true,
                  ),
                  SizedBox(height: 20.h),
                  LoaderButton(
                      btnText: 'Sign Up',
                      onTap: () async {
                        await controller.signup(context);
                      }),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRadioTile(int index, String item) {
    final controller = Get.put(SignupController());
    return Row(
      children: [
        Obx(
          () => Radio(
            value: index,
            activeColor: const Color(0xff06B198),
            groupValue: controller.selectedRadio.value,
            onChanged: (value) {
              controller.setSelectedRadio(value!);
            },
          ),
        ),
        Text(item),
      ],
    );
  }
}
