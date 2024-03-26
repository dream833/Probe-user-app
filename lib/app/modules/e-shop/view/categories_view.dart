import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/modules/e-shop/view/products_view.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/theme_constant.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final eshopController = Get.put(EShopController());
    return Scaffold(
      appBar: AppBar(
        title: SmallText(
            text: 'All Categories',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => const ProductsView());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: boxShadow),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                DisplayImageWidget(
                                    color: appPrimaryColor,
                                    height: 58,
                                    width: 58,
                                    child: Icon(
                                      eshopController.iconList[index],
                                      color: Colors.white,
                                    )),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SmallText(
                                        text: eshopController
                                            .categories[index].categoryName,
                                        textColor: Colors.grey.shade700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        eshopController.categoriesInfo[index],
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey.shade700,
                                )
                              ],
                            ),
                          ],
                        ),
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
