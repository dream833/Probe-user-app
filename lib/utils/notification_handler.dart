import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions();

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestSoundPermission: true,
            ));

    await _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> display(RemoteMessage remoteMessage) async {
    try {
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "Probe_Push_Notifications",
          "Probe_Push_Notifications_Channel",
          channelDescription: "This is our channel",
          priority: Priority.high,
          importance: Importance.max,
        ),
      );
      final String body = remoteMessage.notification?.body ?? '';
      final String title = remoteMessage.notification?.title??'';
     
      await _notificationsPlugin.show(
        1,
        title,
        body,
        notificationDetails,
        payload: 'Not Yet',
      );
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

void onDidReceiveLocalNotification(BuildContext context, int id, String? title,
    String? body, String? payload) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title ?? 'title'),
      content: Text(body ?? 'body'),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () async {},
        )
      ],
    ),
  );
}
