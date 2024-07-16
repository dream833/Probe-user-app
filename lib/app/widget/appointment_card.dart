import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/appointments/view/appoinment_detail_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/show_status_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/models/appointment_model.dart';

import 'package:uddipan/utils/snippet.dart';

class AppointmentCard extends StatelessWidget {
  final AppoinmentModel appointment;
  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    String startTimeFormatted =
        formatTime(appointment.availability?.startTime ?? '');
    String endTimeFormatted =
        formatTime(appointment.availability?.endTime ?? '');

    return GestureDetector(
      onTap: () {
        Get.to(() => AppointmentDetailView(appointment: appointment));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    DisplayImageWidget(
                      color: appPrimaryColor,
                      height: 54,
                      width: 54,
                      child: const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SmallText(
                                text:
                                    '${appointment.doctorModel?.firstName ?? ''} ${appointment.doctorModel?.lastName ?? ''}'),
                            const SizedBox(width: 5),
                            SmallText(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                text:
                                    """( $startTimeFormatted to $endTimeFormatted )"""),
                          ],
                        ),

                        // Row(
                        //   children: [

                        //     SmallText(
                        //         fontSize: 12,
                        //         textColor: Colors.black,
                        //         text: "Age: ${appointment.doctorModel?.age ?? ''}"),
                        //     const SizedBox(width: 15),
                        //     SmallText(
                        //         fontSize: 12,
                        //         textColor: Colors.black,
                        //         text: "Gender: ${appointment.doctorModel. ?? ''}"),
                        //     const SizedBox(width: 15),
                        //     SmallText(
                        //         fontSize: 12,
                        //         textColor: Colors.black,
                        //         text:
                        //             "SerialNo: ${appointment.serialNo ?? ''}"),
                        //   ],
                        // )
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ShowStatusWidget(
                      color: appointment.availability?.type == "online"
                          ? const Color(0xff06B198)
                          : Colors.grey,
                      text: appointment.availability?.type == "online"
                          ? 'Online'
                          : 'Offline'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
