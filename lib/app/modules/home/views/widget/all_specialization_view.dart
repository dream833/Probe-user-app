import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/home/views/doctor_list_by_category_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/utils/snippet.dart';

import '../../controllers/home_controller.dart';

class AllSpecializationView extends StatelessWidget {
  const AllSpecializationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SmallText(
            text: 'All Specialist',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              FutureBuilder(
                  future: controller.getSpecializationCategories(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return shimmerListEffect(
                          itemBorderRadius: 16, itemCount: 10);
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.specializationCategory.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                 Get.to(()=> DoctorListByCategory(categoryModel: controller.specializationCategory[index],));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0,
                                            0.15), // Shadow color with some transparency
                                        offset: Offset(2,
                                            2), // Horizontal and vertical offset
                                        blurRadius:
                                            5, // Spread or blur of the shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(
                                              controller.specializationCategory[
                                                  index].image??'',
                                              height: 60,
                                              width: 60,
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                          .specializationCategory[
                                                      index].name??'',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  '${ controller.specializationCategory[index].doctorsCount.toString()} doctors',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

}
