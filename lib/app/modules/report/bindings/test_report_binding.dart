import 'package:get/get.dart';
import 'package:uddipan/app/modules/report/controller/report_controller.dart';

class TestReportBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ReportController>(() => ReportController());
  }

}