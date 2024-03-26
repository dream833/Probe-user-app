import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/prescription/controller/prescription_controller.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/image_contant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/utils/snippet.dart';

class PrescriptionListView extends StatelessWidget {
  final int index;
  const PrescriptionListView({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrescriptionController());

    onRefresh() async {
      await Future.delayed(const Duration(milliseconds: 1000), () {
        return const CircularProgressIndicator();
      });
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                      prefixIcon: Icons.search, hintText: 'Search Doctors'),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: boxShadow,
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.filter_alt_outlined,
                    color: appPrimaryColor,
                    size: 25,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder(
                future: delayDuration(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmerListEffect(
                        itemBorderRadius: 16, itemCount: 10);
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      itemCount: controller.prescriptions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Get.to(() => const PrescriptionView());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: boxShadow,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      DisplayImageWidget(
                                          color: Colors.white,
                                          height: 60,
                                          width: 60,
                                          child: Image.asset(AppImage.avatar)),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                controller.prescriptions[index]
                                                        .doctorName ??
                                                    '',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                '(10:00AM : 11:00AM)',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            controller.prescriptions[index]
                                                    .patientGender ??
                                                '',
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            controller.prescriptions[index]
                                                    .patientContactInformation ??
                                                '',
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}
