import 'package:get/get.dart';

import '../controllers/new_test_page_controller.dart';

class NewTestPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewTestPageController>(
      () => NewTestPageController(),
    );
  }
}
