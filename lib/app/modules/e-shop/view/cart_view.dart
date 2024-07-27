import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/color_constant.dart';

import '../../../../drm_codes/controller/cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final eshopController = Get.put(EShopController());
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
        () => cartController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ((cartController.testCartModel.value.prescriptions ?? []).isEmpty)
                ? const Center(
                    child: Text('No Item In Cart'),
                  )
                : ListView.builder(
                    itemCount: cartController
                        .testCartModel.value.prescriptions?.length,
                    itemBuilder: (context, index) {
                      List prescription = [];

                      if ((cartController.testCartModel.value
                                  .prescriptions![index].diagnosticPackages ??
                              [])
                          .isNotEmpty) {
                        prescription = cartController.testCartModel.value
                            .prescriptions![index].diagnosticPackages as List;
                      } else if ((cartController.testCartModel.value
                                  .prescriptions![index].diagnosticProfiles ??
                              [])
                          .isNotEmpty) {
                        prescription = cartController.testCartModel.value
                            .prescriptions![index].diagnosticProfiles as List;
                      } else {
                        prescription = cartController.testCartModel.value
                            .prescriptions![index].diagnosticTests as List;
                      }

                      const Text("Hii");
                      return null;

                      // return Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Align(
                      //           child: SmallText(
                      //         text: prescription.name ?? "NULL",
                      //         textAlign: TextAlign.center,
                      //         fontSize: 17,
                      //         fontWeight: FontWeight.bold,
                      //         textColor: Colors.black,
                      //       )),
                      //     ),
                      //     const SizedBox(height: 10),
                      //     Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal: 12, vertical: 12),
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.circular(16),
                      //                 boxShadow: const [
                      //                   BoxShadow(
                      //                     color: Color.fromRGBO(0, 0, 0, 0.15),
                      //                     offset: Offset(-1, 1),
                      //                     blurRadius: 10,
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Column(
                      //                   children: [
                      //                     Row(
                      //                       children: [
                      //                         DisplayImageWidget(
                      //                           color: Colors.red,
                      //                           height: 58,
                      //                           width: 58,
                      //                           child: Center(
                      //                             child: Text(
                      //                               prescription.name ?? "",
                      //                               style: const TextStyle(
                      //                                 color: Colors.white,
                      //                                 fontSize: 15,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                         const SizedBox(width: 12),
                      //                         Column(
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment.start,
                      //                           children: [
                      //                             SmallText(
                      //                               text:
                      //                                   prescription.code ?? "",
                      //                               textColor:
                      //                                   Colors.grey.shade700,
                      //                               fontSize: 14,
                      //                               fontWeight: FontWeight.w600,
                      //                             ),
                      //                             const SizedBox(height: 4),
                      //                             Text(
                      //                               prescription.comments ?? "",
                      //                               style: const TextStyle(
                      //                                   fontSize: 12),
                      //                             ),
                      //                             const SizedBox(height: 4),
                      //                             Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.start,
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 RatingBar.builder(
                      //                                   initialRating: 3,
                      //                                   minRating: 1,
                      //                                   direction:
                      //                                       Axis.horizontal,
                      //                                   allowHalfRating: true,
                      //                                   itemCount: 5,
                      //                                   itemSize: 15,
                      //                                   itemPadding:
                      //                                       const EdgeInsets
                      //                                           .symmetric(
                      //                                           horizontal:
                      //                                               0.0),
                      //                                   itemBuilder:
                      //                                       (context, _) =>
                      //                                           const Icon(
                      //                                     Icons.star,
                      //                                     color: Colors.amber,
                      //                                   ),
                      //                                   onRatingUpdate:
                      //                                       (rating) {},
                      //                                 ),
                      //                                 const SizedBox(width: 5),
                      //                                 const SmallText(
                      //                                   fontSize: 12,
                      //                                   text: "(4.0)",
                      //                                 ),
                      //                                 const SizedBox(width: 5),
                      //                                 const SmallText(
                      //                                   fontSize: 11,
                      //                                   text: "(1570 ratings)",
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                             Row(
                      //                               children: [
                      //                                 SmallText(
                      //                                   fontSize: 15,
                      //                                   fontWeight:
                      //                                       FontWeight.w500,
                      //                                   text:
                      //                                       "\$ ${prescription.rate.toString()}",
                      //                                 ),
                      //                                 const SizedBox(width: 4),
                      //                               ],
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ],
                      //                     ),
                      //                     const SizedBox(height: 20),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           );

                      //     const SizedBox(height: 20),
                      //     Obx(() => eshopController.products.values.isEmpty
                      //         ? Container()
                      //         : const Padding(
                      //             padding: EdgeInsets.all(8.0),
                      //             child: Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: SmallText(
                      //                   text: 'Medicines',
                      //                   fontSize: 17,
                      //                   fontWeight: FontWeight.bold,
                      //                   textColor: Colors.black,
                      //                 )),
                      //           )),
                      //     const SizedBox(height: 10),
                      //     Obx(
                      //       () => ListView.builder(
                      //         shrinkWrap: true,
                      //         scrollDirection: Axis.vertical,
                      //         physics: const ScrollPhysics(),
                      //         itemCount: eshopController.products.values
                      //             .toList()
                      //             .length,
                      //         itemBuilder: (context, index) {
                      //           final medicine = eshopController.products.values
                      //               .toList()[index]
                      //               .first;

                      //           return Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.circular(16),
                      //                 boxShadow: const [
                      //                   BoxShadow(
                      //                     color: Color.fromRGBO(0, 0, 0, 0.15),
                      //                     offset: Offset(-1, 1),
                      //                     blurRadius: 10,
                      //                   )
                      //                 ],
                      //               ),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Column(
                      //                   children: [
                      //                     Row(
                      //                       children: [
                      //                         DisplayImageWidget(
                      //                             color: appPrimaryColor,
                      //                             height: 58,
                      //                             width: 58,
                      //                             child: Image.network(
                      //                                 medicine.image)),
                      //                         const SizedBox(width: 12),
                      //                         Expanded(
                      //                           child: Column(
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               Row(
                      //                                 children: [
                      //                                   SmallText(
                      //                                     text: medicine.name,
                      //                                     textColor: Colors
                      //                                         .grey.shade700,
                      //                                     fontSize: 14,
                      //                                     fontWeight:
                      //                                         FontWeight.w600,
                      //                                   ),
                      //                                   const SizedBox(
                      //                                       width: 5),
                      //                                   SmallText(
                      //                                     text:
                      //                                         "(${medicine.dosage})",
                      //                                     fontSize: 12,
                      //                                     fontWeight:
                      //                                         FontWeight.w500,
                      //                                     textColor: Colors
                      //                                         .grey.shade700,
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               const SizedBox(height: 4),
                      //                               Text(
                      //                                 medicine.description,
                      //                                 style: const TextStyle(
                      //                                     fontSize: 10),
                      //                               ),
                      //                               const SizedBox(height: 4),
                      //                               Row(
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment
                      //                                         .start,
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .start,
                      //                                 children: [
                      //                                   RatingBar.builder(
                      //                                     initialRating: 3,
                      //                                     minRating: 1,
                      //                                     direction:
                      //                                         Axis.horizontal,
                      //                                     allowHalfRating: true,
                      //                                     itemCount: 5,
                      //                                     itemSize: 15,
                      //                                     itemPadding:
                      //                                         const EdgeInsets
                      //                                             .symmetric(
                      //                                             horizontal:
                      //                                                 0.0),
                      //                                     itemBuilder:
                      //                                         (context, _) =>
                      //                                             const Icon(
                      //                                       Icons.star,
                      //                                       color: Colors.amber,
                      //                                     ),
                      //                                     onRatingUpdate:
                      //                                         (rating) {},
                      //                                   ),
                      //                                   const SizedBox(
                      //                                       width: 5),
                      //                                   const SmallText(
                      //                                       fontSize: 12,
                      //                                       text: "(4.0)"),
                      //                                   const SizedBox(
                      //                                       width: 5),
                      //                                   const SmallText(
                      //                                       fontSize: 11,
                      //                                       text:
                      //                                           "(1570 ratings)"),
                      //                                 ],
                      //                               ),
                      //                               Row(
                      //                                 children: [
                      //                                   SmallText(
                      //                                     fontSize: 15,
                      //                                     fontWeight:
                      //                                         FontWeight.w500,
                      //                                     text:
                      //                                         "\$ ${medicine.price.toString()}",
                      //                                   ),
                      //                                   const SizedBox(
                      //                                       width: 4),
                      //                                   Text(
                      //                                     'Discount',
                      //                                     style: TextStyle(
                      //                                         fontSize: 12,
                      //                                         color: Colors.grey
                      //                                             .shade600),
                      //                                   ),
                      //                                   const SizedBox(
                      //                                       width: 4),
                      //                                   const Text(
                      //                                     '40%',
                      //                                     style: TextStyle(
                      //                                         fontSize: 12,
                      //                                         color:
                      //                                             Colors.red),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                     const SizedBox(height: 20),
                      //                     Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.end,
                      //                       children: [
                      //                         InkWell(
                      //                           onTap: () {
                      //                             eshopController
                      //                                 .decreaseQuantity(
                      //                                     medicine);
                      //                           },
                      //                           child: Padding(
                      //                             padding:
                      //                                 const EdgeInsets.only(
                      //                                     right: 6),
                      //                             child: Container(
                      //                               height: 40,
                      //                               width: 40,
                      //                               decoration: BoxDecoration(
                      //                                   border: Border.all(
                      //                                       color: Colors.red),
                      //                                   color: Colors
                      //                                       .white, // Change color as needed
                      //                                   borderRadius:
                      //                                       BorderRadius
                      //                                           .circular(12)),
                      //                               child: const Icon(
                      //                                 Icons.remove,
                      //                                 color: Colors.red,
                      //                                 size: 24,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                         const SizedBox(width: 20),
                      //                         Text(
                      //                           medicine.selectedQuantity
                      //                               .toString(),
                      //                           style: const TextStyle(
                      //                               fontSize: 14,
                      //                               fontWeight:
                      //                                   FontWeight.w500),
                      //                         ),
                      //                         const SizedBox(width: 20),
                      //                         InkWell(
                      //                           onTap: () {
                      //                             eshopController
                      //                                 .increaseQuantity(
                      //                                     medicine);
                      //                           },
                      //                           child: Padding(
                      //                             padding:
                      //                                 const EdgeInsets.only(
                      //                                     right: 6),
                      //                             child: Container(
                      //                               height: 40,
                      //                               width: 40,
                      //                               decoration: BoxDecoration(
                      //                                   color:
                      //                                       appPrimaryColor, // Change color as needed
                      //                                   borderRadius:
                      //                                       BorderRadius
                      //                                           .circular(12)),
                      //                               child: const Icon(
                      //                                 Icons.add,
                      //                                 color: Colors.white,
                      //                                 size: 24,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //     const SizedBox(height: 20),
                      //     eshopController.totalAmount.value == 0.00
                      //         ? const SizedBox()
                      //         : Container(
                      //             padding: const EdgeInsets.all(16),
                      //             decoration: BoxDecoration(
                      //               color: Colors.grey[200],
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: Colors.black.withOpacity(0.1),
                      //                   blurRadius: 2,
                      //                   offset: const Offset(0, -1),
                      //                 ),
                      //               ],
                      //             ),
                      //             child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                   'Total Payable Amount:',
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .bodySmall
                      //                       ?.copyWith(
                      //                           fontSize: 15,
                      //                           fontWeight: FontWeight.w700),
                      //                 ),
                      //                 Obx(
                      //                   () => Text(
                      //                     '${eshopController.totalAmount.value.toStringAsFixed(2)} BDT',
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .bodySmall
                      //                         ?.copyWith(
                      //                             fontSize: 13,
                      //                             fontWeight: FontWeight.w700),
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //     const SizedBox(
                      //       height: 20,
                      //     ),
                      //     eshopController.totalAmount.value == 0.00
                      //         ? const SizedBox()
                      //         : Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: LoaderButton(
                      //                 btnText: " Order", onTap: () async {}),
                      //           ),
                      //     const SizedBox(
                      //       height: 20,
                      //     )
                      //   ],
                      // );
                    },
                  ),
      ),
    );
  }
}

/*

*/ 