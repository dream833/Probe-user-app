import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uddipan/app/widget/appbar/appbar_leading_icon.dart';
import 'package:uddipan/constants/color_constant.dart';

import '../../../../constants/image_contant.dart';

class TestReportView extends StatelessWidget {
  const TestReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      AppImage.splashImage,
      AppImage.splashImage,
      AppImage.splashImage,
      AppImage.splashImage,
      AppImage.splashImage,
      AppImage.splashImage,
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBarLeadingIcon(
          iconColor: AppColor.white,
        ),
        backgroundColor: AppColor.apcolor,
        title: Text(
          "View All Report",
          style: GoogleFonts.lato(),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "No Report found",
            ),
          ),
          SizedBox(
            height: 90,
            child: ListView.builder(
              itemCount: imagePaths.length > 4 ? 4 : imagePaths.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index < 3) {
                  // Show first 3 images without opacity
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.apcolor,
                    ),
                    margin: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      imagePaths[index],
                      width: 80.0,
                      // height: 70.0,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  );
                } else if (index == 3) {
                  // Show the count above the 3rd image with opacity and background image
                  int remainingCount = imagePaths.length - 4;
                  return GestureDetector(
                    onTap: () {
                      _showImageDialog(imagePaths);
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(imagePaths[index -
                                  1]), // Adjust index to get the correct image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: Text(
                              '+$remainingCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Hide remaining images after the 4th one
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(List<String> allImages) {
    Get.dialog(
      Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // padding: EdgeInsets.only(right: 16, bottom: 10, top: 20,),
              width: double.maxFinite,
              alignment: Alignment.topRight,
              // child: Icon(Icons.cancel_outlined),
            ),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: allImages.length,
              padding: const EdgeInsets.only(bottom: 16, right: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showLargeImage(context, allImages[index]);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 10,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.apcolor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      allImages[index],
                      fit: BoxFit.cover,
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

  void _showLargeImage(BuildContext context, String imagePath) {
    Get.dialog(
      Dialog(
        child: Stack(
          children: [
            PhotoView(
              imageProvider: AssetImage(imagePath),
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 2.0,
              initialScale: PhotoViewComputedScale.contained,
              enableRotation: true,
              heroAttributes: PhotoViewHeroAttributes(tag: imagePath),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
