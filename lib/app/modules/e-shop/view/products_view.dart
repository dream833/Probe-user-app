import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/models/medicine_model.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final eshopController = Get.put(EShopController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SmallText(
            text: 'All Products',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              itemCount: eshopController.medicines.length,
              itemBuilder: (context, index) {
                MedicineModel? medicine = eshopController.medicineList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          DisplayImageWidget(
                              color: appPrimaryColor,
                              height: 58,
                              width: 58,
                              child: Image.network(medicine!.image)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SmallText(
                                      text: medicine.name,
                                      textColor: Colors.grey.shade700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizedBox(width: 5),
                                    SmallText(
                                      text: "(${medicine.dosage})",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.grey.shade700,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  medicine.description,
                                  style: const TextStyle(fontSize: 10),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 15,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    const SizedBox(width: 5),
                                    const SmallText(
                                        fontSize: 12, text: "(4.0)"),
                                    const SizedBox(width: 5),
                                    const SmallText(
                                        fontSize: 11, text: "(1570 ratings)"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SmallText(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      text: "\$ ${medicine.price.toString()}",
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Discount',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      '40%',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
   
   
    );
  }
}
