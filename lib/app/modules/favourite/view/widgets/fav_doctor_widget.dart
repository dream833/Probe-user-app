
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/doctor/view/doctor_details_view.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/image_contant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/doctor_model.dart';

import '../../../doctor/controller/doctor_controller.dart';

class FavDoctorWidget extends StatelessWidget {
  final DoctorModel? doctorModel;
  final int index;
  const FavDoctorWidget({super.key, this.doctorModel, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorController());
    return GestureDetector(
      onTap: () {
        Get.to(() => DoctorDetailView(doctorModel: doctorModel));
      },
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: Image.asset(AppImage.avatar),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${doctorModel?.firstName} ',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              controller.specialization[index],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey.shade700),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              controller.experience[index],
                              style: CustomFont.regularTextRaleway.copyWith(
                                  fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            RatingBar.builder(
                              unratedColor: Colors.grey.shade300,
                              initialRating: controller.ratings[index],
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 15,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                size: 30,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "(140+) ",
                              style: CustomFont.regularTextRaleway.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    return GestureDetector(
                      onTap: () {
                        if (controller.favouriteDoctors
                            .any((p0) => p0?.id == doctorModel?.id)) {
                          controller.removeFavoriteDoctor(
                              doctor: doctorModel, context: context);
                        } else {
                          controller.saveFavoriteDoctor(
                              doctor: doctorModel, context: context);
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: appColorPrimary,
                        ),
                        child: Icon(
                          controller.favouriteDoctors
                                  .any((p0) => p0?.id == doctorModel?.id)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
