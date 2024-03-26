
import 'package:flutter/material.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/constants/color_constant.dart';


class ShowPatientData extends StatelessWidget {
  final String data;
  final IconData iconData;

  const ShowPatientData({Key? key, required this.data,required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: appPrimaryColor,
          radius: 18,
          child: CircleAvatar(
            backgroundColor: appPrimaryColor,
            radius: 13,
            child:  Icon(iconData, color: Colors.white, size: 20),
          ),
        ),
        const SizedBox(width: 20),
        SmallText(
          text: data,
          fontSize: 15,
          textColor:Colors.grey.shade700,
        ),
      ],
    );
  }
}
