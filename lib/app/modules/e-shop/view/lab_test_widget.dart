import 'package:flutter/material.dart';

class LabTestWidget extends StatelessWidget {
  String title;
  String image;
  String type;
  VoidCallback onTap;
  LabTestWidget(
      {super.key,
      required this.title,
      required this.image,
      required this.type,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            Container(
                height: 130,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(19),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(image)))),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.5,
                        color: Colors.black),
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '   Start   ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const Divider(
              thickness: 1.4,
            )
          ],
        ),
      ),
    );
  }
}
