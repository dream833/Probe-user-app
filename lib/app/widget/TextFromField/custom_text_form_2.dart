import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/constants/color_constant.dart';

class CustomTextFormField2 extends StatelessWidget {
  const CustomTextFormField2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.only(left: 20.w, right: 20.w,),
      child: TextFormField(
        style: GoogleFonts.lato(
          fontSize: 13.sp,
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 5.h,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.secondaryGreen),
            borderRadius: BorderRadius.circular(8.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
          hintText: 'Name',
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

