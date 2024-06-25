import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/NewTestPage/views/new_test_page_view.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/cart_counter.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/models/lab_test_models.dart';
import 'package:uddipan/utils/snippet.dart';

import '../../../../api/dio_get.dart';

class LabTestView extends StatelessWidget {
  LabTestView({super.key});

  // final LabTestModel? model;
  var testmodel = LabTestModels();
  var tests = LabTestModels().obs;

  Future getTest() async {
    try {
      var response = await dioGet("/booked-diagnostic-test");
      Map<String, dynamic> data = response.data;
      tests(LabTestModels.fromJson(data));
      log("DRM255 ${data.keys.length}");
      for (var element in data.keys) {
        log("DRM255 $element");
      }
    } catch (e) {
      print('Error in catch: $e');
    }
  }

  String getHomeCollectionText(int homeCollectionValue) {
    return homeCollectionValue == 1
        ? 'Collected at home'
        : 'Collected at clinic';
  }

  @override
  Widget build(BuildContext context) {
    getTest();
    final eshopController = Get.put(EShopController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SmallText(
          text: 'Book Lab Test',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          textColor: Colors.grey.shade700,
        ),
        actions: const [
          CartCounter(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Obx(() {
                if (eshopController.isLabTestModelLoading.value == true) {
                  return shimmerListEffect();
                }

                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemCount: tests.value.diagnosticTestNames?.length ?? 0,
                  itemBuilder: (context, index) {
                    var test = tests.value.diagnosticTestNames?[index];
                    var testpename = tests.value.diagnosticPackageNames?[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => NewTestPageView(
                              diagnosticPeName: testpename,
                              diagnosticTestName: test,
                            ));
                      },
                      child: Padding(
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
                                    const DisplayImageWidget(
                                      color: Colors.red,
                                      height: 58,
                                      width: 58,
                                      child: Center(
                                        child: Icon(
                                          Icons.medical_information,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SmallText(
                                            text: "",
                                            textColor: Colors.grey.shade700,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            (test?.diagnosticDepartmentId ?? 0)
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            "",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const Row(
                                            children: [
                                              SmallText(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                text: "",
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
                      ),
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
