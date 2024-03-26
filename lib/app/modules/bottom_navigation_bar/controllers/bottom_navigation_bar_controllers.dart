import 'package:get/get.dart';

class BottomNavigationBarControllers extends GetxController {


  final selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
