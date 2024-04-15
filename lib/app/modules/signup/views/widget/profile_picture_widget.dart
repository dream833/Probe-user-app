import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uddipan/constants/theme_constant.dart';
import '../../controllers/signup_controller.dart';

class ProfilePictureWidget extends StatefulWidget {
  const ProfilePictureWidget({super.key});

  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  final controller = Get.put(SignupController());
  final _picker = ImagePicker();

  Future getImage() async {
    final source = await showModalBottomSheet(
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
                        onTap: () {
                          Navigator.pop(context, ImageSource.camera);
                        },
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
                        onTap: () {
                          Navigator.pop(context, ImageSource.gallery);
                        },
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
        });

    if (source != null) {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          controller.profilePicture = File(pickedFile.path);
        });
      } else {
        debugPrint("no image selected");
      }
    } else {
      debugPrint("no source selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            getImage();
          },
          child: SizedBox(
              height: 100,
              width: 100,
              child: controller.profilePicture == null
                  ? Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset("assets/images/avatar.png"))
                  : Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Center(
                        child: Image.file(
                          File(controller.profilePicture!.path).absolute,
                        ),
                      ))),
        ),
      ],
    );
  }
}
