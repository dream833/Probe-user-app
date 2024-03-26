import 'package:flutter/material.dart';

import 'big_text.dart';

class TitleAndViewAllText extends StatelessWidget {

  final String title;
  final String viewAllText;
  final VoidCallback onPress;
  const TitleAndViewAllText({super.key, required this.title, this.viewAllText = "View All", required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BigText(text: title,
            fontWeight: FontWeight.bold,
          ),
          GestureDetector(
            onTap: onPress,
            child: BigText(
              text: viewAllText,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              textColor: Colors.blue.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
