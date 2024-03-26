import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/favourite/controller/favourite_controller.dart';
import 'package:uddipan/app/modules/favourite/view/widgets/fav_hospital_widget.dart';
import 'package:uddipan/utils/snippet.dart';

class FavHospitalList extends StatelessWidget {
  const FavHospitalList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 10),
          FutureBuilder(
              future: delayDuration(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return shimmerListEffect(itemBorderRadius: 16, itemCount: 10);
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  // itemCount:
                  //     Get.put(DoctorController()).list.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: FavHospitalWidget(
                          hospitalModel: controller.indianHospitals[index]),
                    );
                  },
                );
              })
        ]),
      ),
    );
  }
}
