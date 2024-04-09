import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uddipan/routes/app_pages.dart';
import 'package:uddipan/utils/Dialog/loading_dialog.dart';
import 'package:uddipan/utils/custom_message.dart';
import '../../../../api/network_service_api.dart';
import '../../../../constants/string_constant.dart';
import '../app/modules/signup/views/signup_view.dart';

class AuthController extends GetxController {
  final networkApi = NetworkApiServices();
  Rx<Gender> selected = Gender.male.obs;
  Rx<bool> isPasswordHidden = true.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var phone =
      TextEditingController(text: isdebugMode.value ? "1234567890" : "");
  var password = TextEditingController();
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  var selectedRadio = 0.obs;
  final List<String> radioItems = ['Male', 'Female'];

  void setSelectedRadio(int value) {
    selectedRadio.value = value;
  }

  void setSelectedGender(Gender gender) {
    selected.value = gender;
  }

  Rx<bool> isLoading = false.obs;

  // Future<void> login() async {
  //   AppLoading.appLoading3();
  //   try {
  //     var response = await networkApi.postApi(
  //       endpoint: 'users/login',
  //       data: {
  //         'phone_number': phone.text,
  //         'password': password.text,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       if (response.data['message'] == "Incorrect phone number or password") {
  //         AppLoading.closeLoadingDialog();
  //         Future.delayed(const Duration(milliseconds: 100), () {
  //           CustomMessage.showSnackBar("Incorrect phone number or password");
  //         });
  //       } else {
  //         AppLoading.closeLoadingDialog();
  //         getbox.write(userLogin, true);
  //         getbox.write(userEmail, response.data["user"]["email"]);
  //         getbox.write(userId, response.data["user"]["id"]);
  //         getbox.write(userPassword, password.text);
  //         getbox.write(isUserLoggedIN, true);
  //         getbox.write(userToken, response.data["token"]);

  //         Future.delayed(const Duration(milliseconds: 500), () {
  //           CustomMessage.showSuccessSnackBar("Login Successful");
  //           Get.offAllNamed(Routes.bottomNavigationBar);
  //         });
  //       }
  //     } else {
  //       log("Can not do login ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     AppLoading.closeLoadingDialog();
  //   }
  // }

  Future signup() async {
    // AppLoading.appLoading3();
    try {
      if (nameController.text.isEmpty) {
        CustomMessage.showSnackBar("Name Required");
      } else if (phoneController.text.isEmpty) {
        CustomMessage.showSnackBar("Phone Number Required");
      } else if (passwordController.text.isEmpty) {
        CustomMessage.showSnackBar("Password Required");
      } else if (confirmPasswordController.text.isEmpty) {
        CustomMessage.showSnackBar("Confirm Password Required");
      } else if (passwordController.text.length < 8) {
        CustomMessage.showSnackBar("Minimum Password is 8");
      } else if (confirmPasswordController.text != passwordController.text) {
        CustomMessage.showSnackBar(
            "Password and confirm Password should be same");
      } else {
        AppLoading.appLoading3();
        var data = {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phone_number': phoneController.text,
          'is_she': selectedRadio.value == 0 ? false : true,
          'present_address': "Test Address",
          'permanent_address': "Test Address",
          'image': "",
          'user_pluck': 5121,
          'status': 'active',
          'pin': 0000000,
        };

        var response = await networkApi.postApi(
          endpoint: 'users',
          data: data,
        );
        if (response.statusCode == 200) {
          AppLoading.closeLoadingDialog();
          Future.delayed(const Duration(milliseconds: 100), () {
            CustomMessage.showSuccessSnackBar("Registration Successful");
            Get.offAllNamed(Routes.LOGIN);
          });
        } else {
          AppLoading.closeLoadingDialog();
          Future.delayed(const Duration(milliseconds: 100), () {
            CustomMessage.showSnackBar("Registration Failed");
            // Get.offAllNamed(Routes.LOGIN);
          });
        }
      }
    } catch (e) {
      AppLoading.closeLoadingDialog();
    }
  }
}
