import 'package:flutter/material.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/models/review_model.dart';
import 'package:uddipan/models/user_model.dart';

import '../../../../../constants/image_contant.dart';

class ReviewWidget extends StatelessWidget {
  final DoctorModel? doctorModel;
  final ReviewModel? reviewModel;
  final UserModel? userModel;
  const ReviewWidget(
      {super.key, this.doctorModel, this.reviewModel, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 0),
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  DisplayImageWidget(
                      color: Colors.white,
                      height: 58,
                      width: 58,
                      child: Image.asset(AppImage.avatar)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: userModel?.name ?? '',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 10),
                        SmallText(
                          text: reviewModel?.review ?? '',
                          maxLine: 5,
                          fontSize: 13,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
