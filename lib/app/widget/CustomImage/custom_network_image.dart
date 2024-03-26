import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  const CustomNetworkImage({super.key, required this.imageUrl, this.height = 100, this.width = 100});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }
}
