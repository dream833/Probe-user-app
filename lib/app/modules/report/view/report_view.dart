import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/report/controller/report_controller.dart';
import 'package:uddipan/app/modules/report/view/add_report_view.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/load_pdf.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/models/user_report_model.dart';
import 'package:uddipan/utils/snippet.dart';

import '../../../widget/Text/small_text.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());
    // controller.getAllUserReports();
    // controller.getAllAdminReports();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "User",
              ),
              Tab(
                text: "Admin",
              ),
            ],
          ),
          centerTitle: true,
          title: const SmallText(
              text: 'Reports ',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textColor: Colors.black),
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(children: [
                Obx(() {
                  if (controller.isReportListLoading.value == true) {
                    return shimmerListEffect();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: controller.reportList.length,
                    itemBuilder: (context, index) {
                      UserReportModel? report = controller.reportList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => PDFViewerFromUrl(
                                url: report!.file,
                              ));
                        },
                        child: Padding(
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
                                    const DisplayImageWidget(
                                      color: Colors.red,
                                      height: 60,
                                      width: 60,
                                      child: Icon(
                                        FontAwesomeIcons.filePdf,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          report?.name ?? '',
                                          style: CustomFont.regularTextPoppins,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          report?.date ?? '',
                                          style: CustomFont.regularTextPoppins
                                              .copyWith(fontSize: 14),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ]),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(children: [
                Obx(() {
                  if (controller.isReportListLoading.value == true) {
                    return shimmerListEffect();
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: controller.adminreportList.length,
                      itemBuilder: (context, index) {
                        AdminReportModel? report =
                            controller.adminreportList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => PDFViewerFromUrl(
                                  url: report!.file,
                                ));
                          },
                          child: Padding(
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
                                      const DisplayImageWidget(
                                        color: Colors.red,
                                        height: 60,
                                        width: 60,
                                        child: Icon(
                                          FontAwesomeIcons.filePdf,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            report?.name ?? '',
                                            style:
                                                CustomFont.regularTextPoppins,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            report?.date ?? '',
                                            style: CustomFont.regularTextPoppins
                                                .copyWith(fontSize: 14),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ]),
                              ),
                            ),
                          ),
                        );
                      });
                }),
              ]),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          onPressed: () {
            Get.to(() => const AddReportView());
          },
          backgroundColor: Colors.red,
          child: const Icon(FontAwesomeIcons.plus, color: Colors.white),
        ),
      ),
    );
  }
}
