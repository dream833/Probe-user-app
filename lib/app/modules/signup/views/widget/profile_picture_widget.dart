import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/constants/image_contant.dart';
import 'package:uddipan/constants/theme_constant.dart';

import '../../controllers/signup_controller.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundImage: controller.profilePicture != null
                  ? const AssetImage("assets/images/avatar.png")
                  : const AssetImage("assets/images/avatar.png"),
            )),
        Positioned(
          bottom: -5,
          right: -2,
          child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: appColorPrimary),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  _showBottomSheet(context);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              )),
        ),
      ],
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.26,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () => pickImage(context, ImageSource.camera),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            offset: Offset(-1, 1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Camera',
                    style: CustomFont.regularTextRaleway,
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => pickImage(context, ImageSource.gallery),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            offset: Offset(-1, 1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.photo_library),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Gallery',
                    style: CustomFont.regularTextRaleway,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void pickImage(BuildContext context, ImageSource source) async {
  final controller = Get.put(SignupController());
  final image = await ImagePicker().pickImage(source: source);
  if (image != null) {
    final selectedImage = File(image.path);
    controller.setProfilePicture(selectedImage);
    Get.back();
    Fluttertoast.showToast(msg: "Image picked successfully");
  } else {
    Get.back();
  }
}
