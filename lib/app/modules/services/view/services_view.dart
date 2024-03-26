import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:uddipan/app/widget/Text/big_text.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/routes/app_pages.dart';
import '../controller/services_controllers.dart';

class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        backgroundColor: Colors.white,
        title: SmallText(
            text: 'Services',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.diagnosticTestPage);
                },
                title: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: appColorPrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: BigText(
                          text: '1',
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Text(
                      'Diagnostic Test',
                      style: CustomFont.regularTextPoppins
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.hospitalInformationPage);
                },
                title: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: appColorPrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: BigText(
                          text: '2',
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: Text(
                      'Hospital Information',
                      style: CustomFont.regularTextPoppins
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
                trailing:const  Icon(
                  Icons.arrow_forward_ios,
                  size: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
