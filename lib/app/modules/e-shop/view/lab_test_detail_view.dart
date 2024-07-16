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
import 'package:uddipan/models/lab_test_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/string_constant.dart';
import '../../../../utils/custom_message.dart';
import '../../bottom_navigation_bar/controllers/bottom_navigation_bar_controllers.dart';

class LabTestDetailView extends StatelessWidget {
  final LabTestModel? model;
  final String? name;
  final String? method;
  final int? rates;
  final String? comments;
  final String? timeframe;
  final String? sample;
  final int? homeCollection;
  final String? preparation;
  //final
  const LabTestDetailView(
      {super.key,
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
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price',
                      style: CustomFont.regularMediumText
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SmallText(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        text: rates.toString(),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 15),
                  LoaderButton(
                      radius: 6,
                      color: Colors.deepOrange,
                      btnText: 'Book',
                      onTap: () async {
                        try {
                          Get.put(());
                          final patientId = getbox.read(userId).toString();

                          log('PatientId $patientId');
                          await addLabTestToBooking(patientId, context);
                        } catch (e) {
                          return;
                        }
                      })
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                  // const SizedBox(height: 1),
                  SmallText(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      text: rates.toString()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: LoaderButton(
                        radius: 6,
                        color: Colors.deepOrange,
                        btnText: "Go to cart",
                        onTap: () async {
                          controller.addLabTestToCart(model);
                        })),
              )
            ],
          )),
    );
  }

  Future<void> addLabTestToBooking(
      String patientId, BuildContext context) async {
    final data = {
      "user_id": getbox.read(userId).toString(),

      "test_id": ["3"],
      "price": "1200".toString(), //   "paitent_id": patientId,
      //   "patient_name": profileController.userModel.value!.name.toString(),
      //   "name": name,
      //   "rate": rate.toString(),
      //   "sample": sample ?? 'No sample needed',
      //   "homeCollection": homeCollection.toString(),
      //   "method": method ?? 'No method specified',
      //   "timeframe": timeframe ?? 'No timeframe specified',
      //   "comments": comments ?? 'No additional comments',
      //   "preparation": preparation ?? 'No preparation specified',
      // };
    };

    String token = getbox.read(userToken);
    // String url = "https://api.esplshowcase.in/api/book-diagnostic-testing";
    String url = "https://api.esplshowcase.in/api/test-booking";

    Dio dio = Dio();
    var response = await dio.post(url,
        data: json.encode(data),
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
              "Accept": "application/json"
            }));
    Future<void> customLaunch(String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      final url = response.data.toString();

      await customLaunch(url);
      Future.delayed(const Duration(milliseconds: 200), () {
        final controller = Get.find<BottomNavigationBarControllers>();
        controller.selectedIndex.value = 1;

        Get.offAll(() => BottomNavigationBarView());
      });
      CustomMessage.showSuccessSnackBar("Redirecting to Payment");
    } else {
      debugPrint("${response.data} ${response.statusMessage}");
      CustomMessage.errorMessage('Error ${response.statusCode}');
    }
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
            Text(comments.toString(),
                textAlign: TextAlign.start,
                style: CustomFont.regularTextPoppins
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sample Required',
                        style: CustomFont.regularTextPoppins.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.grey.shade700)),
                    const SizedBox(height: 20),
                    Text('Preparation',
                        style: CustomFont.regularTextPoppins.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.grey.shade700)),
                    const SizedBox(height: 20),
                    Text('Home Collection?',
                        style: CustomFont.regularTextPoppins.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.grey.shade700)),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sample != null ? sample.toString() : "No",
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                      const SizedBox(height: 20),
                      Text(
                          preparation != null
                              ? preparation.toString()
                              : 'No Special Preparation is required',
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                      const SizedBox(height: 5),
                      Text(homeCollection == 1 ? 'Yes' : 'No',
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                    ],
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

String info =
    "Experience comprehensive health analysis with our CBC (Complete Blood Count) test, assessing vital blood components without fasting requirements. Uncover lipid levels crucial for heart health through our Lipid Profile, with a 10-12 hour fasting prerequisite. Evaluate thyroid function effortlessly in the Thyroid Function Test, without disrupting your medication routine. HbA1c (Glycated Hemoglobin) provides a detailed look at average blood sugar levels, allowing for optimal diabetes management.";
