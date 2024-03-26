import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uddipan/app/modules/doctor/controller/doctor_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/availability_model.dart';
import 'package:uddipan/utils/snippet.dart';

class SlotSection extends StatefulWidget {
  final String doctorId;
  const SlotSection({super.key, required this.doctorId});

  @override
  State<SlotSection> createState() => _SlotSectionState();
}

class _SlotSectionState extends State<SlotSection> {
  late DoctorController doctorController;

  @override
  void initState() {
    doctorController = Get.put(DoctorController());
    doctorController.getDoctorSlotsAccordingToSelectedDate(
      doctorId: widget.doctorId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Obx(
              () => Text(
                DateFormat('MMMM')
                    .format(doctorController.selectedSlotDate.value),
                style: CustomFont.regularTextPoppins
                    .copyWith(color: Colors.black, fontSize: 16),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 75,
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: appColorPrimary,
                onDateChange: (DateTime? pickedDate) {
                  if (pickedDate != null) {
                    doctorController.pickSlotDate(
                        date: pickedDate, doctorId: widget.doctorId);
                  }
                },
              ),
            ),
            SizedBox(height: 15.h),
           
            Obx(
              () {
                if (doctorController.isDoctorSlotLoading.value == true) {
                  return shimmerListEffect();
                }
                return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    itemCount: doctorController.availabilityList.length,
                    itemBuilder: (context, index) {
                      AvailabilityModel? availabilityModel =
                          doctorController.availabilityList[index];

                      String formatStartTime =
                          formatTime(availabilityModel!.startTime!);
                      String formatEndTime =
                          formatTime(availabilityModel.endTime!);

                      return GestureDetector(
                        onTap: () {
                          doctorController.selectAvailability(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  offset: Offset(-1, 1),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SmallText(
                                            text: capitalizeFirstLetter(
                                                availabilityModel.day),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            textColor: Colors.blueGrey,
                                          ),
                                          const SizedBox(width: 4),
                                          SmallText(
                                            text:
                                                availabilityModel.status == '1'
                                                    ? '(Online)'
                                                    : '(Offline)',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            textColor: Colors.blueGrey,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 7),
                                      SmallText(
                                        text:
                                            '$formatStartTime : $formatEndTime',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        textColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Obx(() => Icon(
                                        Icons.check,
                                        color: doctorController
                                                    .selectedIndex.value ==
                                                index
                                            ? appColorPrimary
                                            : Colors.transparent,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
// CustomTextField(
            //     readOnly: true,
            //     onTap: () async {
            //       DateTime? pickedDate = await showDatePicker(
            //           initialDatePickerMode: DatePickerMode.day,
            //           context: context, //context of current state
            //           initialDate: DateTime.now(),
            //           firstDate: DateTime
            //               .now(), //DateTime.now() - not to allow to choose before today.
            //           lastDate: DateTime(2101));
            //       if (pickedDate != null) {
            //        
            //         String formattedDate =
            //             DateFormat('d MMM yyyy').format(pickedDate);
            //         controller.dateController.text = formattedDate;
            //       }
            //     },
            //     hintText: 'Select Date',
            //     prefixIcon: Icons.calendar_month,
            //     inputType: TextInputType.datetime,
            //     controller: controller.dateController),


*/ 