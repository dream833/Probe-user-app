import 'package:flutter/material.dart';
import 'package:uddipan/constants/color_constant.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextForm({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.secondaryGreen),
            borderRadius: BorderRadius.circular(8.0),
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
