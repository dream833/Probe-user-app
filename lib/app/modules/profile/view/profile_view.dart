import 'package:audioplayers/src/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/health/view/health_view.dart';
import 'package:uddipan/app/modules/prescription/view/prescription_list_view.dart';
import 'package:uddipan/app/modules/profile/controllers/profile_controller.dart';
import 'package:uddipan/app/modules/profile/view/consultation_view.dart';
import 'package:uddipan/app/modules/profile/view/edit_profile_view.dart';
import 'package:uddipan/app/modules/profile/view/members_view.dart';
import 'package:uddipan/app/modules/profile/widgets/logout_popup.dart';
import 'package:uddipan/app/modules/transactions/view/transaction_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';
import 'package:uddipan/routes/app_pages.dart';
import 'package:uddipan/utils/snippet.dart';

import '../../../widget/CustomImage/customAssetImage.dart';
import '../../report/view/report_view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    Future<void> playAudioFromAsset(String assetPath) async {
      await controller.audioPlayer.play(UrlSource(assetPath));
    }

    onRefresh() async {
      // await controller.audioPlayer.play(UrlSource());
      await Future.delayed(const Duration(milliseconds: 1000));
      playAudioFromAsset('assets/sounds/notification_sound1.wav');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 18,
            //     top: 30,
            //     right: 14,
            //     bottom: 14,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [

            //       BoldText(
            //         text: "Record",
            //         fontSize: 16,
            //         textColor: AppColor.apcolor,
            //       ),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       Row(
            //         children: [
            //           ProfileItemCard(
            //             onPress: () {},
            //             title: 'All Prescription',
            //             assetImage: AppImage.diagnosticTest,
            //           ),
            //           const SizedBox(
            //             width: 18,
            //           ),
            //           ProfileItemCard(
            //             onPress: () {
            //               Get.toNamed(Routes.testReportPage);
            //             },
            //             title: 'All Test Report',
            //             assetImage: AppImage.diagnosticTest,
            //           ),
            //           const SizedBox(
            //             width: 18,
            //           ),
            //           ProfileItemCard(
            //             onPress: () {},
            //             title: 'Health Record',
            //             assetImage: AppImage.diagnosticTest,
            //           ),
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       BoldText(
            //         text: "Consultations",
            //         fontSize: 16,
            //         textColor: AppColor.apcolor,
            //       ),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       Row(
            //         children: [
            //           ProfileItemCard(
            //             onPress: () {},
            //             title: 'Past Consultations',
            //             assetImage: AppImage.diagnosticTest,
            //           ),
            //           const SizedBox(
            //             width: 18,
            //           ),
            //           ProfileItemCard(
            //             onPress: () {},
            //             title: 'Upcoming Follow_up',
            //             assetImage: AppImage.diagnosticTest,
            //           ),
            //           const SizedBox(
            //             width: 18,
            //           ),
            //           ProfileItemCard(
            //             onPress: () {},
            //             title: 'Appointment Schedule',
            //             assetImage: AppImage.diagnosticTest,
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            Column(
              children: [
                _buildListTile(
                    icon: Icons.person,
                    iconSize: 25,
                    onTap: () {
                      Get.to(() => const EditProfileView());
                    },
                    text: 'Edit Profile'),
                const SizedBox(height: 10),
                _buildListTile(
                    icon: FontAwesomeIcons.users,
                    iconSize: 19,
                    onTap: () {
                      Get.to(() => const MembersView());
                    },
                    text: 'Members'),
                const SizedBox(height: 10),
                _buildListTile(
                    icon: FontAwesomeIcons.heartCircleCheck,
                    iconSize: 19,
                    onTap: () {
                      Get.to(() => const HealthView());
                    },
                    text: 'Health Profile'),
                const SizedBox(height: 10),
                _buildListTile(
                    icon: FontAwesomeIcons.filePdf,
                    iconSize: 19,
                    onTap: () {
                      Get.to(() => const ReportsView());
                    },
                    text: 'Reports'),
                const SizedBox(height: 10),
                _buildListTile(
                    icon: FontAwesomeIcons.kitMedical,
                    iconSize: 19,
                    onTap: () {
                      Get.to(() => const PrescriptionListView());
                    },
                    text: 'Prescriptions'),
                const SizedBox(height: 10),
                _buildListTile(
                    icon: FontAwesomeIcons.moneyBill,
                    iconSize: 19,
                    onTap: () {
                      Get.to(() => const AllTransactionView());
                    },
                    text: 'Transactions'),
                const SizedBox(height: 10),
                _buildListTile(
                    icon: FontAwesomeIcons.handshakeSimple,
                    iconSize: 19,
                    onTap: () {
                      Get.to(() => const ConsultationView());
                    },
                    text: 'Consultations'),
                const SizedBox(height: 10),
                _buildListTile(
                    icon: FontAwesomeIcons.lock,
                    iconSize: 19,
                    onTap: () {
                      Get.toNamed(Routes.changePassword);
                    },
                    text: 'Change Password'),
                const SizedBox(height: 10),
                _buildListTile(
                    icon: Icons.logout,
                    iconSize: 19,
                    onTap: () {
                      logoutPopup();
                    },
                    text: 'Logout'),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
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

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.mainBackgroundColor,
      title: Text(
        'Profile',
        style: TextStyle(
          color: AppColor.black,
        ),
      ),
      // backgroundColor: AppColor.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(
        color: AppColor.black,
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(130.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.mainBackgroundColor,
      height: preferredSize.height,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12.h, bottom: 10.h),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          color: AppColor.mainBackgroundColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.profilePage);
                },
                //profile image
                child: DisplayImageWidget(
                  color: Colors.white,
                  height: 70.h,
                  width: 70.w,
                  child: Image(
                    image: NetworkImage(
                      Get.find<ProfileController>()
                          .userModel
                          .value!
                          .image
                          .toString(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(getGreeting(), style: CustomFont.regularTextPoppins),
                    const SizedBox(height: 5),
                    Obx(
                      () => Text(Get.find<ProfileController>().name.value,
                          style: CustomFont.regularTextPoppins
                              .copyWith(fontSize: 13)),
                    ),
                    const SizedBox(height: 5),
                    Text(Get.find<ProfileController>().phoneNumber.value,
                        style: CustomFont.regularTextPoppins
                            .copyWith(fontSize: 12)),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItemCard extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final String assetImage;
  const ProfileItemCard({
    super.key,
    required this.title,
    required this.onPress,
    required this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: 100,
              // width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.apcolor,
              ),
              child: Image.asset(
                assetImage,
                width: double.maxFinite,
                height: 80,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SmallText(
              text: title,
              maxLine: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCardItem extends StatelessWidget {
  final String imageUrl, title;
  final VoidCallback onPress;
  const DashboardCardItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          CustomAssetImage(assetPath: imageUrl),
          const SizedBox(
            width: 10,
          ),
          SmallText(text: title),
        ],
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
      ),
    );
  }
}
