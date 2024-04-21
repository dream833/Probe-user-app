// Flutter imports:
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';
import 'package:uddipan/constants/string_constant.dart';
// Package imports:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallView extends StatefulWidget {
  final String userId;
  final String userName;
  final String callId;
  const VideoCallView(
      {super.key,
      required this.callId,
      required this.userId,
      required this.userName});

  @override
  State<VideoCallView> createState() => _VideoCallViewState();
}

class _VideoCallViewState extends State<VideoCallView> {
  ZegoUIKitPrebuiltCallController? callController;

  @override
  Widget build(BuildContext context) {
    print('call id ${widget.callId} ${widget.userId} ${widget.userName}  $zegoAppId');
    return ZegoUIKitPrebuiltCall(
      appID: zegoAppId,
      appSign: zegoAppSignId,
      callID: widget.callId,
      userID: widget.userId,
      userName: widget.userName,
      // Modify your custom configurations here.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onHangUpConfirmation = (BuildContext context) async {
          return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.blue[900]!.withOpacity(0.9),
                // title: const Text("This is your custom dialog",
                //     style: TextStyle(color: Colors.white70)),
                content: const Text("Are you sure. you want to leave?",
                    style: TextStyle(color: Colors.white70)),
                actions: [
                  ElevatedButton(
                    child: Text("Cancel",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  ElevatedButton(
                    child: Text("Exit",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      //Restart.restartApp();
                    },
                  ),
                ],
              );
            },
          );
        },
    );
  }
}
