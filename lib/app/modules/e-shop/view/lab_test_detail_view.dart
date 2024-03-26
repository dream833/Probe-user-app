import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/modules/e-shop/view/patient_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/lab_test_model.dart';

class LabTestDetailView extends StatelessWidget {
  final LabTestModel model;
  const LabTestDetailView({super.key, required this.model});
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
          TestInfoWidget(model: model),
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
                        text: "BDT ${model.testCost}",
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Discount',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '40% Off',
                        style: TextStyle(fontSize: 12, color: appPrimaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  LoaderButton(
                      radius: 6,
                      color: Colors.deepOrange,
                      btnText: 'Book',
                      onTap: () async {
                        Get.to(() => const PatientView());
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
                      text: "BDT ${model.testCost}"),
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
}

class TestInfoWidget extends StatelessWidget {
  final LabTestModel model;
  const TestInfoWidget({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(model.testName,
                    style: CustomFont.regularMediumText
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 16)),
                Container(
                  height: 40,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepOrangeAccent,
                  ),
                  child: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.chartLine,
                  color: appPrimaryColor,
                  size: 19,
                ),
                const SizedBox(width: 5),
                Text('77,225 people booked this recently',
                    style: CustomFont.regularTextRaleway
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.filePdf,
                  color: appPrimaryColor,
                  size: 19,
                ),
                const SizedBox(width: 5),
                Text('Earliest report expected within 18 hours',
                    style: CustomFont.regularTextRaleway
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 20),
            Text(info,
                textAlign: TextAlign.justify,
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
                      Text('Blood',
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                      const SizedBox(height: 20),
                      Text('No Special Preparation is required',
                          style: CustomFont.regularTextPoppins.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.grey.shade700)),
                      const SizedBox(height: 5),
                      Text(model.isHomeCollection ? 'Yes' : 'No',
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
