import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/home/views/widget/specialist_categories.dart';
import 'package:uddipan/app/modules/home/views/widget/top_rated_doctors_widget.dart';
import 'package:uddipan/app/modules/notification/controllers/notification_controller.dart';
import 'package:uddipan/app/modules/notification/view/notifiication_view.dart';
import 'package:uddipan/app/modules/profile/controllers/profile_controller.dart';
import 'package:uddipan/app/widget/Text/big_text.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/routes/app_pages.dart';
import 'package:uddipan/utils/snippet.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(height: 10),
              CustomAppBarWidget(),
              SizedBox(height: 20),
              SizedBox(height: 20),
              ShowSpecialistCategories(),
              SizedBox(height: 30),
              TopRatedDoctorGridView(),
              SizedBox(height: 20),
              // RecentTransactionWidget(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBarWidget extends StatefulWidget {
  const CustomAppBarWidget({super.key});

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  late NotificationController controller;
  late ProfileController profileController;

  @override
  void initState() {
    controller = Get.put(NotificationController());
    controller.getUnReadNotificationCount();
    profileController = Get.put(ProfileController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.profilePage);
              },
              child: DisplayImageWidget(
                height: 50,
                width: 50,
                color: Colors.white,
                child:
                    Get.find<ProfileController>().userModel.value?.image != null
                        ? Image.network(
                            Get.find<ProfileController>()
                                .userModel
                                .value!
                                .image
                                .toString(),
                          )
                        : const Icon(Icons.person),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => BigText(
                      text: 'Hi, ${profileController.name.value} ',
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      textColor: appPrimaryColor,
                    ),
                  ),
                  SmallText(
                    text: getGreeting(),
                    textColor: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.favouritePage);
              },
              child: Container(
                height: 35,
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: appPrimaryColor,
                ),
                child: const Icon(
                  Icons.favorite_outline_sharp,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Get.to(() => const NotificationView());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 0, bottom: 10),
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -10, end: -12),
                  ignorePointer: false,
                  onTap: () {},
                  badgeContent: Obx(() => Text(
                        controller.notificationCounter.value.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.white),
                      )),
                  badgeAnimation: const badges.BadgeAnimation.rotation(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: appColorRed,
                  ),
                  child: const Icon(
                    FontAwesomeIcons.bell,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
