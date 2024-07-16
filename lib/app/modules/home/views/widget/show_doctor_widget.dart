import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/constants/image_contant.dart';
import 'package:uddipan/models/doctor_model.dart';

import '../../../doctor/view/doctor_details_view.dart';

class ShowDoctorWiget extends StatelessWidget {
  final DoctorModel? doctorModel;
  final int index;
  const ShowDoctorWiget({super.key, this.doctorModel, required this.index});

  @override
  Widget build(BuildContext context) {
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${doctorModel?.firstName} ${doctorModel?.lastName}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Experience',
                      //       style: GoogleFonts.poppins(
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: 12,
                      //           color: Colors.grey.shade700),
                      //     ),
                      //     const SizedBox(width: 5),
                      //     Text(
                      //       '7+ years',
                      //       style: CustomFont.regularTextRaleway.copyWith(
                      //           fontSize: 11, fontWeight: FontWeight.w500),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 5),
                      // Row(
                      //   children: [
                      //     RatingBar.builder(
                      //       unratedColor: Colors.grey.shade300,
                      //       initialRating: doctorModel?.averageRating ?? 0.0,
                      //       minRating: 1,
                      //       direction: Axis.horizontal,
                      //       allowHalfRating: true,
                      //       itemCount: 5,
                      //       itemSize: 15,
                      //       itemPadding:
                      //           const EdgeInsets.symmetric(horizontal: 0.0),
                      //       itemBuilder: (context, _) => const Icon(
                      //         Icons.star,
                      //         size: 30,
                      //         color: Colors.amber,
                      //       ),
                      //       onRatingUpdate: (rating) {},
                      //     ),
                      //     const SizedBox(width: 5),
                      //     Text(
                      //       "(${doctorModel?.totalRatingLength}) ",
                      //       style: CustomFont.regularTextRaleway.copyWith(
                      //           fontSize: 13, fontWeight: FontWeight.w500),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
