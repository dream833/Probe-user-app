import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';

import 'package:uddipan/app/modules/e-shop/view/lab_test_detail_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/cart_counter.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';

import 'package:uddipan/models/lab_test_model.dart';
import 'package:uddipan/utils/snippet.dart';
import 'package:http/http.dart' as http;

class LabTestView extends StatefulWidget {
  const LabTestView({super.key, this.model});
  final LabTestModel? model;
  @override
  State<LabTestView> createState() => _LabTestViewState();
}

class _LabTestViewState extends State<LabTestView> {
  String name = "";
  String method = "";
  int rate = 0;
  String comments = "";
  bool homeCollection = false;
  List<Map<String, dynamic>> diagnosticTests = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const url = 'https://api.esplshowcase.in/api/booked-diagnostic-test';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        diagnosticTests =
            List<Map<String, dynamic>>.from(data['diagnosticTestNames']);
      });
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  String getHomeCollectionText(int homeCollectionValue) {
    return homeCollectionValue == 1
        ? 'Collected at home'
        : 'Collected at clinic';
  }

  @override
  Widget build(BuildContext context) {
    final eshopController = Get.put(EShopController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SmallText(
            text: 'Book Lab Test',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
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
                  itemCount: diagnosticTests.length,
                  itemBuilder: (context, index) {
                    final test = diagnosticTests[index];
                    // MedicineModel? medicine = eshopController.medicineList[index];
                    //LabTestModel? labTest;
                    // LabTestModel? labTest = eshopController.reportList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => LabTestDetailView(
                              model: widget.model,
                              name: test['name'],
                              rate: test['rate'],
                              sample: test['sample'],
                              homeCollection: test['homeCollection'],
                              method: test['method'],
                              timeframe: test['timeframe'],
                              comments: test['comments'],
                              preparation: test['preparation'],
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
                                        )),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SmallText(
                                            text: test['name'],
                                            textColor: Colors.grey.shade700,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            test['comments'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            getHomeCollectionText(
                                                test['homeCollection']),
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.start,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     RatingBar.builder(
                                          //       initialRating: 3,
                                          //       minRating: 1,
                                          //       direction: Axis.horizontal,
                                          //       allowHalfRating: true,
                                          //       itemCount: 5,
                                          //       itemSize: 15,
                                          //       itemPadding:
                                          //           const EdgeInsets
                                          //               .symmetric(
                                          //               horizontal: 0.0),
                                          //       itemBuilder: (context, _) =>
                                          //           const Icon(
                                          //         Icons.star,
                                          //         color: Colors.amber,
                                          //       ),
                                          //       onRatingUpdate: (rating) {},
                                          //     ),
                                          //     const SizedBox(width: 5),
                                          //     const SmallText(
                                          //         fontSize: 12,
                                          //         text: "(4.0)"),
                                          //     const SizedBox(width: 5),
                                          //     const SmallText(
                                          //         fontSize: 11,
                                          //         text: "(1570 ratings)"),
                                          //   ],
                                          // ),

                                          Row(
                                            children: [
                                              SmallText(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                text:
                                                    "BDT ${test['rate'].toString()}",
                                              ),
                                              // const SizedBox(width: 4),
                                              // Text(
                                              //   'Discount',
                                              //   style: TextStyle(
                                              //       fontSize: 12,
                                              //       color: Colors
                                              //           .grey.shade600),
                                              // ),
                                              // const SizedBox(width: 4),
                                              // const Text(
                                              //   '40%',
                                              //   style: TextStyle(
                                              //       fontSize: 12,
                                              //       color: Colors.red),
                                              // ),
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
