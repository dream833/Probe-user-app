import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uddipan/app/modules/diagnostic_test/view/diagnostic_view.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/modules/profile/controllers/member_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/member_model.dart';
import 'package:uddipan/utils/custom_message.dart';
import 'package:uddipan/utils/snippet.dart';

class PatientView extends StatelessWidget {
  const PatientView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MemberController());
    final eshopController = Get.put(EShopController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const SmallText(
            text: 'Patients',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 10),
            FutureBuilder(
                future: delayDuration(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmerListEffect(
                        itemBorderRadius: 16, itemCount: 10);
                  }
                  return Obx(
                    () => controller.patients.isEmpty
                        ? const Column(
                            children: [
                              Center(
                                child: Icon(
                                  FontAwesomeIcons.ban,
                                  size: 120,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Column(
                                  children: [
                                    Text('No Saved Patient'),
                                    Text('Add new patient to continue'),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: controller.patients.length,
                                itemBuilder: (context, index) {
                                  MemberModel member =
                                      controller.patients[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: boxShadow,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              DisplayImageWidget(
                                                color: member.gender == 'Male'
                                                    ? appColorBlue
                                                    : appColorPrimary,
                                                height: 60,
                                                width: 60,
                                                child: Icon(
                                                  member.gender == 'Male'
                                                      ? Icons.person
                                                      : FontAwesomeIcons
                                                          .personDress,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    member.name,
                                                    style: CustomFont
                                                        .regularTextPoppins,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  // Text(
                                                  //   member.phone,
                                                  //   style: CustomFont
                                                  //       .regularTextRaleway,
                                                  // ),
                                                ],
                                              )
                                            ],
                                          )
                                        ]),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 40),
                              LoaderButton(
                                  color: Colors.deepOrange,
                                  btnText: 'Booked',
                                  onTap: () async {
                                    eshopController.bookedLabTest();

                                    Get.to(() => const DiagnosticTestView());
                                  })
                            ],
                          ),
                  );
                }),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Get.to(() => const AddPatientView());
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(FontAwesomeIcons.plus, color: Colors.white),
      ),
    );
  }
}

class AddPatientView extends StatelessWidget {
  const AddPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MemberController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const SmallText(
            text: 'Add Patient',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
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
                  initialCountryCode: 'IN',
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
              SizedBox(height: 20.h),
              SmallText(text: 'Select DOB', textColor: Colors.grey.shade700),
              SizedBox(height: 10.h),
              CustomTextField(
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context, //context of current state
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      controller.dob.value = pickedDate;
                      String formattedDate =
                          DateFormat('d MMM yyyy').format(pickedDate);
                      controller.dateOfBirth.value.text = formattedDate;
                    }
                  },
                  hintText: 'Select Date',
                  prefixIcon: Icons.calendar_month,
                  inputType: TextInputType.datetime,
                  controller: controller.dateOfBirth.value),
              SizedBox(height: 10.h),
              SmallText(text: 'Select Gender', textColor: Colors.grey.shade700),
              Row(
                children: controller.radioItems
                    .asMap()
                    .entries
                    .map((entry) => buildRadioTile(entry.key, entry.value))
                    .toList(),
              ),
              const Spacer(),
              LoaderButton(
                  color: Colors.deepOrange,
                  btnText: 'Add Patient',
                  onTap: () async {
                    String name = controller.nameController.value.text;
                    String formatedDate = controller.dateOfBirth.value.text;
                    String phone =
                        "${controller.selectedDigitalCode.value}${controller.phoneController.value.text}";

                    if (name.isEmpty || phone.isEmpty || formatedDate.isEmpty) {
                      CustomMessage.errorMessage('Please Fill the fields');
                      return;
                    } else {
                      // MemberModel model = MemberModel(
                      //   name: controller.nameController.value.text,
                      //   dob: controller.dob.value,
                      //   phone:
                      //       " ${controller.selectedDigitalCode.value}${controller.phoneController.value.text}",
                      //   gender: controller.selectedRadio.value == 0
                      //       ? 'Male'
                      //       : 'Female',
                      // );
                      // await controller.addPatient(model);
                      // Get.back();
                    }
                  }),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRadioTile(int index, String item) {
    final controller = Get.put(MemberController());
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
