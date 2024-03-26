import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/doctor/controller/doctor_controller.dart';
import 'package:uddipan/app/modules/favourite/view/widgets/fav_doctor_widget.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/utils/snippet.dart';

class FavouriteDoctorList extends StatelessWidget {
  const FavouriteDoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),

          FutureBuilder(
                      future: Get.put(DoctorController()).getAllDoctors(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return shimmerListEffect(
                              itemBorderRadius: 16, itemCount: 10);
                        }
                        return Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: controller.favouriteDoctors.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                // Find the corresponding doctor in the doctorList using the doctor's ID
                DoctorModel? matchedDoctor = controller.doctorList.firstWhere(
                  (doctor) =>
                      doctor!.id == controller.favouriteDoctors[index]!.id,
                  orElse: () => null,
                );
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child:
                      FavDoctorWidget(doctorModel: matchedDoctor, index: index),
                );
              },
            ));
                      }),
         
        ],
      ),
    ));
  }
}
