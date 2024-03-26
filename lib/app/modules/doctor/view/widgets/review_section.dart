import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/doctor/controller/doctor_controller.dart';
import 'package:uddipan/app/modules/doctor/view/widgets/review_widget.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/models/user_model.dart';
import 'package:uddipan/utils/snippet.dart';

class ReviewSection extends StatefulWidget {
  final DoctorModel? doctorModel;
  const ReviewSection({super.key, required this.doctorModel});

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  late DoctorController doctorController;

  @override
  void initState() {
    doctorController = Get.put(DoctorController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => ListView.builder(
              shrinkWrap: true,
              itemCount: doctorController.reviewList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final review = doctorController.reviewList[index];
                return FutureBuilder<UserModel?>(
                    future: doctorController.getUserById(
                        userId: review!.userId ?? 0),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return shimmerListEffect();
                      }
                      return ReviewWidget(
                        doctorModel: widget.doctorModel,
                        reviewModel: review,
                        userModel: snapshot.data,
                      );
                    });
              }))
        ],
      ),
    );
  }
}
