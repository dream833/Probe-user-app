import 'package:get/get.dart';
import 'package:uddipan/app/modules/appointments/controller/appointment_controller.dart';

class AppointmentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentController>(() => AppointmentController());
  }
}
