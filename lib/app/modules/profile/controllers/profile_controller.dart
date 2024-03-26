import 'dart:convert';
import 'dart:developer';

import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:uddipan/app/modules/signup/views/signup_view.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/models/transaction_model.dart';
import 'package:uddipan/models/user_model.dart';
import 'package:uddipan/routes/app_pages.dart';
import '../../../../api/network_service_api.dart';
import '../../../../utils/Dialog/loading_dialog.dart';
import '../../../../utils/custom_message.dart';

class ProfileController extends GetxController {
  final name = "".obs;
  final phoneNumber = "".obs;
  final selectedCountryCode = "".obs;
  final selectedDigitalCode = "".obs;
  final isProfileLoading = false.obs;
  final image = "".obs;
  final Rx<Uint8List?> profilePicture = Rx<Uint8List?>(null);
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final pinController = TextEditingController().obs;
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  RxList<TransactionModel?> transactionList = <TransactionModel?>[].obs;
  var selectedRadio = 0.obs;
  final List<String> radioItems = ['Male', 'Female'];

  void setSelectedRadio(int value) {
    selectedRadio.value = value;
  }

  Rx<Gender> selected = Gender.male.obs;
  void setSelectedGender(Gender gender) {
    selected.value = gender;
  }

  @override
  void onInit() async {
    super.onInit();
    getUserInfo();
  }

  void setProfilePicture(Uint8List? newProfilePicture) {
    profilePicture.value = newProfilePicture;
    update();
  }

  AudioPlayer audioPlayer = AudioPlayer();
  final networkApiServices = NetworkApiServices();

  Future<void> getUserInfo() async {
    isProfileLoading.value = true;
    try {
      var response = await networkApiServices.getApi(endpoint: 'users/profile');

      if (response.statusCode == 200) {
        userModel.value = UserModel.fromMap(response.data);
        name.value = userModel.value!.name.toString();
        image.value = userModel.value!.image.toString();
        print('---------------------- ${image.value}--');
        phoneNumber.value = userModel.value!.phoneNumber.toString();
        nameController.value.text = userModel.value!.name.toString();
        emailController.value.text = userModel.value!.email.toString();
        selectedCountryCode.value = response.data['countryCode'];
        selectedDigitalCode.value = response.data['digitalCode'];
        phoneController.value.text = userModel.value!.phoneNumber.toString();
        addressController.value.text =
            userModel.value!.presentAddress.toString();
        pinController.value.text = userModel.value!.pin.toString();
        isProfileLoading.value = false;
      } else {
        isProfileLoading.value = false;
        log("Error ${response.statusCode}");
      }
    } catch (e) {
      isProfileLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> updateUserProfile({required BuildContext context}) async {
    final apiUrl = '$baseurl/users/profile';
    final token = getbox.read(userToken);
    String? imgUrl;
    if (profilePicture.value != null) {
      imgUrl = await uploadProfilePicture(
          nameController.value.text, profilePicture.value!, context);
    }
    Map<String, String> requestBody = {
      'name': nameController.value.text,
      'phone_number': phoneController.value.text,
      'countryCode': selectedCountryCode.value,
      'digitalCode': selectedDigitalCode.value,
      'pin': userModel.value?.pin ?? '',
      'present_address': addressController.value.text,
      'permanent_address': userModel.value!.permanentAddress.toString(),
      'image': imgUrl ?? image.value
    };

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        await getUserInfo();
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomMessage.showSuccessSnackBar("Profile Updated");
        });
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomMessage.showSnackBar('Status Code: ${response.statusCode}');
        });
      }
    } catch (error) {
      Future.delayed(const Duration(milliseconds: 100), () {
        CustomMessage.showSnackBar('Error during API call: $error');
      });
    }
  }

  userLogout() async {
    AppLoading.appLoading3();
    final response = await networkApiServices.postApi(
      endpoint: 'users/logout',
    );
    if (response.statusCode == 200) {
      getbox.write(userLogin, false);
      getbox.write(userEmail, "");
      getbox.write(userId, "");
      getbox.write(isUserLoggedIN, false);
      getbox.write(userToken, "");
      AppLoading.closeLoadingDialog();

      Future.delayed(const Duration(milliseconds: 500), () {
        CustomMessage.showSuccessSnackBar("Logout Successful");
        Get.offAllNamed(Routes.LOGIN);
      });
    }
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

  Future<void> getTransactionList({required BuildContext context}) async {
    try {
      final apiUrl = '$baseurl/users/payments';
      final token = getbox.read(userToken);
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        List<TransactionModel?> transactionModel =
            list.map((json) => TransactionModel.fromJson(json)).toList();
        transactionList.assignAll(transactionModel);
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          CustomMessage.showSuccessSnackBar(
              'Error in Getting Transaction List ${response.statusCode}');
        });
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      CustomMessage.errorMessage(context, e.toString());
    }
  }
}
