import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/widget/fast_cached_network_img.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/hospital_model.dart';

class FavHospitalWidget extends StatelessWidget {
  final Hospital hospitalModel;
  const FavHospitalWidget({super.key, required this.hospitalModel});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                FastCachedImgWidget(
                    height: 100,
                    width: 70,
                    radius: 16,
                    url: hospitalModel.imageUrl),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        hospitalModel.name,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "Bedroom (${hospitalModel.bedCount.toString()}+)",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey.shade700),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          RatingBar.builder(
                            unratedColor: Colors.grey.shade300,
                            initialRating: 4,
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
                            "(20+) ",
                            style: CustomFont.regularTextRaleway.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                       const SizedBox(width: 5),
                      Text(hospitalModel.address),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: appPrimaryColor,
                  ),
                  child: const Icon(
                    Icons.favorite_outline_sharp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
