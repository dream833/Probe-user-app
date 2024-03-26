import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/e-shop/controller/eshop_controller.dart';
import 'package:uddipan/app/modules/home/controllers/home_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/image_contant.dart';
import 'package:uddipan/models/medicine_model.dart';

class ProductDetailView extends StatelessWidget {
  final MedicineModel model;
  const ProductDetailView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final eshopController = Get.put(EShopController());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: whiteColor,
                ),
              ),
            ),
            title: const Row(
              children: [
                Spacer(),
                Icon(
                  Icons.shopping_bag_outlined,
                  color: whiteColor,
                ),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  _buildSlider(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.5), // Adjust opacity as needed
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SmallText(
                              text: model.name,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(width: 5),
                            SmallText(
                              text: '(${model.dosage})',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.star_rate_rounded,
                              color: yellowColor,
                            ),
                            const Text(
                              "(1570 reviews)",
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        _showMedicineInfo(
                            title: 'Company Name', data: "* ${model.company}"),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SmallText(
                                text: 'Side Affects',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const ScrollPhysics(),
                          itemCount: model.sideEffects.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("* ${model.sideEffects[index]}"),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
// Add To Cart
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SmallText(
                                text: 'Description',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(model.description),
                          ),
                        ),
                        // const SizedBox(height: ),
                        const SizedBox(height: 40),
                        const SmallText(
                          text: "Customer review",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SmallText(
                                      text: "4.5",
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 6),
                                      child: SmallText(
                                        text: " / 5",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 15, // Adjust the size of the star
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 2.0), // Adjust the padding
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  
                                  onRatingUpdate: (rating) {},
                                ),
                                const SmallText(
                                    textColor: greyColor,
                                    fontSize: 13,
                                    text: "1587 reviews")
                              ],
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Column(
                                children: [
                                  ProgressBarIndicator(
                                    number: "5",
                                    percentage: 72,
                                    value: 0.75,
                                    color: Colors.amber,
                                  ),
                                  ProgressBarIndicator(
                                    number: "4",
                                    percentage: 18,
                                    value: 0.35,
                                    color: Colors.amber,
                                  ),
                                  ProgressBarIndicator(
                                    number: "3",
                                    percentage: 5,
                                    value: 0.3,
                                    color: Colors.amber,
                                  ),
                                  ProgressBarIndicator(
                                    number: "2",
                                    percentage: 3,
                                    value: 0.09,
                                    color: Colors.amber,
                                  ),
                                  ProgressBarIndicator(
                                    number: "1",
                                    percentage: 1,
                                    value: 0.05,
                                    color: Colors.amber,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 50),
                        const SmallText(
                          text: "Top Reviews",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),

                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minHeight: 150),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(26),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: const Offset(0, 0),
                                            spreadRadius: 1,
                                            blurRadius: 5)
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: DisplayImageWidget(
                                                color: Colors.white,
                                                height: 58,
                                                width: 58,
                                                child: Image.asset(
                                                    AppImage.avatar)),
                                            title: const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 8),
                                                child: SmallText(
                                                  text: "Lisa John",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ),
                                          const SizedBox(height: 10),
                                          SmallText(
                                            text:
                                                "I recently tried ${model.name}, and it proved to be effective in relieving my pain and discomfort. The quick action and minimal side effects make it a go-to choice for me",
                                            maxLine: 5,
                                            fontSize: 13,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SmallText(fontSize: 15, text: "Total Price"),
                  // const SizedBox(height: 1),
                  SmallText(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      text: "BDT ${model.price}"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: LoaderButton(
                        btnText: "Add to cart",
                        onTap: () async {
                          eshopController.addProduct(model);
                        })),
              )
            ],
          )),
    );
  }
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
              fontSize: 15,
              fontWeight: FontWeight.bold,
              textColor: Colors.black),
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

Widget _buildSlider() {
  final controller = Get.find<HomeController>();
  return Stack(
    children: [
      PageView.builder(
        controller: controller.pageController,
        itemCount: controller.medicineList.length,
        onPageChanged: (index) {
          controller.currentPage.value = index;
        },
        itemBuilder: (context, index) {
          return Image.network(
            controller.medicineList[index],
            fit: BoxFit.cover,
          );
        },
      ),
      // Positioned(
      //   bottom: 20,
      //   right: 10,
      //   left: 10,
      //   child: Center(
      //     child: SmoothPageIndicator(
      //       controller: controller.pageController,
      //       count: controller.medicineList.length,
      //       effect: ExpandingDotsEffect(
      //         dotHeight: 8,
      //         dotWidth: 10,
      //         dotColor: Colors.white,
      //         activeDotColor: appColorPrimary,
      //       ),
      //     ),
      //   ),
      // ),
    ],
  );
}

class ProgressBarIndicator extends StatelessWidget {
  final String number;
  final int percentage;
  final double value;
  final Color color;
  const ProgressBarIndicator({
    super.key,
    required this.number,
    required this.percentage,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
          child: SmallText(
            text: number,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: value, // Set the progress value (0.0 to 1.0)
              backgroundColor: Colors.grey, // Set the background color
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 35,
          child: SmallText(
            text: "$percentage%",
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
