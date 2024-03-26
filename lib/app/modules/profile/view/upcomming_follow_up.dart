import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/doctor/controller/doctor_controller.dart';
import 'package:uddipan/app/modules/home/views/widget/show_doctor_widget.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/utils/snippet.dart';

class UpcommingFollowUp extends StatelessWidget {
  const UpcommingFollowUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const SmallText(
            text: 'Upcomming Follow Up',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            FutureBuilder(
                future: Get.put(DoctorController()).getAllDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return shimmerListEffect(
                        itemBorderRadius: 16, itemCount: 10);
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
                      final doctorController = Get.put(DoctorController());
                      DoctorModel? doctorModel = doctorController.doctorList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: ShowDoctorWiget(
                            doctorModel: doctorModel, index: index),
                      );
                    },
                  );
                })
          ]),
        ),
      ),
    );
  }
}
