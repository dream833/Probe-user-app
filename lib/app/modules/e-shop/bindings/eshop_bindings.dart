import 'package:get/get.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';

class EShopBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EShopController>(() => EShopController());
  }
}
