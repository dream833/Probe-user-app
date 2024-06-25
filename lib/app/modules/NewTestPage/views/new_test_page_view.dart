import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/models/lab_test_models.dart';

import '../controllers/new_test_page_controller.dart';

class NewTestPageView extends GetView<NewTestPageController> {
  final DiagnosticTestName? diagnosticTestName;
  final DiagnosticPeName? diagnosticPeName;
  const NewTestPageView(
      {Key? key,
      required this.diagnosticTestName,
      required this.diagnosticPeName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(diagnosticTestName?.code ?? ""),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewTestPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
