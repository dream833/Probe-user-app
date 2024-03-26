import 'package:get/get.dart';
import 'package:uddipan/app/modules/forget_password/controller/forget_password_controller.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController());
  }

}
