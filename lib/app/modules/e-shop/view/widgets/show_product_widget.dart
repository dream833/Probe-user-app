import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/e-shop/view/product_detail_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/models/medicine_model.dart';

class ShowProductWidget extends StatelessWidget {
  final MedicineModel medicine;

  const ShowProductWidget({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(()=>ProductDetailView(model: medicine));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 14, right: 20),
        child: Container(
          width: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0, 0),
                spreadRadius: 0.5,
                blurRadius: 5,
              )
            ],
            borderRadius: const BorderRadius.all(
              Radius.circular(17),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 161,
                    width: 271,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      image: DecorationImage(
                        
                        image: NetworkImage(medicine.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                  ),
                  Container(
                    height: 161,
                    width: 271,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 13,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(7),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 11),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                    SmallText(
                      text: medicine.name,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    const SizedBox(width: 5),
                    const SmallText(fontSize: 12, text: "(4.0)"),
                    const SizedBox(width: 5),
                    const SmallText(fontSize: 11, text: "(1570 ratings)"),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      text: "BDT ${medicine.price.toString()}",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: appColorPrimary, // Change color as needed
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
