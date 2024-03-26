import 'package:get/get.dart';

import '../controller/doctor_controller.dart';

class DoctorBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DoctorController>(() => DoctorController());
  }

}