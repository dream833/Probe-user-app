import 'package:get/get.dart';

import '../controller/diagnostic_controller.dart';

class DiagnosticBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DiagnosticController>(() => DiagnosticController());
  }

}