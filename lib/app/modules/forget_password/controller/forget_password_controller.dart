import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final forgetEmailController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    forgetEmailController.dispose();
  }
}
