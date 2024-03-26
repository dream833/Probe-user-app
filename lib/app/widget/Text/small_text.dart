import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final int? maxLine;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const SmallText({
    super.key,
    required this.text,
    this.maxLine = 1,
    this.fontSize = 12,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight??FontWeight.w500,
        color: textColor ?? Colors.white,
        fontSize: fontSize??16
      ),
    );
  }
}
