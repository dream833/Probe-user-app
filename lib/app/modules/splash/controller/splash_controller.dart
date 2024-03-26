import 'package:get/get.dart';

import 'package:uddipan/main_auth.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    pushToMainAuth();
  }

  pushToMainAuth() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offAll(() => const MainAuth());
    });
  }
}
