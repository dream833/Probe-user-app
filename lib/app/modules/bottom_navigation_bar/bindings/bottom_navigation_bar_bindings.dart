import 'package:get/get.dart';
import 'package:uddipan/app/modules/bottom_navigation_bar/controllers/bottom_navigation_bar_controllers.dart';

class BottomNavigationBarBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationBarControllers>(
        () => BottomNavigationBarControllers());
  }
}
