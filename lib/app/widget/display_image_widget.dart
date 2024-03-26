import 'package:flutter/material.dart';

class DisplayImageWidget extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final Color color;
  const DisplayImageWidget(
      {super.key,
      required this.child,
      required this.color,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFDFDFDF)),
        shape: BoxShape.circle,
      ),
      child: Container(
          height: height,
          width: width,
          
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: child,
          )),
    );
  }
}
