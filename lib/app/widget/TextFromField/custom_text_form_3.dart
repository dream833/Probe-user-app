import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/widget/Text/bold_text.dart';


class CustomTextFormField3 extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final String? hintText;
  final String? labelText;
  final bool isObsecure;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final VoidCallback? onPressSuffix;
  const CustomTextFormField3({
    super.key,
    required this.controller,
    this.title = "Title",
    this.hintText,
    this.labelText,
    this.isObsecure = false,
    this.keyboardType,
    this.suffixIcon,
    this.onPressSuffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, left: 16.w, right: 16.w),
      padding: EdgeInsets.only(left: 10.w, top: 5.h, bottom: 8.h, right: 10.w,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white70,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoldText(
            text: title!,
            fontSize: 14.sp,
          ),
          SizedBox(height: 5.h),
          TextFormField(
            keyboardType: keyboardType,
            controller: controller,
            obscureText: isObsecure,
            style: GoogleFonts.lato(
              fontSize: 12.sp,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w,),
              filled: true,
              fillColor: Colors.grey.shade100,
              hintText: hintText,
              suffixIcon: GestureDetector(
                onTap: onPressSuffix,
                child: Icon(
                  suffixIcon,
                  size: 18.sp,
                ),
              ),
              hintStyle: GoogleFonts.lato(
                fontSize: 12.sp,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
