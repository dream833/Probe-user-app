import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';

import 'package:uddipan/models/medicine_model.dart';
import 'package:uddipan/utils/snippet.dart';

class MedicineDetailView extends StatelessWidget {
  final MedicineModel? model;
  const MedicineDetailView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eshopController = Get.put(EShopController());
    return Scaffold(
        appBar: AppBar(
          title: SmallText(
              text: 'Medicine Detail',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: Colors.grey.shade700),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: DisplayImageWidget(
                      color: Colors.white,
                      height: 100,
                      width: 100,
                      child: Image.network(
                        model!.image,
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(height: 10),
                _showMedicineInfo(title: 'Medicine', data: "* ${model!.name}"),
                const SizedBox(height: 20),
                _showMedicineInfo(
                    title: 'Medicine Type', data: "* ${model!.type.name}"),
                const SizedBox(height: 20),
                _showMedicineInfo(
                    title: 'Company', data: "* ${model!.company}"),
                const SizedBox(height: 20),
                _showMedicineInfo(
                    title: 'Price', data: "* ${model!.price.toString()}"),
                const SizedBox(height: 20),
                _showMedicineInfo(
                    title: 'Expiry Date',
                    data: "* ${formatDate(model?.expiryDate)}"),
                const SizedBox(height: 20),
                _showMedicineInfo(title: 'Dosage', data: "* ${model?.dosage}"),
                const SizedBox(height: 20),
                _showMedicineInfo(
                    title: 'Chemical', data: "* ${model?.chemicalName}"),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SmallText(
                        text: 'Side Affects',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: Color.fromARGB(255, 110, 100, 100)),
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: model?.sideEffects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text("* ${model?.sideEffects[index] ?? ''}"),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SmallText(
                        text: 'Description',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: Color.fromARGB(255, 110, 100, 100)),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${model?.description}"),
                  ),
                ),
                const SizedBox(height: 20),
                LoaderButton(
                    color: appColorPrimary,
                    btnText: 'Add To Cart',
                    onTap: () async {
                      if (model != null) {
                        bool isProduct = eshopController.addProduct(model!);
                        
                      }
                    }),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ));
  }

  Column _showMedicineInfo({required String title, required String data}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SmallText(
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: const Color.fromARGB(255, 110, 100, 100)),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Align(alignment: Alignment.centerLeft, child: Text(data)),
        ),
      ],
    );
  }

  Container _medicineInfo(
      {required String title, required String data, required IconData icon}) {
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
        title: SmallText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: Colors.black),
        subtitle: Text(data,
            style: CustomFont.regularText.copyWith(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500)),
        leading: CircleAvatar(
          backgroundColor: appPrimaryColor,
          radius: 18,
          child: CircleAvatar(
            backgroundColor: appPrimaryColor,
            radius: 18,
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}

/*

ListTile(
                    title: Text(
                      'Company',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(model?.company ?? 'N/A'),
                    leading: Icon(Icons.business),
                  ),
                  ListTile(
                    title: Text(
                      'Price',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(model?.price.toStringAsFixed(2) ?? 'N/A'),
                    leading: Icon(Icons.attach_money),
                  ),
                  ListTile(
                    title: Text(
                      'Dosage',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(model?.dosage ?? 'N/A'),
                    leading: Icon(Icons.local_hospital),
                  ),
                  ListTile(
                    title: Text(
                      'Description',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(model?.description ?? 'N/A'),
                    leading: Icon(Icons.description),
                  ),
*/
