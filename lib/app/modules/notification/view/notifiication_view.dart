import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uddipan/app/modules/notification/controllers/notification_controller.dart';
import 'package:uddipan/app/widget/Text/small_text.dart';
import 'package:uddipan/constants/color_constant.dart';
import 'package:uddipan/utils/snippet.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    controller.getNotificationList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: SmallText(
            text: 'Notification',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textColor: Colors.grey.shade700),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              FutureBuilder(
                  future: delayDuration(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return shimmerListEffect(
                          itemBorderRadius: 16, itemCount: 10);
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: controller.notificationList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: appColorPrimary,
                                          radius: 24,
                                          child: const Icon(
                                            Icons.calendar_month,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                        .notificationList[index]
                                                        ?.body ??
                                                    '',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    color:
                                                        Colors.grey.shade700),
                                              ),
                                              const SizedBox(height: 5),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  formatDate(controller
                                                      .notificationList[index]
                                                      ?.createdAt),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
