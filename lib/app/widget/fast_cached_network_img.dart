import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

class FastCachedImgWidget extends StatelessWidget {
  final String url;
  final double radius;
  final double? height;
  final double? width;
  const FastCachedImgWidget(
      {Key? key, required this.url, this.radius = 60, this.height, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height??45,
      width: width??45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: FastCachedImage(
          url: url,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
