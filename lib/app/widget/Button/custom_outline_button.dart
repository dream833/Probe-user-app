import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/constants/color_constant.dart';
class CustomOutlineButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final double? height;
  const CustomOutlineButton({super.key, required this.onPress, required this.title, this.height = 45,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 16.w,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              width: 2,
              color: AppColor.borderColor1,
            )
        ),
        child: Center(
          child: SmallText(text: title,),
        ),
      ),
    );
  }
}
