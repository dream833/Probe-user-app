import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/constants/color_constant.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final Color? buttonColor;
  bool? isLoading;
  CustomButton({
    super.key,
    required this.onPress,
    required this.title,
    this.isLoading,
    this.buttonColor = const Color(0xff357960),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          child: isLoading ?? false
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.litt,
                  ),
                )),
    );
  }
}
