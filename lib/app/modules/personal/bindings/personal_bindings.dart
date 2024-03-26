import 'package:get/get.dart';

import '../controller/personal_controller.dart';

class PersonalBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<PersonalController>(() => PersonalController());
  }

}