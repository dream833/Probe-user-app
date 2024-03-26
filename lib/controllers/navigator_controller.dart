import 'package:get/get.dart';
import 'package:uddipan/app/modules/home/views/home_view.dart';
import 'package:uddipan/models/navigation_model.dart';

class NavigationController extends GetxController {
  static final defaultNav = NavigationModel(
    'Home',
    const HomeView(),
  );

  var active = defaultNav.obs;
  var navigationStack = [defaultNav].obs;

  void activate(NavigationModel model, {bool root = true}) {
    if (root) {
      navigationStack.removeLast();
      navigationStack.add(model);
    } else {
      navigationStack.add(model);
    }
    active.value = model;
  }

  void pop() {
    if (navigationStack.isNotEmpty) {
      navigationStack.removeLast();
      if (navigationStack.isNotEmpty) {
        active.value = navigationStack.last;
      } else {
        active.value = defaultNav;
      }
    }
  }

  bool canPop() {
    return navigationStack.length > 1;
  }

  final selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
