import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/constants/color_constant.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final bool? readOnly;
  final TextEditingController? controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final IconData? suffixIcon2;
  late bool isVisible;
  final String? imagePath;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final Colors? color;
  final String? labelText;
  final TextInputType? inputType;
  final Color? prefixIconColor;
  final void Function()? onTap;
  final int? maxLine;
  final Color? fillerColor;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  final double? prefixIconSize;

  CustomTextField({
    super.key,
    this.onTap,
    this.imagePath,
    this.readOnly,
    this.isVisible = false,
    this.labelText,
    required this.hintText,
    this.prefixIconSize,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.color,
    this.fillerColor,
    this.maxLine,
    this.onChanged,
    this.controller,
    this.prefixIconColor,
    this.inputType,
    this.suffixIcon2,
    this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(-1, 1),
            blurRadius: 10,
          )
        ],
      ),
      child: TextField(
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 48, 46, 46),
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        maxLength: widget.maxLength,
        // textInputAction: TextInputAction.ne,
        maxLines: widget.maxLine,
        readOnly: widget.readOnly ?? false,
        onTap: widget.onTap,

        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText: widget.isVisible,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged ?? (value) {},
        decoration: InputDecoration(
          contentPadding: widget.prefixIcon == null
              ? const EdgeInsets.only(left: 24, top: 15)
              : const EdgeInsets.only(top: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          isDense: true,
          hintText: widget.hintText,
          labelStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: AppColor().appPrimaryColor, fontSize: 14),

          hintStyle: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 16,
          ),

          // hintStyle: Theme.of(context)
          //     .textTheme
          //     .titleSmall!
          //     .copyWith(color: Colors.grey, fontSize: 14),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  size: widget.prefixIconSize ?? 24,
                  color: widget.prefixIconColor ?? const Color(0xFF2E2E2E),
                )
              : null,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                widget.isVisible = !widget.isVisible;
              });
            },
            child: Icon(
              widget.isVisible ? widget.suffixIcon2 : widget.suffixIcon,
              color: Colors.grey,
              size: 18,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }
}
