import 'package:get/get.dart';
import 'package:uddipan/app/modules/emergency/controller/emergency_controller.dart';

class EmergencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmergencyController>(() => EmergencyController());
  }
}
