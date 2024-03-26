import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/notification/controllers/notification_controller.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/models/banner_model.dart';
import 'package:uddipan/models/specialization_category_model.dart';
import 'package:uddipan/utils/notification_handler.dart';

import '../../../../api/network_service_api.dart';
import '../../../../constants/image_contant.dart';

class HomeController extends GetxController {
  final networkServices = NetworkApiServices();
  RxInt carousalIndex = 0.obs;


  RxList<BannerModel> bannerList = <BannerModel>[].obs;
  RxList<SpecializationCategory> specializationCategory =
      <SpecializationCategory>[].obs;
  final isSpecializationLoading = false.obs;
  final isHorizontalView = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await handleNotification();
  }

  final count = 0.obs;

  setCarousalIndex(int index) {
    carousalIndex.value = index;
  }

  setSpecialistView() {
    isHorizontalView.value = !isHorizontalView.value;
  }

  final List<String> offerLists = [
    AppImage.offer1,
    AppImage.offer2,
    AppImage.offer3,
    AppImage.offer4,
    AppImage.offer5,
  ];
  void increment() => count.value++;

  final selectedIndex = 0.obs;

  toggleIndex(int index) {
    selectedIndex.value = index;
  }

  List<String> imageUrls = [
    AppImage.cover1,
    AppImage.cover2,
    AppImage.cover3,
    AppImage.cover4,
    AppImage.cover5,
  ].obs;

  final List<String> medicineList = [
    'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=2030&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://virinchihospitals.com/wp-content/uploads/2018/12/Compressed_Internal-medicine.jpg',
    'https://www.swlondoner.co.uk/wp-content/uploads/2021/08/poisoning-pill-bottle.jpeg',
  ];

  final RxInt currentPage = 0.obs;
  PageController pageController = PageController();

  void startAutoScroll() {
    Timer.periodic(const Duration(seconds: 6), (timer) {
      if (currentPage.value < bannerList.length - 1) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> getBannerList() async {
    try {
      String token = getbox.read(userToken);
      final uri = Uri.parse('$baseurl/user_banner');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        List<dynamic> bannerData = json.decode(response.body);
        List<BannerModel> banner =
            bannerData.map((json) => BannerModel.fromJson(json)).toList();
        bannerList.assignAll(banner);
        log('Banner list ${bannerList.length.toString()}');
      } else {
        log('error in fetching banner list');
      }
    } catch (error) {
      log("Error fetching getBannerList: $error");
    }
  }

  Future<void> getSpecializationCategories() async {
    try {
      String token = getbox.read(userToken);
      final uri = Uri.parse('$baseurl/get/user_category');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        List<SpecializationCategory> categories =
            list.map((json) => SpecializationCategory.fromJson(json)).toList();
        specializationCategory.assignAll(categories);
        log('specializationCategory list ${specializationCategory.length.toString()}');
      } else {
        log('error in fetching specializationCategory list');
      }
    } catch (error) {
      log("Error fetching specializationCategory: $error");
    }
  }

  Future<void> handleNotification() async {
    log('handleNotification');

    try {
      await LocalNotification.initialize();

      FirebaseMessaging.onMessage.listen((message) async {
        final notificaitonController = Get.find<NotificationController>();
      
        if (Platform.isAndroid) {
          notificaitonController.getUnReadNotificationCount();
          await LocalNotification.display(message);
        } else if (Platform.isIOS) {
          log('Platform is iOS');
          notificaitonController.getUnReadNotificationCount();
          await LocalNotification.display(message);
        } else {
          log('Platform is not identified.');
        }
      }).onError((e) {
        log('Error in onMessage ${e.toString()} ');
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) async {
        final notificaitonController = Get.find<NotificationController>();
        log('onMessageOpenedApp');
        if (Platform.isAndroid) {
          notificaitonController.getUnReadNotificationCount();
        } else if (Platform.isIOS) {
          log('Platform is iOS');
          notificaitonController.getUnReadNotificationCount();
          await LocalNotification.display(message);
        } else {
          log('Platform is not identified.');
        }
      });
    } catch (e) {
      log('Receive Error In Handle Notification');
    }
  }
}
