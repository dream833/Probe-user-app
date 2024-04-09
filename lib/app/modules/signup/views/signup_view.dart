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
import 'package:uddipan/models/union/union_model.dart';
import 'package:uddipan/models/zone/zone_model.dart';
import '../../../../models/branch/branch_model.dart';
import '../../../../models/district/district_model.dart';
import '../../../../models/division/division_model.dart';
import '../../../../models/region/region_model.dart';
import '../../../../models/thana/thana_model.dart';
import '../../../widget/custom_textfield.dart';
import '../../../widget/search_dropdown.dart';
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
                  SmallText(
                      text: 'Email(Optional)', textColor: Colors.grey.shade700),
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
                      text: 'Confirm Password',
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
                  SizedBox(height: 15.h),
                  SmallText(
                      text: 'PIN Number', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    maxLine: 1,
                    inputType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(8)],
                    hintText: 'PIN',
                    controller: controller.pinController,
                    prefixIcon: Icons.pin_outlined,
                    prefixIconSize: 22,
                  ),
                  SizedBox(height: 15.h),
                  SmallText(
                      text: 'Address(Optional)',
                      textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    maxLine: 1,
                    inputType: TextInputType.text,
                    hintText: 'Address',
                    controller: controller.addressController,
                    prefixIcon: Icons.location_city,
                    prefixIconSize: 22,
                  ),
                  SizedBox(height: 15.h),
                  SmallText(
                      text: 'Select Zone', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  // Select Zone
                  Obx(
                    () => Container(
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
                        child: controller.isZoneLoading.value
                            ? Container()
                            : SearchDropDown(
                                hintText: 'Select Zone',
                                items: controller.zoneList.isEmpty
                                    ? ['No Data Found']
                                    : controller.zoneList
                                        .map((e) => e.name)
                                        .toList(),
                                onChange: (newValue) {
                                  controller.selectedZone.value = newValue!;
                                  ZoneModel zone = controller.zoneList
                                      .where((e) => e.name == newValue)
                                      .first as ZoneModel;
                                  controller.selectedZoneId.value =
                                      zone.id ?? 0;
                                  log('Selected Zone ID is ===============> ${controller.selectedZoneId.value}');
                                  controller.isRegionLoading.value = true;
                                  controller.selectedRegion.value = '';
                                  controller.selectedBranch.value = '';
                                  controller.selectedDistrict.value = '';
                                  controller.selectedDivision.value = '';
                                  controller.selectedThana.value = '';
                                  controller.selectedUnion.value = '';
                                  controller
                                      .fetchRegion(
                                          controller.selectedZoneId.value)
                                      .then((_) {
                                    controller.isRegionLoading.value = false;
                                  });
                                },
                                value: controller.selectedZone.value.isNotEmpty
                                    ? controller.selectedZone.value
                                    : null,
                              )),
                  ),

                  SizedBox(height: 15.h),
                  SmallText(
                      text: 'Select Region', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  // Select Region

                  Obx(() => Container(
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
                        child: controller.isRegionLoading.value
                            ? const SizedBox.shrink()
                            : SearchDropDown(
                                hintText: 'Select Region',
                                items: controller.regionList.isEmpty
                                    ? ['No Data Found']
                                    : controller.regionList
                                        .map((item) => item.regionName)
                                        .toList(),
                                onChange: (newValue) {
                                  controller.selectedRegion.value = newValue!;
                                  Region region = controller.regionList
                                      .where((e) => e.regionName == newValue)
                                      .first;
                                  print(region);
                                  controller.selectedRegionId.value =
                                      region.id ?? 0;
                                  log('Selected Region ID is =================> ${controller.selectedRegionId.value}');
                                  controller.isBranchLoading.value = true;
                                  controller.selectedBranch.value = '';
                                  controller.selectedDistrict.value = '';
                                  controller.selectedDivision.value = '';
                                  controller.selectedThana.value = '';
                                  controller.selectedUnion.value = '';
                                  controller
                                      .fetchBranch(
                                          controller.selectedRegionId.value)
                                      .then((_) {
                                    controller.isBranchLoading.value = false;
                                  });
                                },
                                value:
                                    controller.selectedRegion.value.isNotEmpty
                                        ? controller.selectedRegion.value
                                        : null,
                              ),
                      )),

                  SizedBox(height: 15.h),
                  SmallText(
                      text: 'Select Branch', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  Obx(() => Container(
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
                        child: controller.isBranchLoading.value
                            ? const SizedBox.shrink()
                            : SearchDropDown(
                                hintText: 'Select Branch',
                                items: controller.branchList.isEmpty
                                    ? ['No Data Found']
                                    : controller.branchList
                                        .map((item) => item.branchName)
                                        .toList(),
                                onChange: (newValue) {
                                  controller.selectedBranch.value = newValue!;

                                  Branch branch = controller.branchList
                                      .where((e) => e.branchName == newValue)
                                      .first;
                                  log(branch.id.toString());
                                  controller.selectedBranchId.value =
                                      branch.id ?? 0;
                                  log('Selected Branch ID is =============> ${controller.selectedBranchId.value}');

                                  /// This code is for call the next drop down
                                  controller.isDivisionLoading.value = true;
                                  controller.selectedDistrict.value = '';
                                  controller.selectedDivision.value = '';
                                  controller.selectedThana.value = '';
                                  controller.selectedUnion.value = '';

                                  controller.fetchDivision().then((_) {
                                    controller.isDivisionLoading.value = false;
                                  });
                                },
                                value:
                                    controller.selectedBranch.value.isNotEmpty
                                        ? controller.selectedBranch.value
                                        : null,
                              ),
                      )),
                  SizedBox(height: 15.h),
                  SmallText(
                      text: 'Select Division', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),

                  Obx(() => Container(
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
                        child: controller.isDivisionLoading.value
                            ? const SizedBox.shrink()
                            : SearchDropDown(
                                hintText: 'Select Division',
                                items: controller.divisionList.isEmpty
                                    ? ['No Data Found']
                                    : controller.divisionList
                                        .map((item) => item.name)
                                        .toList(),
                                onChange: (newValue) {
                                  controller.selectedDivision.value = newValue!;
                                  final Division division = controller
                                      .divisionList
                                      .where((e) => e.name == newValue)
                                      .first;

                                  controller.selectedDivisionId.value =
                                      division.id ?? 0;

                                  controller.isDistrictLoading.value = true;

                                  controller.selectedThana.value = '';
                                  controller.selectedUnion.value = '';

                                  controller
                                      .fetchDistrict(
                                          controller.selectedDivisionId.value)
                                      .then((_) {
                                    controller.isDistrictLoading.value = false;
                                  });
                                },
                                value:
                                    controller.selectedDivision.value.isNotEmpty
                                        ? controller.selectedDivision.value
                                        : null,
                              ),
                      )),

                  SizedBox(height: 15.h),
                  SmallText(
                      text: 'Select District', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),

                  Obx(() => Container(
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
                        child: controller.isDistrictLoading.value
                            ? const SizedBox.shrink()
                            : SearchDropDown(
                                hintText: 'Select District',
                                items: controller.districtList.isEmpty
                                    ? ['No Data Found']
                                    : controller.districtList
                                        .map((item) => item.name)
                                        .toList(),
                                onChange: (newValue) {
                                  controller.selectedDistrict.value = newValue!;
                                  final District district = controller
                                      .districtList
                                      .where((e) => e.name == newValue)
                                      .first;

                                  log(district.toString());
                                  controller.selectedDistrictId.value =
                                      district.id ?? 0;
                                  log('Selected District ID is =============>  ${controller.selectedDistrictId.value}');

                                  // /// This code is for call the next drop down
                                  controller.isThanaLoading.value = true;
                                  controller.selectedDivision.value = '';
                                  controller.selectedThana.value = '';
                                  controller.selectedUnion.value = '';

                                  controller
                                      .fetchThana(
                                          controller.selectedDistrictId.value)
                                      .then((_) {
                                    controller.isThanaLoading.value = false;
                                  });
                                },
                                value:
                                    controller.selectedDistrict.value.isNotEmpty
                                        ? controller.selectedDistrict.value
                                        : null,
                              ),
                      )),
                  SizedBox(height: 15.h),

                  SmallText(
                      text: 'Select Thana', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),
                  Obx(() => Container(
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
                        child: controller.isThanaLoading.value
                            ? const SizedBox.shrink()
                            : SearchDropDown(
                                hintText: 'Select Thana',
                                items: controller.thanaList.isEmpty
                                    ? ['No Data Found']
                                    : controller.thanaList
                                        .map((item) => item.name)
                                        .toList(),
                                onChange: (newValue) {
                                  controller.selectedThana.value = newValue!;
                                  final Thana thana = controller.thanaList
                                      .where((e) => e.name == newValue)
                                      .first;
                                  controller.selectedThanaId.value =
                                      thana.id ?? 0;
                                  debugPrint(
                                      'Selected Thana ID is =============>  ${controller.selectedThanaId.value}');

                                  /// This code is for call the next drop down
                                  controller.isUnionLoading.value = true;
                                  controller.selectedUnion.value = '';
                                  controller
                                      .fetchUnion(
                                          controller.selectedThanaId.value)
                                      .then((_) {
                                    controller.isUnionLoading.value = false;
                                  });
                                },
                                value: controller.selectedThana.value.isNotEmpty
                                    ? controller.selectedThana.value
                                    : null,
                              ),
                      )),
                  SizedBox(height: 15.h),
                  SmallText(
                      text: 'Select Union', textColor: Colors.grey.shade700),
                  SizedBox(height: 10.h),

                  Obx(() => Container(
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
                        child: controller.isUnionLoading.value
                            ? const SizedBox.shrink()
                            : SearchDropDown(
                                hintText: 'Select Union',
                                items: controller.unionList.isEmpty
                                    ? ['No Data Found']
                                    : controller.unionList
                                        .map((item) => item.name)
                                        .toList(),
                                onChange: (newValue) {
                                  controller.selectedUnion.value = newValue!;
                                  final Union union = controller.unionList
                                      .where((e) => e.name == newValue)
                                      .first;
                                  controller.selectedUnionId.value =
                                      union.id ?? 0;
                                  // print(
                                  //     'Selected Union ID is =============>  ${controller.selectedUnionId?.value}');

                                  /// This code is for call the next drop down
                                  // controller.isUnionLoading.value = true;
                                  // controller.selectedUnion.value = '';
                                  // controller
                                  //     .fetchThana(
                                  //         controller.selectedThanaId.value)
                                  //     .then((_) {
                                  //   controller.isUnionLoading.value = false;
                                  // });
                                },
                                value: controller.selectedUnion.value.isNotEmpty
                                    ? controller.selectedUnion.value
                                    : null,
                              ),
                      )),
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