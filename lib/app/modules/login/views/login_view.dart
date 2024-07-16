import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/routes/app_pages.dart';
import 'package:uddipan/utils/custom_message.dart';
import '../../../widget/custom_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                const Text("Login", style: CustomFont.boldText),
                const SizedBox(height: 15),
                const Text("Sign In into your account",
                    style: CustomFont.regularText),
                SizedBox(height: 50.h),
                SmallText(text: 'Phone', textColor: Colors.grey.shade700),
                SizedBox(height: 15.h),
                // ---Phone Number Field
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
                    controller: controller.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      contentPadding: const EdgeInsets.only(bottom: 5, top: 10),
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
                SizedBox(height: 20.h),
                SmallText(text: 'Password', textColor: Colors.grey.shade700),
                SizedBox(height: 15.h),
                CustomTextField(
                  maxLine: 1,
                  hintText: 'Password',
                  controller: controller.password,
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.visibility,
                  suffixIcon2: Icons.visibility_off,
                  prefixIconSize: 22,
                  isVisible: true,
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.forgetPassword);
                    },
                    child: Text(
                      """Forgot Password?""",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                LoaderButton(
                    btnText: 'Login',
                    onTap: () async {
                      if (controller.phone.text.isEmpty) {
                        return CustomMessage.errorMessage(
                            'Please Enter Phone No');
                      }
                      if (controller.password.text.isEmpty) {
                        return CustomMessage.errorMessage(
                            'Please Enter Password');
                      }
                      await controller.login(context);
                    }),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Get.toNamed("/signup");
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: appColorPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
