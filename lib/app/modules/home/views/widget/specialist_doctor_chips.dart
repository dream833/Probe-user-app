import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/home/controllers/home_controller.dart';
import 'package:uddipan/constants/color_constant.dart';

class SpecialistDoctorChips extends StatelessWidget {
  const SpecialistDoctorChips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView.builder(
            padding: EdgeInsets.only(right: 10.w),
            itemCount: controller.specializationCategory.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.toggleIndex(index);
                },
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.only(left: 10.w),
                    decoration: BoxDecoration(
                      color: controller.selectedIndex.value == index
                          ? appColorBlue
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: controller.selectedIndex.value == index ? 2 : 1,
                        color: controller.selectedIndex.value == index
                            ? Colors.transparent
                            : Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        controller.specializationCategory[index].name??'',
                        style: TextStyle(
                          color: controller.selectedIndex.value == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
