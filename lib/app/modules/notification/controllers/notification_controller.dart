import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/models/notification_model.dart';

class NotificationController extends GetxController {
  final storage = GetStorage();

  RxInt notificationCounter = 0.obs;
  final isNoticationLoading = false.obs;

  RxList<NotificationModel?> notificationList = <NotificationModel?>[].obs;

 

  Future<void> getNotificationList() async {
    try {
      String token = getbox.read(userToken);
      String id = getbox.read(userId).toString();
      final uri = Uri.parse('$baseurl/get/users/notification?user_id=$id');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        List<NotificationModel?> notifications =
            list.map((json) => NotificationModel.fromJson(json)).toList();
            
        notificationList.assignAll(notifications);

         for (NotificationModel? notification in notifications) {
          if (notification?.isRead == false) {
            await updateIsReadNotification(notificationId: notification!.id);
          }
        }
       await getUnReadNotificationCount();
      }
    } catch (e) {
      log('e ${e.toString()}');
      log('Receive Error in getNotification');
    }
  }

  Future<void> updateIsReadNotification({required int notificationId}) async {
    try {
      String token = getbox.read(userToken);
      final uri = Uri.parse(
          'https://doctor.suranjanbhattacharjee.tech/api/user/isRead/notification');

      final response = await http.post(
        uri,
        body: {
          'notification_id': notificationId.toString(),
          'isRead': 'true'
        }, // Assuming you want to set isRead to true
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 201) {
        log('response ${response.statusCode}');
      } else {
        log('Receive Error in updateIsReadNotification');
      }
    } catch (e) {
      log('e ${e.toString()}');
      log('Receive Error in updateIsReadNotification');
    }
  }

  Future<void> getUnReadNotificationCount() async {
    try {
      String token = getbox.read(userToken);

      String id = getbox.read(userId).toString();
      // https://doctor.suranjanbhattacharjee.tech/api/unread/user/notification
      final uri = Uri.parse('$baseurl/unread/user/notification?user_id=$id');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        List<NotificationModel?> notifications =
            list.map((json) => NotificationModel.fromJson(json)).toList();
        notificationCounter.value = notifications.length;
        log('notificationCounter ${notificationCounter.value}');
      } else {
        log('Receive Error in getUnReadNotificationCount');
      }
    } catch (e) {
      log('e ${e.toString()}');
      log('Receive Error in getUnReadNotificationCount');
    }
  }
}
