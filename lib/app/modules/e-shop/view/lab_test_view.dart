import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/models/lab_test_models.dart';

import '../../../../api/dio_get.dart';
import '../../../../constants/color_constant.dart';

class LabTestView extends StatelessWidget {
  LabTestView({Key? key}) : super(key: key);

  final tests = LabTestModels().obs;

  Future<void> getTest() async {
    try {
      var response = await dioGet("/booked-diagnostic-test");
      Map<String, dynamic> data = response.data;
      tests.value = LabTestModels.fromJson(data);
      log("DRM255 ${data.keys.length}");
      for (var element in data.keys) {
        log("DRM255 $element");
      }
    } catch (e) {
      print('Error in catch: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    getTest();
    final eshopController = Get.put(EShopController());
    final data = Get.arguments ?? {};

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          leading: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                backgroundColor: AppColor.litegrey,
                radius: 16,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.black,
                  size: 18,
                ),
              ),
            ),
          ),
          title: Text(
            data["name"]?.toString() ?? 'Lab Test',
            style: TextStyle(
              color: AppColor.black.withOpacity(0.8),
              fontSize: 15.w,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(vertical: 14),
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {}
                    },
                    decoration: InputDecoration(
                      focusColor: AppColor.white,
                      hoverColor: AppColor.white,
                      contentPadding: REdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      hintText: 'What do you want to learn?',
                      suffixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: AppColor.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(color: AppColor.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.white),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                ),
                sectionTitle('Diagnostic Tests'),
                testSection(tests.value.diagnosticTestNames),
                sectionTitle('Diagnostic Packages'),
                testSection(tests.value.diagnosticPackageNames),
                sectionTitle('Diagnostic Profiles'),
                testSection(tests.value.diagnosticProfileNames),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10, horizontal: 3),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.r,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget testSection(List? testList) {
    return Obx(
      () => (testList != null && testList.isNotEmpty)
          ? SizedBox(
              height: 230.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: testList.length,
                itemBuilder: (context, index) {
                  var test = testList[index];
                  var tests = test.value.diagnosticPackageNames![index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: 150.w,
                      margin: EdgeInsets.only(right: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.r),
                      ),
                      padding: EdgeInsets.all(2.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: AppColor.green,
                              borderRadius: BorderRadius.circular(10.r),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/doctor_image.png",
                                ),
                              ),
                            ),
                          ),
                          Text(
                            test.name ?? 'Demo',
                            style: TextStyle(
                              fontSize: 13.r,
                              color: AppColor.black.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(
                            width: 150.w,
                            child: Text(
                              "",
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.r,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          Divider(
                            color: AppColor.black.withOpacity(0.3),
                            thickness: 1.3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "",
                                style: TextStyle(
                                  fontSize: 13,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black.withOpacity(0.5),
                                ),
                              ),
                              Wrap(
                                children: [
                                  RatingBarIndicator(
                                    rating:
                                        double.tryParse((2).toString()) ?? 0.0,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 17.0,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.r,
                                  vertical: 3.r,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: AppColor.green,
                                ),
                                child: Text(
                                  "",
                                  // '${test.discount.toString().replaceAll(RegExp(r'0*$'), '')}% off',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColor.white,
                                  ),
                                ),
                              ),
                              Text(
                                "",
                                // '\u{20B9} ${test.price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : SizedBox(
              height: 300.h, // Adjust height as needed
              child: const Center(child: CircularProgressIndicator()),
            ),
    );
  }
}
