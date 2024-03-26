import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/routes/app_pages.dart';
import '../../../../constants/image_contant.dart';


import 'CustomImage/customAssetImage.dart';
import 'Text/bold_text.dart';

class ShowDoctorList extends StatelessWidget {
  const ShowDoctorList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: BoldText(text: "Doctor Name"),
                      ),
                      Icon(Icons.favorite_outline),
                    ],
                  ),
                  const Divider(),
                  const Text("Medicine | Neurology"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SmallText(text: "Consultant Fee: "),
                      SizedBox(
                        width: 2.w,
                      ),
                      SmallText(text: "700 TK.",
                        textColor: AppColor.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),

                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}