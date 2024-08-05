import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';

import '../../../../drm_codes/controller/cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: SmallText(
            text: 'Cart-Shop',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () => Stack(
          children: [
            FutureBuilder(
              future: cartController.getcart(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var prescriptionData =
                    cartController.cartmodel.value.prescriptions;
                List<Map<String, dynamic>> myMergedData = [];

                cartController.cartmodel.value.prescriptions?.diagnosticPackages
                    ?.forEach((data) {
                  data["type"] = "package";
                  myMergedData.add(data);
                });

                cartController.cartmodel.value.prescriptions?.diagnosticTests
                    ?.forEach((tempdata) {
                  var data = jsonDecode(jsonEncode(tempdata));
                  data["type"] = "test";
                  myMergedData.add(data);
                });

                cartController.cartmodel.value.prescriptions?.diagnosticProfiles
                    ?.forEach((tempdata) {
                  var data = jsonDecode(jsonEncode(tempdata));
                  data["type"] = "profile";
                  myMergedData.add(data);
                });

                if (myMergedData.isEmpty) {
                  return const Center(
                    child: Text('No Item In Cart'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: myMergedData.length,
                    itemBuilder: (context, index) {
                      var data = myMergedData[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.15),
                                  offset: Offset(-1, 1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SmallText(
                                              text: data["name"] ?? "EMPTY",
                                              textAlign: TextAlign.left,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              textColor: Colors.black,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      RatingBar.builder(
                                                        initialRating: 3,
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemSize: 15,
                                                        itemPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    0.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {},
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const SmallText(
                                                        fontSize: 12,
                                                        text: "(4.0)",
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const SmallText(
                                                        fontSize: 11,
                                                        text: "(1570 ratings)",
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SmallText(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        text:
                                                            "৳ ${(data["rate"] ?? '0').toString()}",
                                                      ),
                                                      const SizedBox(width: 4),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    cartController.removeTestFromCart(
                                      cartID: prescriptionData?.id.toString(),
                                      itemID: (data["id"] ?? 0).toString(),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
              },
            ),
            Visibility(
              visible: cartController.isLoading.value,
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          cartController.checkOut();
        },
        child: Container(
          height: 60,
          color: Colors.deepOrange,
          child: const Center(
            child: Text(
              "Checkout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
