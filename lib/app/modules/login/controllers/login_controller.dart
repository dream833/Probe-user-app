import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uddipan/routes/app_pages.dart';
import 'package:uddipan/utils/custom_message.dart';
import '../../../../api/network_service_api.dart';
import '../../../../constants/string_constant.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final networkApi = NetworkApiServices();
  final selectedCountryCode = "IN".obs;
  final selectedDigitalCode = "91".obs;

  Rx<bool> isPasswordHidden = true.obs;
  var phone = TextEditingController();
  var password = TextEditingController();
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Rx<bool> isLoading = false.obs;

  login(BuildContext context) async {
    try {
      log('selectedCountryCode: $selectedCountryCode');
      log('phone: ${phone.text}');
      log('digitalCode: $selectedDigitalCode');

      var response = await networkApi.postApi(
        endpoint: 'users/login',
        data: {
          'countryCode': selectedCountryCode.value,
          'digitalCode': selectedDigitalCode.value,
          'phone_number': phone.text,
          'password': password.text,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['message'] == "Invalid phone no or password") {
          print(response.data['message']);
          Future.delayed(const Duration(milliseconds: 100), () {
            CustomMessage.errorMessage(context, response.data['message']);
          });
        } else {
          log(response.data.toString());
          getbox.write(userLogin, true);
          getbox.write(userEmail, response.data["user"]["email"]);
          getbox.write(userId, response.data["user"]["id"]);
          getbox.write(userPassword, password.text);
          getbox.write(isUserLoggedIN, true);
          getbox.write(userToken, response.data["token"]);
          getbox.write(notificationCount, '0');
          String? notificationToken =
              await FirebaseMessaging.instance.getToken();

          if (notificationToken != null) {
            await updateFirebaseMessageToken(
                token: notificationToken, userId: response.data['user']['id']);
          }

          Future.delayed(const Duration(milliseconds: 500), () {
            CustomMessage.showSuccessSnackBar("Login Successful");
            Get.offAllNamed(Routes.bottomNavigationBar);
          });
        }
      } else {
        log("Can not do login ${response.statusCode}");
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      CustomMessage.showSnackBar(e.toString());
    }
  }

  Future<void> updateFirebaseMessageToken(
      {required int userId, required String token}) async {
    // Define the API endpoint
    Uri url = Uri.parse('$baseurl/update/users/token');

    try {
      String serverToken = getbox.read(userToken);
      // Make the POST request
      var response = await http.post(
        url,
        body: {
          'user_id': userId.toString(),
          'token': token,
        },
        headers: {
          'Authorization': 'Bearer $serverToken',
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 201) {
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      // Handle exceptions
      throw ' Exception while updating Firebase message token';
    }
  }
}
