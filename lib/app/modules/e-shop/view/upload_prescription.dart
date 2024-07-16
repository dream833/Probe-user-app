import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/loader_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class UploadPrescriptionView extends StatelessWidget {
  UploadPrescriptionView({super.key});
  String? selectedFilePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SmallText(
            text: 'Upload Prescription',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(child: Text('Let us arrange your medicine for you')),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
                );

                if (result != null) {
                  PlatformFile file = result.files.first;
                  selectedFilePath = file.path;
                  Fluttertoast.showToast(
                      msg: "Successfully selected prescription ");
                }
              },
              child: const DisplayImageWidget(
                  color: Colors.deepOrange,
                  height: 90,
                  width: 90,
                  child: Icon(
                    FontAwesomeIcons.upload,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(height: 10),
            const Center(child: Text('Select Prescription')),
            const SizedBox(height: 10),
            Text(
              "All uploads are encrpted & visible only to our pharmacies.",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 10),
            Text(
              "Any prescription you upload is validated before processing the order",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const Spacer(),
            LoaderButton(
                color: Colors.deepOrange,
                btnText: 'Upload Precription',
                onTap: () async {
                  if (selectedFilePath != null) {
                    await uploadFile(selectedFilePath!);
                  } else {
                    debugPrint('No file selected.');
                  }
                }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> uploadFile(String filePath) async {
    // Perform the actual upload using the filePath
    // Here's an example using the http package
    var request = http.MultipartRequest('POST', Uri.parse(''));
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "File uploaded!");
      debugPrint('File uploaded!');
    } else {
      Fluttertoast.showToast(msg: "File uploaded failed!");
      debugPrint('File upload failed.');
    }
  }
}
