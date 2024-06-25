import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/health/controller/health_controller.dart';
import 'package:uddipan/app/modules/health/view/add_health_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/utils/snippet.dart';

class HealthView extends StatelessWidget {
  const HealthView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HealthController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const SmallText(
            text: 'Health Profile ',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              FutureBuilder(
                  future: controller.getMemberHealthCareList(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return shimmerListEffect();
                    }
                    if (controller.healthCareList.isEmpty) {
                      return Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        height: Get.height / 1.2,
                        child: const Text(
                          "No Health Profile Found ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: controller.healthCareList.length,
                      itemBuilder: (_, index) {
                        final model = controller.healthCareList[index]!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: boxShadow,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Row(
                                  children: [
                                    DisplayImageWidget(
                                      color: model.member.gender == 'Male'
                                          ? appColorBlue
                                          : appColorPrimary,
                                      height: 60,
                                      width: 60,
                                      child: Icon(
                                        model.member.gender == 'Male'
                                            ? Icons.person
                                            : FontAwesomeIcons.female,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                model.member.name ?? '',
                                                style: CustomFont
                                                    .regularTextPoppins,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                '(${model.member.relationship})',
                                                style: CustomFont
                                                    .regularTextPoppins
                                                    .copyWith(fontSize: 12),
                                              ),
                                              const Spacer(),
                                              Text(
                                                'B.P: ${model.bloodPressure} ',
                                                style: CustomFont
                                                    .regularTextPoppins
                                                    .copyWith(fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            color: Colors.grey.shade400,
                                            height: 1,
                                            width: double.infinity,
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'Height: ${model.height} ',
                                                style: CustomFont
                                                    .regularTextPoppins
                                                    .copyWith(fontSize: 13),
                                              ),
                                              Text(
                                                'Weight: ${model.weight} ',
                                                style: CustomFont
                                                    .regularTextPoppins
                                                    .copyWith(fontSize: 12),
                                              ),
                                              Text(
                                                'Sugar: ${model.sugar} ',
                                                style: CustomFont
                                                    .regularTextPoppins
                                                    .copyWith(fontSize: 12),
                                              ),
                                              Text(
                                                'Blood: ${model.bloodGroup} ',
                                                style: CustomFont
                                                    .regularTextPoppins
                                                    .copyWith(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ]),
                            ),
                          ),
                        );
                      },
                    );
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Get.to(() => const AddHealthView());
        },
        backgroundColor: appColorBlue,
        child: const Icon(FontAwesomeIcons.plus, color: Colors.white),
      ),
    );
  }
}
