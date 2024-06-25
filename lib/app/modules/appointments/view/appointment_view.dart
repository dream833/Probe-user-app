import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/appointments/view/widgets/previous_appointment_widget.dart';
import 'package:uddipan/app/modules/appointments/view/widgets/today_appointment_card.dart';
import 'package:uddipan/app/modules/appointments/view/widgets/upcomming_appointment_widget.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/constants/color_constant.dart';

import '../controller/appointment_controller.dart';

class AppointmentView extends GetView<AppointmentController> {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentController());

    onRefresh() async {
      await Future.delayed(const Duration(milliseconds: 1000), () {
        return const CircularProgressIndicator();
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        backgroundColor: Colors.white,
        title: SmallText(
            text: 'Appointment',
            fontSize: 14.r,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                width: Get.width * 1,
                height: Get.height * 0.05,
                child: Center(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.listOfAppointment.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.setSelectedIndex(index);
                        },
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              padding: EdgeInsets.only(left: 12.w, right: 12.w),
                              decoration: BoxDecoration(
                                color: index == controller.selectedIndex.value
                                    ? Colors.white
                                    : Colors.white,
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.white, // Left border color
                                    width:
                                        index == 0 ? 1.0 : 0.5, // Border width
                                  ),
                                  right: BorderSide(
                                    color: Colors.white, // Right border color
                                    width:
                                        index == 2 ? 1.0 : 0.5, // Border width
                                  ),
                                  top: const BorderSide(
                                    color: Colors.white, // Top border color
                                    width: 1.0, // Border width
                                  ),
                                  bottom: BorderSide(
                                    color: index ==
                                            controller.selectedIndex.value
                                        ? appPrimaryColor
                                        : Colors.blue, // Bottom border color
                                    width: 2, // Border width
                                  ),
                                ),
                              ),
                              child: Center(
                                child: SmallText(
                                  text: controller.listOfAppointment[index],
                                  textColor:
                                      index == controller.selectedIndex.value
                                          ? appPrimaryColor
                                          : Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Obx(
            () => controller.selectedIndex.value == 0
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: TodayAppointmentCard(),
                  )
                : controller.selectedIndex.value == 1
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: UpcomingAppointmentWidget(),
                      )
                    : const PreviousAppointmentWidget(),
          ),
        ]),
      ),
    );
  }
}
