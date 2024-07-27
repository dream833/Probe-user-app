import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/models/lab_test_models.dart';

import '../../../../api/dio_get.dart';
import '../../../../constants/color_constant.dart';
import 'lab_test_detail_view.dart';

class LabTestView extends StatelessWidget {
  LabTestView({Key? key}) : super(key: key);

  final tests = LabTestModels().obs;

  Future<void> getTest() async {
    var response = await dioGet("/booked-diagnostic-test");
    Map<String, dynamic> data = response.data;
    tests.value = LabTestModels.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    getTest();
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
        body: FutureBuilder(
            future: getTest(),
            builder: (context, snapshot) {
              if (!(snapshot.connectionState == ConnectionState.done)) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SingleChildScrollView(
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
                      Obx(() =>
                          testSection(tests.value.diagnosticTestNames, 'test')),
                      sectionTitle('Diagnostic Packages'),
                      Obx(() => testSection(
                          tests.value.diagnosticPackageNames, 'package')),
                      sectionTitle('Diagnostic Profiles'),
                      Obx(() => testSection(
                          tests.value.diagnosticProfileNames, 'profile')),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10, horizontal: 3),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.r,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_right_alt_sharp)
        ],
      ),
    );
  }

  Widget testSection(List? testList, String type) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: testList?.length ?? 0,
        itemBuilder: (context, index) {
          var test = testList?[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.to(
                  LabTestDetailView(
                    type: type,
                    comments: test?.comments ?? '',
                    homeCollection: test.homeCollection ?? 0,
                    model: test,
                    name: test?.name ?? '',
                    preparation: test?.preparation,
                    rates: test?.rate ?? 0,
                    sample: test?.sample,
                    timeframe: test?.timeframe,
                  ),
                );
              },
              child: Container(
                width: 145,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: AppColor.black.withOpacity(0.1), width: 1.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90,
                      width: 145,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            "assets/images/doctor_image.png",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      test.name ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColor.black.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      "৳ ${test.rate}",
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: const Color.fromARGB(255, 53, 53, 53)
                            .withOpacity(0.8),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          children: [
                            RatingBarIndicator(
                              rating: double.tryParse((2).toString()) ?? 0.0,
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
                        Text(
                          " (2)",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black.withOpacity(0.5),
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
      ),
    );
  }
}
