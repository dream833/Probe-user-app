import 'package:get/get.dart';
import 'package:uddipan/app/modules/hospital/controller/hospital_controller.dart';

class HospitalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HospitalController>(() => HospitalController());
  }
}
