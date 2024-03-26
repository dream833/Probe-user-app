import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/home/views/widget/all_specialization_view.dart';
import 'package:uddipan/utils/snippet.dart';

import '../../controllers/home_controller.dart';
import '../doctor_list_by_category_view.dart';

class ShowSpecialistCategories extends StatelessWidget {
  const ShowSpecialistCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Specialists',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const AllSpecializationView());
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FutureBuilder(
          future: controller.getSpecializationCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              
              return shimmerGridEffect(
                  itemAspectRatio: 1.1,
                  itemCount: 6,
                  itemBorderRadius: 12,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3);
            } else {
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 10,
                      // mainAxisExtent: 160,
                      childAspectRatio: 1.1),
                  shrinkWrap: true,
                  itemCount: controller.specializationCategory.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(()=> DoctorListByCategory(categoryModel: controller.specializationCategory[index],));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0,
                                    0.15), // Shadow color with some transparency
                                offset: Offset(
                                    2, 2), // Horizontal and vertical offset
                                blurRadius: 5, // Spread or blur of the shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.network(
                                  controller.specializationCategory[index].image??'',
                                  height: 40,
                                  width: 40,
                                ),
                                Text(
                                  controller.specializationCategory[index].name??'',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ],
    );
  }
}


