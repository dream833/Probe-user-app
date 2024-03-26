import 'package:flutter/material.dart';

class CustomAssetImage extends StatelessWidget {
  final String assetPath;
  final double? height;
  final double? width;
  const CustomAssetImage({super.key, required this.assetPath, this.height = 24, this.width = 24});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }
}
