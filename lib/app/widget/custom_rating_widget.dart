import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingWidget extends StatelessWidget {
  final double averageRating;
  const CustomRatingWidget({super.key, required this.averageRating});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      unratedColor: Colors.grey.shade300,
      initialRating: averageRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 15,
      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        size: 30,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
