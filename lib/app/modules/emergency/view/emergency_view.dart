import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/emergency/controller/emergency_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';

class EmergencyView extends GetView<EmergencyController> {
  const EmergencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        backgroundColor: Colors.white,
        title: SmallText(
            text: 'Emergency',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
      ),
    );
  }
}
