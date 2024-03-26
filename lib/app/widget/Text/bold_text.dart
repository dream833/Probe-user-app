import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoldText extends StatelessWidget {
  final String text;
  final int? maxLine;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  const BoldText({
    super.key,
    required this.text,
    this.maxLine = 1,
    this.fontSize = 18,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.lato(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
      ),
    );
  }
}

