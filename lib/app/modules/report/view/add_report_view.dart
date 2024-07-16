import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/report/controller/report_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/utils/custom_message.dart';
import 'package:uddipan/utils/snippet.dart';

class AddReportView extends StatelessWidget {
  const AddReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const SmallText(
            fontSize: 16,
            text: 'Add Report ',
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
              SmallText(text: 'Report Name', textColor: Colors.grey.shade700),
              SizedBox(height: 10.h),
              CustomTextField(
                hintText: 'Name',
                controller: controller.nameController,
                prefixIcon: Icons.abc,
                prefixIconSize: 29,
                inputType: TextInputType.multiline,
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () async {
                  try {
                    PickedPDF? model = await pickPDFFile();
                    if (model != null) {
                      controller.pickPDF.value = model;
                    }
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    CustomMessage.errorMessage('Please Select PDF');
                  }
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                      child: Obx(() => Text(
                            controller.pickPDF.value == null
                                ? 'Select Report'
                                : controller.pickPDF.value!.fileName,
                            style: CustomFont.mediumTextRaleway
                                .copyWith(color: Colors.white),
                          ))),
                ),
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
                  btnText: 'Add Report',
                  onTap: () async {
                    await controller.addReport(context);
                  }),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
