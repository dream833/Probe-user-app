import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/bottom_navigation_bar/view/bottom_navigation_bar_view.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/string_constant.dart';
import '../../../../utils/custom_message.dart';
import '../../bottom_navigation_bar/controllers/bottom_navigation_bar_controllers.dart';

class LabTestDetailView extends StatelessWidget {
  String type;
  final dynamic model;
  final String? name;
  final String? method;
  final int? rates;
  final String? comments;
  final String? timeframe;
  final String? sample;
  final int? homeCollection;
  final String? preparation;
  //final
  LabTestDetailView(
      {super.key,
      required this.type,
      this.model,
      this.name,
      this.method,
      this.rates,
      this.comments,
      this.timeframe,
      this.sample,
      this.homeCollection,
      this.preparation});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EShopController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const SmallText(
            text: 'Lab Test Detail',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          TestInfoWidget(
            model: model,
            name: name,
            rate: rates,
            sample: sample,
            homeCollection: homeCollection,
            method: method,
            timeframe: timeframe,
            comments: comments,
            preparation: preparation,
          ),
          const SizedBox(height: 20),
          // Container(
          //   padding: const EdgeInsets.all(20.0),
          //   margin: const EdgeInsets.only(left: 16, right: 16),
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     boxShadow: [
          //       BoxShadow(
          //         color: Color.fromRGBO(0, 0, 0, 0.15),
          //         offset: Offset(-1, 1),
          //         blurRadius: 10,
          //       )
          //     ],
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Price',
          //         style: CustomFont.regularMediumText.copyWith(
          //           fontWeight: FontWeight.w700,
          //           fontSize: 22,
          //         ),
          //       ),
          //       const SizedBox(height: 10),
          //       SmallText(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500,
          //         text: "৳ ${rates.toString()}.00",
          //       ),
          //       const SizedBox(height: 15),
          //       LoaderButton(
          //           radius: 6,
          //           color: Colors.deepOrange,
          //           btnText: 'Book',
          //           onTap: () async {
          //             final patientId = getbox.read(userId).toString();
          //             log('PatientId $patientId');
          //             addLabTestToBooking(patientId);
          //           })
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 20),
        ]),
      ),
      bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SmallText(fontSize: 15, text: "Total Price"),
                  SmallText(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    text: "৳ ${rates.toString()}.00",
                  ),
                ],
              ),
              SizedBox(
                width: 150,
                child: LoaderButton(
                  radius: 6,
                  color: Colors.deepOrange,
                  btnText: "Add to cart",
                  onTap: () async {
                    controller.addLabTestToCart(model, type);
                  },
                ),
              )
            ],
          )),
    );
  }
}

class TestInfoWidget extends StatelessWidget {
  final dynamic model;
  final String? name;
  final String? method;
  final int? rate;
  final String? comments;
  final String? timeframe;
  final String? sample;
  int? homeCollection;
  final String? preparation;
  TestInfoWidget(
      {super.key,
      required this.model,
      this.name,
      this.method,
      this.rate,
      this.comments,
      this.timeframe,
      this.sample,
      this.homeCollection,
      this.preparation});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name.toString(),
                    style: CustomFont.regularMediumText
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 16)),
                // Container(
                //   height: 40,
                //   width: 45,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     color: Colors.deepOrangeAccent,
                //   ),
                //   // child: const Icon(
                //   //   Icons.share,
                //   //   color: Colors.white,
                //   // ),
                // ),
              ],
            ),
            const SizedBox(height: 5),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.filePdf,
                  color: appPrimaryColor,
                  size: 19,
                ),
                const SizedBox(width: 5),
                Text(
                    timeframe != null
                        ? timeframe.toString()
                        : "No specified time frame ",
                    style: CustomFont.regularTextRaleway
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(comments.toString(),
                  textAlign: TextAlign.start,
                  style: CustomFont.regularTextPoppins
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
            ),
            const SizedBox(height: 20),
            Table(
              columnWidths: const {
                0: FixedColumnWidth(150.0),
                1: FlexColumnWidth(),
              },
              border: TableBorder.all(
                color: Colors.grey.shade300,
                width: 1,
                style: BorderStyle.solid,
              ),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Title',
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Details",
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Sample Required',
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(sample != null ? sample.toString() : "No",
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Preparation',
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          preparation != null
                              ? preparation.toString()
                              : 'No Special Preparation is required',
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Home Collection?',
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(homeCollection == 1 ? 'Yes' : 'No',
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String info =
    "Experience comprehensive health analysis with our CBC (Complete Blood Count) test, assessing vital blood components without fasting requirements. Uncover lipid levels crucial for heart health through our Lipid Profile, with a 10-12 hour fasting prerequisite. Evaluate thyroid function effortlessly in the Thyroid Function Test, without disrupting your medication routine. HbA1c (Glycated Hemoglobin) provides a detailed look at average blood sugar levels, allowing for optimal diabetes management.";
