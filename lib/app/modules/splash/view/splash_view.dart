import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/doctor/controller/doctor_controller.dart';
import '../../../../constants/image_contant.dart';
import 'package:uddipan/app/modules/splash/controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    final doctorController = Get.put(DoctorController());
    log('doctorController ${doctorController.toString()}');
    log('Splash Controller ${controller.toString()}');
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(AppImage.newLogo,height: 200,width: 200,)),
          
         
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
