import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';


class AppLoading {
  static appLoading1() {
    Get.dialog(
      const Center(
        child: SpinKitWave(
          color: Colors.red,
          size: 30,
        ),
      ),
      barrierDismissible: false,
    );
  }

  static appLoading2() {
    Get.dialog(
      const Center(
        child: SpinKitWave(
          color: Colors.red,
          size: 30,
        ),
      ),
      barrierDismissible: false,
    );
  }

  static appLoading3() {
    Get.dialog(

      const Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size: 60,
          // itemBuilder: (context, index){
          //   return DecoratedBox(
          //     decoration: BoxDecoration(
          //       // color: index.is
          //     ),
          //   );
          // },
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void closeLoadingDialog() {
    Get.back();
  }

  // static appLoading2 (){
  //   Get.defaultDialog(
  //     backgroundColor: Colors.transparent,
  //     content: SpinKitWave(
  //       color: Colors.red,
  //       size: 30,
  //     ),
  //   );
  // }
}
