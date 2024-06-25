import 'dart:developer';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/appointments/view/appointment_view.dart';
import 'package:uddipan/app/modules/bottom_navigation_bar/controllers/bottom_navigation_bar_controllers.dart';
import 'package:uddipan/app/modules/e-shop/view/eshop_view.dart';
import 'package:uddipan/app/modules/emergency/view/emergency_view.dart';
import 'package:uddipan/app/modules/home/views/home_view.dart';
import 'package:uddipan/app/modules/profile/controllers/profile_controller.dart';
import 'package:uddipan/app/modules/services/view/services_view.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';

// ignore: must_be_immutable
class BottomNavigationBarView extends GetView<BottomNavigationBarControllers> {
  int? routeIndex;
  BottomNavigationBarView({super.key, this.routeIndex});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationBarControllers());
    final profileController = Get.put(ProfileController());
    if (routeIndex != null) controller.changeTabIndex(routeIndex!);
    return Obx(
      () {
        log('controller.selectedIndex.value ${controller.selectedIndex.value.toString()}');
        return Scaffold(
          body: Center(
            child: Obx(
              () {
                log('controller.selectedIndex.value ${routeIndex != 0 ? routeIndex : controller.selectedIndex.value}');
                return _buildPage(controller.selectedIndex.value);
              },
            ),
          ),
          bottomNavigationBar: BottomBarInspiredFancy(
              animated: true,
              curve: Curves.bounceIn,
              top: 15,
              bottom: 5,
              enableShadow: false,
              iconSize: 30,
              titleStyle: CustomFont.regularText
                  .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              items: items,
              backgroundColor: Colors.white,
              color: Colors.black,
              colorSelected: appColorPrimary,
              indexSelected: controller.selectedIndex.value,
              styleIconFooter: StyleIconFooter.dot,
              onTap: (index) {
                routeIndex = 0;
                controller.changeTabIndex(index);
              }),
        );
      },
    );
  }

  List<TabItem> items = const [
    TabItem(
      icon: Icons.home_rounded,
      // title: 'Home',
    ),
    TabItem(
      icon: Icons.schedule_rounded,
      // title: 'Appointment',
    ),
    TabItem(
      icon: Icons.medical_services,
      // title: 'Perscription',
    ),
    TabItem(
      icon: Icons.shop,
      // title: 'Profile',
    ),
    TabItem(
      icon: Icons.emergency,
      // title: 'Profile',
    ),
  ];
  Widget _buildPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const HomeView();
      case 1:
        return const AppointmentView();
      case 2:
        return const ServicesView();
      case 3:
        return const EShopView();

      default:
        return const EmergencyView();
    }
  }
}
