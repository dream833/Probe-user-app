import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/modules/e-shop/view/categories_view.dart';
import 'package:uddipan/app/modules/e-shop/view/lab_test_view.dart';
import 'package:uddipan/app/modules/e-shop/view/products_view.dart';
import 'package:uddipan/app/modules/e-shop/view/upload_prescription.dart';
import 'package:uddipan/app/modules/e-shop/view/widgets/show_product_widget.dart';
import 'package:uddipan/app/modules/home/controllers/home_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/cart_counter.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/models/medicine_model.dart';

class EShopView extends GetView<EShopController> {
  const EShopView({super.key});

  @override
  Widget build(BuildContext context) {
    final eshopController = Get.put(EShopController());

    eshopController.cartCount();
    print('------E -Shop-------');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SmallText(
            text: 'E-Shop',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: const [CartCounter()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(children: [
            const SizedBox(height: 30),
            CustomTextField(
                hintText: 'Search',
                prefixIcon: Icons.search,
                prefixIconColor: Colors.grey.shade700),
            const SizedBox(height: 30),
            _buildSlider(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const UploadPrescriptionView());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 150,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            offset: Offset(-1, 1),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.upload_file,
                              color: Colors.white,
                              size: 25,
                            ),
                            Text(
                              'Upload \nPrescription',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const LabTestView());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 150,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            offset: Offset(-1, 1),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 25,
                            ),
                            Text(
                              'Book Test',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                      text: 'Categories',
                      textColor: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const CategoriesView());
                    },
                    child: SmallText(
                        text: 'View All',
                        fontWeight: FontWeight.w600,
                        textColor: Colors.grey.shade700,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 255,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      // mainAxisExtent: 160,
                      childAspectRatio: 1),
                  shrinkWrap: true,
                  itemCount: 6,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => const CategoriesView());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
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
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(eshopController.iconList[index],
                                    color: appPrimaryColor),
                                SmallText(
                                  text: eshopController
                                      .categories[index].categoryName,
                                  fontSize: 12,
                                  textColor: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                      text: 'Explore Products',
                      textColor: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ProductsView());
                    },
                    child: SmallText(
                        text: 'View All',
                        fontWeight: FontWeight.w600,
                        textColor: Colors.grey.shade700,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: eshopController.medicineList.length,
                itemBuilder: (context, innerIndex) {
                  MedicineModel? medicine =
                      eshopController.medicineList[innerIndex];
                  return ShowProductWidget(medicine: medicine!);
                },
              ),
            ),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}

Widget _buildSlider() {
  final controller = Get.find<HomeController>();
  return Stack(
    children: [
      SizedBox(
        height: 130.h,
        child: PageView.builder(
          controller: controller.pageController,
          itemCount: controller.imageUrls.length,
          onPageChanged: (index) {
            controller.currentPage.value = index;
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        controller.offerLists[index],
                      )),
                ),
              ),
            );
          },
        ),
      ),
      Positioned(
        bottom: 20,
        right: 10,
        left: 10,
        child: Center(
          child: SmoothPageIndicator(
            controller: controller.pageController,
            count: controller.imageUrls.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Colors.white,
              activeDotColor: appColorPrimary,
            ),
          ),
        ),
      ),
    ],
  );
}
