import 'package:flutter/material.dart';

class ShowStatusWidget extends StatelessWidget {
  final Color color;
  final String text;
  const ShowStatusWidget({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6)),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.circle, size: 10, color: color),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 13, color: color),
              ),
            )
          ]),
    );
  }
}
