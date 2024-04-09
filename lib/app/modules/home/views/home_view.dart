import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:badges/badges.dart' as badges;
import 'package:uddipan/app/modules/home/views/widget/recent_transaction_widget.dart';
import 'package:uddipan/app/modules/home/views/widget/specialist_categories.dart';
import 'package:uddipan/app/modules/home/views/widget/top_rated_doctors_widget.dart';
import 'package:uddipan/app/modules/notification/controllers/notification_controller.dart';
import 'package:uddipan/app/modules/notification/view/notifiication_view.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/fast_cached_network_img.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/models/banner_model.dart';
import 'package:uddipan/routes/app_pages.dart';
import 'package:uddipan/utils/snippet.dart';
import '../../../../constants/image_contant.dart';
import 'package:uddipan/app/modules/profile/controllers/profile_controller.dart';
import 'package:uddipan/app/widget/Text/big_text.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import '../controllers/home_controller.dart';

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

  Widget _buildSlider() {
    final controller = Get.find<HomeController>();
    controller.getBannerList();
    return FutureBuilder(
        future: controller.getBannerList(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return sliderShimmer();
          }

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(-1, 1),
                      blurRadius: 10,
                    )
                  ],
                ),
                height: 130.h,
                width: double.infinity,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.bannerList.length,
                  onPageChanged: (index) {
                    controller.currentPage.value = index;
                  },
                  itemBuilder: (context, index) {
                    BannerModel? model = BannerModel.fromJson(
                        controller.bannerList[index].toJson());
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: FastCachedImgWidget(
                            url: model.image,
                            height: 200,
                            width: double.infinity,
                            radius: 0,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 10,
                          left: 10,
                          child: Center(
                            child: SmoothPageIndicator(
                              controller: controller.pageController,
                              count: controller.bannerList.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 10,
                                dotColor: Colors.white,
                                activeDotColor: appPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        });
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
                child: Image.asset(AppImage.avatar),
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
                      text: 'Hi, ${profileController.name.value}  ____ ,',
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
                  SizedBox(height: 5),
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
