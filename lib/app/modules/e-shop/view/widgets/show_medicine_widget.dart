import 'package:flutter/material.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';

import 'package:uddipan/models/medicine_model.dart';

class ShowMedicineWidget extends StatelessWidget {
  final MedicineModel? model;
  const ShowMedicineWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(-1, 1),
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: DisplayImageWidget(
            color: appPrimaryColor,
            height: 60,
            width: 60,
            child: Center(
                child: SmallText(
              text: model!.name[0],
              textColor: Colors.white,
              fontSize: 14,
            ))),
        title: SmallText(
          text: model!.name,
          textColor: Colors.grey.shade700,
          fontSize: 14,
        ),
        subtitle: SmallText(
          text: model!.name,
          textColor: Colors.grey.shade700,
          fontSize: 12,
        ),
      ),
    );
  }
}
