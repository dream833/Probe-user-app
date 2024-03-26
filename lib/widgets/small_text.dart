import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  const SmallText({super.key, required this.title, this.fontSize = 13, this.fontWeight = FontWeight.w400, this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,

      ),
    );
  }
}
