
import 'package:flutter/material.dart';

class CircularImageView extends StatelessWidget {
  final Image child;
  final double size;

  const CircularImageView({Key? key, required this.child, this.size = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade700,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(size),
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: child,
        ),
      ),
    );
  }
}
