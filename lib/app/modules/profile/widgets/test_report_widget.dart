import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/utils/snippet.dart';

class TestReportWidget extends StatelessWidget {
  const TestReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EShopController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 40),
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
                      itemCount: controller.labTests.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
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
                                        const DisplayImageWidget(
                                            color: Colors.white,
                                            height: 60,
                                            width: 60,
                                            child:
                                                Icon(FontAwesomeIcons.filePdf)),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    controller.labTests[index]
                                                        .testName,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '(10:00AM : 11:00AM)',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                controller.labTests[index]
                                                    .additionalDetails,
                                                style: GoogleFonts.raleway(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
