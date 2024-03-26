import 'package:flutter/material.dart';
import 'package:uddipan/constants/color_constant.dart';


class GenderWidget extends StatelessWidget {
  final VoidCallback onclick;
  final String title;
  final Image icon;

  final bool isSelected;

  const GenderWidget({super.key, 
    required this.isSelected,
    required this.onclick,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        
        decoration: BoxDecoration( color: isSelected
            ? AppColor.secondaryGreen.withOpacity(0.3)
            : null, //change color based on your need),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
          ],
        )),
      ),
    );
  }
}
