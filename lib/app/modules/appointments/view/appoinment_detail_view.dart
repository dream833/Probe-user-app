import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/appointments/controller/appointment_controller.dart';
import 'package:uddipan/app/modules/appointments/view/widgets/doctor_detail_widget.dart';
import 'package:uddipan/app/modules/appointments/view/widgets/patient_detail_widget.dart';
import 'package:uddipan/app/modules/transactions/view/transaction_detail_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/appointment_model.dart';
import 'package:uddipan/utils/snippet.dart';

import '../../video/video_call_view.dart';

class AppointmentDetailView extends StatelessWidget {
  final AppoinmentModel appointment;
  const AppointmentDetailView({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentController());

    String startTimeFormatted =
        formatTime(appointment.availability?.startTime ?? '');
    String endTimeFormatted =
        formatTime(appointment.availability?.endTime ?? '');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                controller.getAppointmentVideoId(appointmentId: appointment.id);
                print('${controller.getVideoId.value} video id');
                if (controller.getVideoId.value.isNotEmpty) {
                  Get.to(() => VideoCallView(
                      callId: controller.getVideoId.value,
                      userId: appointment.id.toString(),
                      userName: appointment.patientName.toString()));
                }
              },
              icon: const Icon(Icons.video_call))
        ],
        title: SmallText(
            text: 'Appointment Detail',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              DoctorDetailWidget(appointment: appointment),
              SizedBox(height: 15.h),
              PatientDetailWidget(appointment: appointment),
              SizedBox(height: 15.h),
              SmallText(
                  text: 'Appointment Details',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.grey.shade700),
              SizedBox(height: 15.h),

              Container(
                width: double.infinity,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Info',
                            style: CustomFont.regularTextPoppins.copyWith(
                                color: appColorPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                          Icon(
                            Icons.remove_red_eye,
                            color: appPrimaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => TransactionDetailView(
                              transaction: appointment.transationModel!));
                        },
                        child: Row(
                          children: [
                            DisplayImageWidget(
                                color: Colors.grey.shade400,
                                height: 52,
                                width: 52,
                                child: const Icon(
                                  Icons.arrow_outward,
                                  color: Colors.white,
                                )),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${appointment.doctorModel?.firstName} ${appointment.doctorModel?.lastName} ',
                                  style: CustomFont.mediumTextRaleway.copyWith(
                                      fontSize: 16,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "BDT ${appointment.payment}",
                                  style: CustomFont.regularTextPoppins.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  formatDate(appointment.createdAt),
                                  style: CustomFont.regularTextPoppins.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status',
                                  style: CustomFont.regularTextPoppins.copyWith(
                                      color: appColorPrimary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Online',
                                  style: CustomFont.regularTextPoppins.copyWith(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Day',
                                  style: CustomFont.regularTextPoppins.copyWith(
                                      color: appColorPrimary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Monday',
                                  style: CustomFont.regularTextPoppins.copyWith(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Slot Time',
                                  style: CustomFont.regularTextPoppins.copyWith(
                                      color: appColorPrimary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '$startTimeFormatted : $endTimeFormatted ',
                                  style: CustomFont.regularTextPoppins.copyWith(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              const SizedBox(height: 20),

              // const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

/*

                    
                         appointment.availability?.type == 'online'
                  ? LoaderButton(
                      color: const Color(0xFF06B198),
                      btnText: 'Join Meeting',
                      onTap: () async {
                        await controller.getAppointmentVideoId(
                            appointmentId: appointment.id.toString());
                        print('${controller.getVideoId.value} video id');
                        if (controller.getVideoId.value.isNotEmpty) {
                          Get.to(() => VideoCallView(
                              callId: controller.getVideoId.value,
                              userId: (Random().nextInt(100) + 1).toString(),
                              userName: getbox.read(userEmail)));
                        }
                      })
                  : Container(),
*/
