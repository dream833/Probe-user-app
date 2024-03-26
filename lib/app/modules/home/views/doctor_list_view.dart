
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/doctor/controller/doctor_controller.dart';
import 'package:uddipan/app/modules/home/controllers/home_controller.dart';
import 'package:uddipan/app/modules/home/views/widget/show_doctor_widget.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/utils/snippet.dart';

class DoctorListView extends GetView<DoctorController> {
  const DoctorListView({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorController = Get.find<DoctorController>();
    doctorController.removeFromSearch();
    return GestureDetector(
      onTap: () {
        doctorController.removeFromSearch();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: SmallText(
              text: 'All Doctors',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: Colors.grey.shade700),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(-1, 1),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: TextField(
                  controller: doctorController.searchController,
                  onTap: () {
                    doctorController.changeToSearch();
                  },
                  onChanged: (value) {
                    doctorController.searchDoctors(value);
                  },
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          doctorController.removeFromSearch();
                        },
                        child: Obx(() => doctorController.inSearchMode.value
                            ? const Icon(Icons.close)
                            : const Icon(
                                Icons.search,
                                size: 26,
                                color: Colors.grey,
                              ))),
                    isDense: true,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.userDoctor,
                      size: 25,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search Doctors',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // ),
              const SizedBox(height: 20),
              GetBuilder<DoctorController>(builder: (controller) {
                if (controller.inSearchMode.value == true) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: controller.searchedDoctors.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      DoctorModel? doctorModel =
                          controller.searchedDoctors[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: ShowDoctorWiget(
                            doctorModel: doctorModel, index: index),
                      );
                    },
                  );
                } else {
                  return FutureBuilder(
                      future: Get.put(DoctorController()).getAllDoctors(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return shimmerListEffect(
                              itemBorderRadius: 16, itemCount: 10);
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.doctorList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            DoctorModel? doctorModel =
                                controller.doctorList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ShowDoctorWiget(
                                  doctorModel: doctorModel, index: index),
                            );
                          },
                        );
                      });
                }
              })
            ]),
          ),
        ),
      ),
    );
  }


}

/*
       // Row(
              //   children: [
              //     Expanded(
              //       child: ,
              //     ),
              //     const SizedBox(width: 10),
              //     GestureDetector(
              //       onTap: () {
              //         openFilterBottomSheet(context);
              //       },
              //       child: Container(
              //         height: 45,
              //         width: 45,
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle, color: appColorBlue),
              //         child: const Icon(
              //           FontAwesomeIcons.filter,
              //           color: Colors.white,
              //           size: 19,
              //         ),
              //       ),
              //     ),
              //   ],*/
void openFilterBottomSheet(BuildContext context) {
  final controller = Get.find<HomeController>();
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(50.r),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0.r),
            topRight: Radius.circular(50.0.r),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 3.h,
                      width: Get.width,
                      margin: EdgeInsets.symmetric(horizontal: 130.h),
                      decoration: BoxDecoration(
                        color: appColorBlue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Text(
                    'Select Category',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10.0, // Adjust the spacing between your widgets
                    runSpacing:
                        10.0, // Adjust the run spacing if you want space between rows
                    children: List.generate(
                      controller.specializationCategory.length,
                      (index) => GestureDetector(
                        onTap: () {
                          controller.toggleIndex(index);
                        },
                        child: Obx(
                          () => Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: controller.selectedIndex.value == index
                                  ? appColorBlue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: controller.selectedIndex.value == index
                                    ? 2
                                    : 1,
                                color: controller.selectedIndex.value == index
                                    ? Colors.transparent
                                    : Colors.grey,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                controller.specializationCategory[index].name??'',
                                style: TextStyle(
                                    color:
                                        controller.selectedIndex.value == index
                                            ? Colors.white
                                            : Colors.black,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )

                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Container(
                  //     width: double.maxFinite,
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 12.w,
                  //       vertical: 12.h,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(24.r),
                  //       color: AppColor.green,
                  //     ),
                  //     child: const Center(
                  //       child: SmallText(
                  //         text: "Search",
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
