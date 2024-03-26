import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/doctor/controller/doctor_controller.dart';
import 'package:uddipan/app/modules/home/views/doctor_list_view.dart';
import 'package:uddipan/app/modules/home/views/widget/show_doctor_widget.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/utils/snippet.dart';

class TopRatedDoctorGridView extends StatelessWidget {
  const TopRatedDoctorGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Top Rated Doctor',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black)),
              GestureDetector(
                onTap: () {
                  Get.to(() => const DoctorListView());
                },
                child: Text('See All',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FutureBuilder(
            future: Get.put(DoctorController()).getAllDoctors(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    height: 130.h,
                    child: shimmerHorizontalList(itemHeight: 130.h));
              }
              return SizedBox(
                height: 130.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero,
                  // itemCount: 5,
                  itemCount:
                      Get.put(DoctorController()).doctorList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final doctorController = Get.put(DoctorController());
                    DoctorModel? doctorModel = doctorController.doctorList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: ShowDoctorWiget(
                          doctorModel: doctorModel, index: index),
                    );
                  },
                ),
              );
            })
      ],
    );
  }
}
