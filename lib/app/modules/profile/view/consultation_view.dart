import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/profile/view/past_consultation_view.dart';
import 'package:uddipan/app/modules/profile/view/upcomming_follow_up.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/constants/color_constant.dart';

class ConsultationView extends StatelessWidget {
  const ConsultationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const SmallText(
            text: 'Consultations',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
      ),
      body: Column(
        children: [
          _buildListTile(
              text: 'Past Consultations',
              icon: FontAwesomeIcons.history,
              iconSize: 19,
              onTap: () {
                Get.to(() => const PastConsultationView());
              }),
          const SizedBox(height: 10),
          _buildListTile(
              text: 'Upcoming Follow up ',
              icon: FontAwesomeIcons.calendar,
              iconSize: 19,
              onTap: () {
                Get.to(() => const UpcommingFollowUp());
              }),
          const SizedBox(height: 10),
          _buildListTile(
              text: 'Appointment Schedule',
              icon: FontAwesomeIcons.calendar,
              iconSize: 19,
              onTap: () {}),
        ],
      ),
    );
  }
}

_buildListTile(
    {required String text,
    required IconData icon,
    required double iconSize,
    required Function() onTap}) {
  return ListTile(
    onTap: () => onTap(),
    leading: Container(
        height: 40,
        width: 40,
        decoration:
            BoxDecoration(color: appColorPrimary, shape: BoxShape.circle),
        child: Icon(
          icon,
          color: Colors.white,
          size: iconSize,
        )),
    title: SmallText(
      text: text,
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      textColor: Colors.grey.shade700,
    ),
    trailing: Icon(
      Icons.arrow_forward_ios,
      size: 16.sp,
    ),
  );
}
