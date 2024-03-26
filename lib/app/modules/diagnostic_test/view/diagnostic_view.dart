import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/diagnostic_test/new_booked_test_view.dart';
import 'package:uddipan/app/modules/diagnostic_test/previous_booked_test_view.dart';
import 'package:uddipan/constants/color_constant.dart';

import '../../../widget/Text/small_text.dart';
import '../../e-shop/controller/eshop_controller.dart';

class DiagnosticTestView extends StatelessWidget {
  const DiagnosticTestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eshopController = Get.put(EShopController());
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 1000),
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: SmallText(
              text: 'Diagostic Test',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textColor: Colors.grey.shade700),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
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
                  _buildTab("New Booked", FontAwesomeIcons.vial),
                  _buildTab("Previous Test", FontAwesomeIcons.vialCircleCheck),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            NewBookedTest(),
            PreviousBookedTest(),
          ],
        ),
      ),
    );
  }
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
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
