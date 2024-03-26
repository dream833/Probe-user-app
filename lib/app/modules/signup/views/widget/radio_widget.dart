import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widget/Text/bold_text.dart';

class RadioForm extends StatelessWidget {
  final String title;
  final Widget widget;
  const RadioForm({super.key, required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: BoldText(text: title,),
          ),
          SizedBox(width: 8.w,),
          Expanded(
            flex: 5,
            child: widget,
          ),
        ],
      ),
    );
  }
}
