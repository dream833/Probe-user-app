import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/image_contant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/appointment_model.dart';

class PatientDetailWidget extends StatelessWidget {
  final AppoinmentModel appointment;
  const PatientDetailWidget({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallText(
            text: 'Patient Details',
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  DisplayImageWidget(
                      color: Colors.grey.shade400,
                      height: 52,
                      width: 52,
                      child: Image.asset(AppImage.avatar)),
                  const SizedBox(width: 15),
                  Text(
                    appointment.patientName ?? '',
                    style: CustomFont.regularTextPoppins.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  appointment.isForFamilyMember
                      ? Text(
                          'Family Member',
                          style: CustomFont.regularTextPoppins.copyWith(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w900),
                        )
                      : const SizedBox.shrink()
                ],
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
                          'Age',
                          style: CustomFont.regularTextPoppins.copyWith(
                              color: appColorPrimary,
                              fontSize: 13,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${appointment.age.toString()} years',
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
                          'Type',
                          style: CustomFont.regularTextPoppins.copyWith(
                              color: appColorPrimary,
                              fontSize: 13,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'New Patient',
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
              const SizedBox(height: 10),
            ]),
          ),
        ),
      ],
    );
  }
}
