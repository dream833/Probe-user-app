import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uddipan/app/widget/circular_image_widget.dart';
import 'package:uddipan/constants/image_contant.dart';

class ImagePickerWidget extends StatelessWidget {
  final Uint8List? image;
  final String? initialUrl;
  final void Function(Uint8List) onImageSelected;

  const ImagePickerWidget({
    Key? key,
    required this.image,
    required this.onImageSelected,
    this.initialUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(children: [
        CircularImageView(
          size: 120,
          child: image != null
              ? Image.memory(image!, fit: BoxFit.cover)
              : initialUrl != null
                  ? Image.network(initialUrl!, fit: BoxFit.cover)
                  : Image.asset(AppImage.avatar, fit: BoxFit.cover),
        ),
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(60),
          ),
        )),
        Positioned.fill(
          child: IconButton(
            icon: Icon(
              image != null ? Icons.camera_alt_outlined : Icons.add_a_photo,
              size: 32,
            ),
            onPressed: () => showModalBottomSheet<void>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(5.0)),
                ),
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Wrap(children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            title: const Text('Take a photo'),
                            leading: const Icon(Icons.camera_alt),
                            onTap: () {
                              pickImage(context, true);
                              Navigator.pop(context);
                            },
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          ListTile(
                            title: const Text('Pick from gallery'),
                            leading: const Icon(Icons.image),
                            onTap: () {
                              pickGallery(context, true);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ]);
                }),
          ),
        )
      ]),
    );
  }

  void pickImage(BuildContext context, bool isLogo) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageBytes = await image.readAsBytes();
    onImageSelected(imageBytes);
  }

  void pickGallery(BuildContext context, bool isLogo) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageBytes = await image.readAsBytes();
    onImageSelected(imageBytes);
  }
}
