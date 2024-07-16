import 'package:get/get.dart';

import '../controller/diagnostic_controller.dart';

class DiagnosticBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiagnosticController>(() => DiagnosticController());
  }
}
