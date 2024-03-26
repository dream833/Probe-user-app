import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/signup/views/signup_view.dart';
import 'package:uddipan/routes/app_pages.dart';
import '../../../../api/network_service_api.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/custom_message.dart';

class SignupController extends GetxController {
  final networkApi = NetworkApiServices();
  final selectedCountryCode = "BD".obs;
  final selectedDigitalCode = "880".obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final Rx<Uint8List?> profilePicture = Rx<Uint8List?>(null);
  final isPasswordVisible = true.obs;
  final isConfirmPasswordVisible = true.obs;
  var selectedRadio = 0.obs;
  final List<String> radioItems = ['Male', 'Female'];

  void setProfilePicture(Uint8List? newProfilePicture) {
    profilePicture.value = newProfilePicture;
    update();
  }

  void setSelectedRadio(int value) {
    selectedRadio.value = value;
  }

  Rx<Gender> selected = Gender.male.obs;

  void setSelectedGender(Gender gender) {
    selected.value = gender;
  }

  RxBool isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  RxBool isConfirmPasswordHidden = true.obs;

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<String?> uploadProfilePicture(
      String fileName, Uint8List imageBytes, BuildContext context) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://api.esplshowcase.in/api/upload/files'));

      request.fields['name'] = fileName;

      request.files.add(http.MultipartFile.fromBytes('file', imageBytes,
          filename: "$fileName.png"));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var parsedResponse = json.decode(responseBody);
        print(parsedResponse);
        String? fileUrl = parsedResponse['data']['file'];
        log('file url $fileUrl');
        return fileUrl;
      } else {
        var responseBody = await response.stream.bytesToString();
        var parsedResponse = json.decode(responseBody);
        print(parsedResponse);
        return '';
      }
    } catch (e) {
      CustomMessage.errorMessage(context, 'Please Enter Name');
      return '';
    }
  }

  Future signup(BuildContext context) async {
    try {
      if (profilePicture.value == null) {
        CustomMessage.errorMessage(context, 'Please Select Profile Photo');
      } else if (nameController.text.isEmpty) {
        CustomMessage.errorMessage(context, 'Please Enter Name');
      } else if (emailController.text.isEmpty) {
        CustomMessage.errorMessage(context, 'Please Enter Email');
      } else if (phoneController.text.isEmpty) {
        CustomMessage.errorMessage(context, 'Please Enter Phone No');
      } else if (passwordController.text.isEmpty) {
        CustomMessage.errorMessage(context, 'Please Enter Password');
      } else if (confirmPasswordController.text.isEmpty) {
        CustomMessage.errorMessage(context, 'Please Enter Confirm Password');
      } else if (passwordController.text.length < 8) {
        CustomMessage.errorMessage(context, 'Minimum Password is 8');
      } else if (confirmPasswordController.text != passwordController.text) {
        CustomMessage.errorMessage(
            context, 'Password and confirm Password should be same');
      } else {
        final imageIUrl = await uploadProfilePicture(
            nameController.text, profilePicture.value!, context);

        var data = {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'countryCode': selectedDigitalCode.value,
          'digitalCode': selectedCountryCode.value,
          'phone_number': phoneController.text,
          'is_she': selectedRadio.value == 0 ? false : true,
          'present_address': '',
          'permanent_address': "Test Address",
          'image': imageIUrl,
          'user_pluck': 5121,
          'status': 'active',
          'pin': 5451212
        };

        var response =
            await networkApi.postApi(endpoint: 'users/register', data: data);
        if (response.statusCode == 200) {
          Future.delayed(const Duration(milliseconds: 100), () {
            CustomMessage.showSuccessSnackBar("Registration Successful");
            Get.offAllNamed(Routes.LOGIN);
          });
        } else {
          Future.delayed(const Duration(milliseconds: 100), () {
            CustomMessage.showSnackBar("Registration Failed");
          });
        }
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      CustomMessage.errorMessage(context, e.toString());
    }
  }
}
