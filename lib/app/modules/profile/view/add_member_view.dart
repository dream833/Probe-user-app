
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/profile/controllers/member_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/app/widget/loader_button.dart';

class AddMemberView extends StatelessWidget {
  const AddMemberView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MemberController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const SmallText(
            text: 'Add Member',
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
              SmallText(text: 'Relation', textColor: Colors.grey.shade700),
              SizedBox(height: 10.h),
              CustomTextField(
                  hintText: 'Relation',
                  controller: controller.relationShipController.value,
                  prefixIcon: Icons.person,
                  prefixIconSize: 20),
              SizedBox(height: 15.h),
              SmallText(text: 'Age', textColor: Colors.grey.shade700),
              SizedBox(height: 10.h),
              CustomTextField(
                  hintText: 'Age',
                  controller: controller.ageController.value,
                  prefixIcon: FontAwesomeIcons.child,
                  prefixIconSize: 20),
              SizedBox(height: 15.h),
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
                  btnText: 'Add Member',
                  onTap: () async {
                    await controller.addMember(context);
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
