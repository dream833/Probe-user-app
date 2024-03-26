import 'package:get/get.dart';
import 'package:uddipan/app/modules/splash/controller/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SplashController>(() => SplashController());
  }

}