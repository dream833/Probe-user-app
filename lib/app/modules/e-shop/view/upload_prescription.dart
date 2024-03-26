import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/app/widget/display_image_widget.dart';
import 'package:uddipan/app/widget/loader_button.dart';

class UploadPrescriptionView extends StatelessWidget {
  const UploadPrescriptionView({super.key});

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
            const DisplayImageWidget(
                color: Colors.deepOrange,
                height: 90,
                width: 90,
                child: Icon(
                  FontAwesomeIcons.upload,
                  color: Colors.white,
                )),
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
                onTap: () async {}),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
