import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/home/views/widget/show_doctor_widget.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/models/specialization_category_model.dart';
import 'package:uddipan/utils/snippet.dart';

import '../../doctor/controller/doctor_controller.dart';

class DoctorListByCategory extends StatelessWidget {
  final SpecializationCategory categoryModel;
  const DoctorListByCategory({super.key, required this.categoryModel});

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
              text: categoryModel.name??'',
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
                   
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search Doctors',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 14,
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
                      future: Get.put(DoctorController()).getDoctorByCategoryId(categoryId: categoryModel.id),
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
