import 'package:get/get.dart';
import 'package:uddipan/app/modules/profile/controllers/member_controller.dart';

class MemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemberController>(() => MemberController());
  }
}
