import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:uddipan/constants/string_constant.dart';

class ForgetPasswordController extends GetxController {
  final forgetEmailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  Future resetPassword() async {
    isLoading(true);
    var method = dio.Dio();
    var url = "$baseurl/user/reset-password";

    var response = await method.post(
      url,
      data: {
        "email": forgetEmailController.text,
        "password": passwordController.text,
        "token": getbox.read(userToken)
      },
    );
    isLoading(false);

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Password reset link sent to your email",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future forgetPassword() async {
    isLoading(true);
    var method = dio.Dio();
    var url = "$baseurl/user/forgot-password";

    var response = await method.post(
      url,
      data: {
        "email": forgetEmailController.text,
      },
    );
    isLoading(false);
    if (response.statusCode == 200) {
      Get.snackbar("Success", "Password reset link sent to your email",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Something went wrong",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    super.onClose();
    forgetEmailController.dispose();
  }
}
