import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uddipan/app/modules/favourite/favourite_doctor_list.dart';
import 'package:uddipan/app/modules/favourite/view/fav_hospital_list.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import '../../../../constants/color_constant.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.mainBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.mainBackgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          title: SmallText(
              text: 'Favourite',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: Colors.grey.shade700),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.h),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
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
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 1,
                indicator: BoxDecoration(
                  color: appColorPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                tabs: [
                  _buildTab("Doctor", FontAwesomeIcons.userDoctor),
                  _buildTab("Hospital", Icons.local_hospital),
                ],
              ),
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: TabBarView(
            children: [
              FavouriteDoctorList(),
              FavHospitalList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, IconData icon) {
    return SizedBox(
      height: 35.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(width: 8.w),
          Text(
            text,
            style: GoogleFonts.raleway(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
