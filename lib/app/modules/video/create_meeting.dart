import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/video/video_call_view.dart';
import 'package:uddipan/app/widget/custom_textfield.dart';
import 'package:uddipan/app/widget/loader_button.dart';

class CreateMeeting extends StatefulWidget {
  const CreateMeeting({super.key});

  @override
  State<CreateMeeting> createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  final _nameController = TextEditingController();
  final _callIdController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _callIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Join Meeting',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 48, 46, 46),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                CustomTextField(hintText: 'Name', controller: _nameController),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Meeting Id',
                  controller: _callIdController,
                  inputType: TextInputType.name,
                  onChanged: (val) {
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                LoaderButton(
                    btnText: 'Video Call',
                    onTap: () async {
                      _startVideoCall();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  _startVideoCall() {
    setState(() {
      Get.to(() => VideoCallView(
          callId: _callIdController.text,
          userId: (Random().nextInt(100) + 1).toString(),
          userName: _nameController.text));
      _callIdController.text == '';
      _nameController.text == '';
    });
  }
}
