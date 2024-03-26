import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/health/controller/health_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/app/widget/search_dropdown.dart';
import 'package:uddipan/models/member_model.dart';
import 'package:uddipan/utils/snippet.dart';

class AddHealthView extends StatelessWidget {
  const AddHealthView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HealthController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const SmallText(
            fontSize: 16,
            text: 'Add Heath Profile ',
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              SmallText(text: 'Select Member', textColor: Colors.grey.shade700),
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
                    child: controller.isMemberListLoading.value
                        ? const SizedBox.shrink()
                        : SearchDropDown(
                            hintText: 'Select Member',
                            items: controller.memberList.isEmpty
                                ? ['No Data Found']
                                : controller.memberList
                                    .map((item) => item?.name ?? '')
                                    .toList(),
                            onChange: (newValue) {
                              controller.selectedMember.value = newValue!;
                              MemberModel? memberModel = controller.memberList
                                  .where((e) => e!.name == newValue)
                                  .first;
                              controller.selectedMemberId.value =
                                  memberModel!.id;
                            },
                            value: controller.selectedMember.value.isNotEmpty
                                ? controller.selectedMember.value
                                : null,
                          ),
                  )),
              SizedBox(height: 20.h),
              SmallText(text: 'Height', textColor: Colors.grey.shade700),
              SizedBox(height: 10.h),
              CustomTextField(
                hintText: 'Height',
                controller: controller.heightController,
                prefixIcon: FontAwesomeIcons.childReaching,
                inputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
              SizedBox(height: 20.h),
              SmallText(text: 'Weight', textColor: Colors.grey.shade700),
              SizedBox(height: 10.h),
              CustomTextField(
                inputType: TextInputType.number,
                hintText: 'Weight',
                controller: controller.weightController,
                prefixIcon: FontAwesomeIcons.weightScale,
                prefixIconSize: 19,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
              SizedBox(height: 20.h),
              SmallText(
                  text: 'Blood Pressure', textColor: Colors.grey.shade700),
              SizedBox(height: 10.h),
              CustomTextField(
                inputType: TextInputType.number,
                hintText: 'Blood Pressure',
                controller: controller.bloodPressureController,
                prefixIcon: FontAwesomeIcons.stethoscope,
                prefixIconSize: 19,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
              SizedBox(height: 20.h),
              SmallText(
                text: 'Blood Group',
                textColor: Colors.grey.shade700,
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                hintText: 'Blood Group',
                prefixIcon: FontAwesomeIcons.droplet,
                prefixIconSize: 19,
                controller: controller.bloodGroupController,
               
              ),
              SizedBox(height: 20.h),
              SmallText(text: 'Sugar', textColor: Colors.grey.shade700),
              SizedBox(height: 10.h),
              CustomTextField(
                inputType: TextInputType.number,
                hintText: 'Sugar',
                prefixIcon: FontAwesomeIcons.thermometer,
                prefixIconSize: 19,
                controller: controller.sugarController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
              SizedBox(height: 20.h),
              SmallText(text: 'Record Date', textColor: Colors.grey.shade700),
              SizedBox(height: 10.h),
              CustomTextField(
                readOnly: true,
                hintText: 'Record Date',
                prefixIcon: FontAwesomeIcons.calendarPlus,
                controller: controller.recordDateController,
                prefixIconSize: 19,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, //context of current state
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate = formatDate(pickedDate);
                    // String formattedDate =
                    //     DateFormat('d MMM yyyy').format(pickedDate);
                    controller.recordDateController.text = formattedDate;
                  }
                },
              ),
              SizedBox(height: 20.h),
              LoaderButton(
                  btnText: 'Add Health',
                  onTap: () async {
                    await controller.addFamilyMemberHealth(context);
                  }),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
