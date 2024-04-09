import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/doctor/view/doctor_details_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/custom_rating_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/image_contant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/appointment_model.dart';

import '../../../../widget/display_image_widget.dart';

class DoctorDetailWidget extends StatelessWidget {
  final AppoinmentModel appointment;
  const DoctorDetailWidget({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallText(
            text: 'Doctor Details',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
        SizedBox(height: 15.h),
        GestureDetector(
          onTap: () {
            Get.to(
                () => DoctorDetailView(doctorModel: appointment.doctorModel));
          },
          child: Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DisplayImageWidget(
                          color: Colors.grey.shade400,
                          height: 52,
                          width: 52,
                          child: Image.asset(AppImage.avatar)),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${appointment.doctorModel?.firstName} ${appointment.doctorModel?.lastName}',
                            style: CustomFont.regularTextPoppins.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              CustomRatingWidget(
                                  averageRating:
                                      appointment.doctorModel?.averageRating ??
                                          0.0),
                              const SizedBox(width: 5),
                              Text(
                                "(${appointment.doctorModel?.totalRatingLength} reviews)",
                                style: CustomFont.regularTextPoppins.copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       'Experience',
                        //       style: CustomFont.regularTextPoppins.copyWith(
                        //           color: appColorPrimary,
                        //           fontSize: 13,
                        //           fontWeight: FontWeight.w800),
                        //     ),
                        //     const SizedBox(height: 10),
                        //     Text(
                        //       '10 years',
                        //       style: CustomFont.regularTextPoppins.copyWith(
                        //           color: Colors.black,
                        //           fontSize: 13,
                        //           fontWeight: FontWeight.w900),
                        //     )
                        //   ],
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: CustomFont.regularTextPoppins.copyWith(
                                  color: appColorPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${appointment.gender} ',
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
                              'Speciality',
                              style: CustomFont.regularTextPoppins.copyWith(
                                  color: appColorPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              appointment.doctorModel!.specialist.toString(),
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
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About ',
                        style: CustomFont.regularTextPoppins.copyWith(
                            color: appColorPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        appointment.doctorModel?.biography ?? '--',
                        textAlign: TextAlign.justify,
                        style: CustomFont.regularTextPoppins.copyWith(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
