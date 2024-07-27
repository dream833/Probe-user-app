import 'dart:developer';
import 'package:get/get.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/utils/custom_message.dart';

import '../../../../api/network_service_api.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/Dialog/loading_dialog.dart';
import 'package:flutter/material.dart';

class ChangePasswordController extends GetxController {
  final networkApi = NetworkApiServices();

  final isOldPasswordVisible = true.obs;
  final isNewPasswordVisible = true.obs;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  changePassword() async {
    try {
      if (oldPasswordController.text.isEmpty &&
          newPasswordController.text.isEmpty) {
        CustomMessage.showSnackBar("Fill-up all the information");
      } else {
        AppLoading.appLoading3();
        var data = {
          'old_password': oldPasswordController.text,
          'new_password': newPasswordController.text,
        };

        var response = await networkApi.putApi(
          endpoint: 'users/update-password',
          data: data,
        );
        if (response.statusCode == 200) {
          if (response.data['message'] == "Incorrect old password") {
            Future.delayed(const Duration(milliseconds: 500), () {
              CustomMessage.showSnackBar("Incorrect old password");
            });
          } else {
            getbox.remove(userLogin);
            getbox.remove(userEmail);
            getbox.remove(userId);
            getbox.remove(isUserLoggedIN);
            getbox.remove(userToken);

            Future.delayed(const Duration(milliseconds: 500), () {
              CustomMessage.showSuccessSnackBar("Password Change Successful");
              Get.offAllNamed(Routes.LOGIN);
            });
          }
        } else {
          log(response.statusCode.toString());
          AppLoading.closeLoadingDialog();
        }
      }
    } catch (e) {
      log("Error: $e");
    }
  }
}
