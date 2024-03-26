// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:uddipan/app/modules/prescription/view/prescription_list_view.dart';
// import 'package:uddipan/app/modules/profile/widgets/test_report_widget.dart';
// import 'package:uddipan/app/modules/report/view/add_report_view.dart';

// import 'package:uddipan/app/widget/Text/small_text.dart';

// import '../../../../constants/color_constant.dart';

// class ReportsView extends StatelessWidget {
//   const ReportsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: AppColor.mainBackgroundColor,
//         appBar: AppBar(
//           backgroundColor: AppColor.mainBackgroundColor,
//           centerTitle: true,
//           elevation: 0,
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: GestureDetector(
//                 onTap: () {
//                   Get.to(() => const AddReportView());
//                 },
//                 child: Container(
//                   height: 35,
//                   width: 38,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: appColorPrimary,
//                   ),
//                   child: const Icon(
//                     Icons.add,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//           title: const SmallText(
//               text: 'Reports',
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               textColor: Colors.black),
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(40.h),
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 12.w),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color.fromRGBO(0, 0, 0, 0.15),
//                     offset: Offset(-1, 1),
//                     blurRadius: 10,
//                   )
//                 ],
//               ),
//               child: TabBar(
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.grey,
//                 indicatorWeight: 1,
//                 indicator: BoxDecoration(
//                   color: appColorPrimary,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 tabs: [
//                   _buildTab("Prescriptions", FontAwesomeIcons.pencil),
//                   _buildTab("Reports", Icons.document_scanner),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: const Padding(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           child: TabBarView(
//             children: [
//               PrescriptionListView(index: 0),
//               TestReportWidget(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTab(String text, IconData icon) {
//     return SizedBox(
//       height: 35.h,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 19,
//           ),
//           SizedBox(width: 7.w),
//           Text(
//             text,
//             style: GoogleFonts.raleway(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
