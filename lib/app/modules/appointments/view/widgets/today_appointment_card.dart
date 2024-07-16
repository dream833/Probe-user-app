import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/appointments/controller/appointment_controller.dart';
import 'package:uddipan/app/widget/appointment_card.dart';
import 'package:uddipan/utils/snippet.dart';

class TodayAppointmentCard extends StatelessWidget {
  const TodayAppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentController());

    return FutureBuilder(
        future: controller.getCurrentDateDayAppointments(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return shimmerListEffect(itemBorderRadius: 16, itemCount: 10);
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (controller.todayAppointmentList.isEmpty) {
            return Container(
              alignment: Alignment.center,
              width: Get.width,
              height: Get.height / 1.2,
              child: const Text(
                "No Today's Appointment Found ",
              ),
            );
          }

          debugPrint(snapshot.error.toString());

          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: controller.todayAppointmentList.length,
            itemBuilder: (context, index) {
              final appointment = controller.todayAppointmentList[index];
              return AppointmentCard(appointment: appointment!);
            },
          );
        });
  }
}
