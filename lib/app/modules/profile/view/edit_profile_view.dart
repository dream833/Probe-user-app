import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uddipan/app/modules/profile/controllers/profile_controller.dart';
import 'package:uddipan/app/modules/signup/controllers/signup_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/app/widget/image_picker_widget.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/color_constant.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const SmallText(
              text: 'Update Profile',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textColor: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Center(
                      child: ImagePickerWidget(
                        image: controller.profilePicture.value,
                        initialUrl: controller.image.value,
                        onImageSelected: (image) {
                          controller.setProfilePicture(image);
                        },
                      ),
                    )),
                SizedBox(height: 20.h),
                Center(
                  child: SmallText(
                      text: 'Upload Image',
                      fontSize: 16,
                      textColor: Colors.grey.shade700),
                ),
                SizedBox(height: 15.h),
                SmallText(text: 'Name', textColor: Colors.grey.shade700),
                SizedBox(height: 10.h),
                CustomTextField(
                    hintText: 'Name',
                    controller: controller.nameController.value,
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
                    controller: controller.phoneController.value,
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
                SizedBox(height: 15.h),
                SmallText(text: 'Email', textColor: Colors.grey.shade700),
                SizedBox(height: 10.h),
                CustomTextField(
                    hintText: 'Email',
                    prefixIcon: Icons.email,
                    controller: controller.emailController.value,
                    prefixIconSize: 20),
                SizedBox(height: 20.h),
                SmallText(text: 'Address', textColor: Colors.grey.shade700),
                SizedBox(height: 10.h),
                CustomTextField(
                  hintText: 'Address',
                  controller: controller.addressController.value,
                  prefixIcon: FontAwesomeIcons.locationPin,
                  prefixIconSize: 19,
                ),
                SizedBox(height: 20.h),
                SmallText(text: 'Pin', textColor: Colors.grey.shade700),
                SizedBox(height: 10.h),
                CustomTextField(
                  hintText: 'Pin',
                  controller: controller.pinController.value,
                  prefixIcon: Icons.pin_outlined,
                  prefixIconSize: 19,
                ),
                SizedBox(height: 25.h),
                LoaderButton(
                    btnText: 'Update Profile',
                    onTap: () async {
                      await controller.updateUserProfile(context: context);
                    }),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ));
  }
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

/*
 SmallText(text: 'Select Gender', textColor: Colors.grey.shade700),
              Row(
                children: controller.radioItems
                    .asMap()
                    .entries
                    .map((entry) => buildRadioTile(entry.key, entry.value))
                    .toList(),
              ),
              const Spacer(),
*/ 