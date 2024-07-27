import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';

import 'package:uddipan/utils/snippet.dart';

class PreviousBookedTest extends StatelessWidget {
  const PreviousBookedTest({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EShopController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              FutureBuilder(
                  future: delayDuration(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return shimmerListEffect(
                          itemBorderRadius: 16, itemCount: 10);
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemCount: controller.bookTestLab.length,
                        itemBuilder: (context, index) {
                          //LabTestModel labTest = controller.bookTestLab[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
                                            height: 58,
                                            width: 58,
                                            child: const Center(
                                              child: Icon(
                                                FontAwesomeIcons
                                                    .vialCircleCheck,
                                                color: Colors.white,
                                              ),
                                            )),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SmallText(
                                                text: "labTest.testName",
                                                textColor: Colors.grey.shade700,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              const SizedBox(height: 4),
                                              const Text(
                                                "labTest.additionalDetails",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating: 3,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 15,
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 0.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const SmallText(
                                                      fontSize: 12,
                                                      text: "(4.0)"),
                                                  const SizedBox(width: 5),
                                                ],
                                              ),
                                              const Row(
                                                children: [
                                                  SmallText(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    text:
                                                        "BDT {labTest.testCost.toString()}",
                                                  ),
                                                ],
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
                          );
                        },
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
