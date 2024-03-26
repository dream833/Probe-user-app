import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/routes/app_pages.dart';
import '../../../../constants/image_contant.dart';

import 'package:uddipan/app/widget/CustomImage/customAssetImage.dart';
import 'package:uddipan/app/widget/Text/bold_text.dart';

import '../../../widget/appbar/appbar_leading_icon.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainBackgroundColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.mainBackgroundColor,
          title: Text(
            "Doctors Medicine | Neurology",
            style: TextStyle(
              color: AppColor.black,
            ),
          ),
          automaticallyImplyLeading: false,
          leading: const AppBarLeadingIcon()),
      body: ListView.builder(
        itemCount: 7,
        padding: const EdgeInsets.only(bottom: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.doctorDetailsPage);
            },
            child: Container(
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white38,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: const CustomAssetImage(
                      height: 100,
                      width: 100,
                      assetPath: AppImage.doctorImage,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: BoldText(text: "Doctor Name"),
                            ),
                            Icon(Icons.favorite_outline),
                          ],
                        ),
                        Divider(),
                        Text("Medicine | Neurology"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("4.5"),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Total Review: 4528")
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
