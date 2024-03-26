import 'package:flutter/material.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/constants/color_constant.dart';


class CustomRoundedButton extends StatelessWidget {

  final VoidCallback onPress;
  final bool? isLoading;
  final String title;
  final Color? textColor;
  final double? height;
  final double? fontSize;

  const CustomRoundedButton({
    super.key,
    required this.onPress,
    this.isLoading = false,
    required this.title,
    this.textColor = Colors.white,
    this.height = 45, this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppColor.borderColor1,
        ),
        child: Center(
          child: SmallText(
            text: title,
            textColor: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
