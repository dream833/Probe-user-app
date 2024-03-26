import 'package:get/get.dart';

import '../controller/health_controller.dart';

class HealthBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HealthController>(() => HealthController());
  }

}