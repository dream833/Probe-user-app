import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final int? maxLine;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  const BigText({
    super.key,
    required this.text,
    this.maxLine = 1,
    this.fontSize = 18,
    this.textColor = Colors.black,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
      ),
    );
  }
}

