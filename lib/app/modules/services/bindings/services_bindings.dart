import 'package:get/get.dart';

import '../controller/services_controllers.dart';

class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ServicesController>(() => ServicesController());
  }

}