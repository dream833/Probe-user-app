import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/appointments/controller/appointment_controller.dart';
import 'package:uddipan/app/widget/appointment_card.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/utils/custom_message.dart';
import 'package:uddipan/utils/snippet.dart';

class PreviousAppointmentWidget extends StatelessWidget {
  const PreviousAppointmentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentController>();

    controller.getDateWiseAppointmentList();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h,
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(() {
                  String formattedDate =
                      controller.selectedDateTime.value != null
                          ? formatDate(controller.selectedDateTime.value)
                          : '';
                  controller.startDateController.text = formattedDate;
                  return InkWell(
                    onTap: () {
                      _selectStartDate(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(globalBorderRadius),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            offset: Offset(-1, 1),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.date_range,
                              color: Colors.black87,
                              size: 16,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              controller.startDateController.text.isEmpty
                                  ? 'Start Date'
                                  : controller.startDateController.text,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Obx(() {
                  String formattedDate = controller.selectedEndDateTime.value !=
                          null
                      ? formatDate(controller.selectedEndDateTime.value)
                      : ''; // Check if date is selected, else set empty string
                  controller.endDateController.text =
                      formattedDate; // Update the text when the date changes.
                  return InkWell(
                    onTap: () {
                      _selectEndDate(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(globalBorderRadius),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            offset: Offset(-1, 1),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.date_range,
                              color: Colors.black87,
                              size: 16,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              controller.endDateController.text.isEmpty
                                  ? 'End Date'
                                  : controller.endDateController.text,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  if (controller.startDateController.value.text.isEmpty) {
                    // Get.snackbar("Warning", "Start Date Required");
                    CustomMessage.showSnackBar("Date Field Required",
                        backgroundColor: Colors.red.withOpacity(0.7));
                  } else if (controller.endDateController.value.text.isEmpty) {
                    // Get.snackbar("Warning", "Start Date Required");
                  } else {
                    // Check if startDate is greater than endDate, swap them if needed
                    if (controller.selectedDateTime.value!
                        .isAfter(controller.selectedEndDateTime.value!)) {
                      CustomMessage.showSnackBar(
                          "Start Date is always before or equal to EndDate ",
                          backgroundColor: Colors.red.withOpacity(0.7));
                    } else {
                      controller.getDateWiseAppointmentList(
                        startDate: controller.selectedDateTime.value,
                        endDate: controller.selectedEndDateTime.value,
                      );
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(24),
                    // shape: BoxShape.circle,
                    color: appPrimaryColor,
                  ),
                  height: 38.h,
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {
                  controller.clearDate();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.grey.shade300,
                  ),
                  height: 38.h,
                  child: const Icon(
                    Icons.clear_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Obx(
            () => controller.isDateWiseAppointmentLoading.value
                ? shimmerListEffect(itemBorderRadius: 16, itemCount: 10)
                : controller.datewiseAppointmentList.isEmpty
                    ? const Text("Empty No Data Found")
                    : ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.datewiseAppointmentList.length,
                      itemBuilder: (context, index) {
                        final appointment =
                            controller.datewiseAppointmentList[index];
                        return AppointmentCard(
                          appointment: appointment!,
                        );
                      },
                    ),
          ),

          // const AppointmentCard(),
        ],
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final controller = Get.find<AppointmentController>();
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 2));
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: controller.selectedDateTime.value ?? yesterday,
      firstDate: DateTime(2022),
      lastDate: DateTime.now().subtract(const Duration(days: 2)),
    );

    if (selectedDate != null) {
      controller.updateSelectedDateTime(selectedDate);
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final controller = Get.find<AppointmentController>();
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    // Get.snackbar("MM", yesterday.toString());

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: controller.selectedEndDateTime.value ?? yesterday,
      firstDate: DateTime(2022), // Set firstDate to a date far in the past
      lastDate: DateTime.now()
          .subtract(const Duration(days: 1)), // Set lastDate to be yesterday
    );

    if (selectedDate != null) {
      controller.updateEndDateTime(selectedDate);
    }
  }
}
