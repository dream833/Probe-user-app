import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<NotificationController>(() => NotificationController());
  }

}
