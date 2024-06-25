import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/appointments/controller/appointment_controller.dart';
import 'package:uddipan/app/widget/appointment_card.dart';
import 'package:uddipan/utils/snippet.dart';

class UpcomingAppointmentWidget extends StatelessWidget {
  const UpcomingAppointmentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentController>();

    return FutureBuilder(
        future: controller.upcommingAppointmentsList(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return shimmerListEffect(itemBorderRadius: 16, itemCount: 10);
          }
          if (controller.upcommingAppointmentList.isEmpty) {
            return Container(
              alignment: Alignment.center,
              width: Get.width,
              height: Get.height / 1.2,
              child: const Text(
                "No Upcoming Appointment Found ",
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: controller.upcommingAppointmentList.length,
            itemBuilder: (context, index) {
              final appointment = controller.upcommingAppointmentList[index];
              return AppointmentCard(appointment: appointment!);
            },
          );
        });
  }
}
