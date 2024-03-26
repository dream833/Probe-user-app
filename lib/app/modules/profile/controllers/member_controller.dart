import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/app/modules/signup/views/signup_view.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/models/member_model.dart';
import 'package:uddipan/utils/custom_message.dart';

class MemberController extends GetxController {
  final isFamilyMemberLoading = false.obs;
  var selectedRadio = 0.obs;
  final selectedCountryCode = "IN".obs;
  final selectedDigitalCode = "91".obs;
  final dob = DateTime.now().obs;
  final nameController = TextEditingController().obs;
  final relationShipController = TextEditingController().obs;
  final ageController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final dateOfBirth = TextEditingController().obs;

  final List<String> radioItems = ['Male', 'Female'];
  RxList<MemberModel?> memberList = <MemberModel?>[].obs;
  RxList<MemberModel> patients = <MemberModel>[].obs;
  void setSelectedRadio(int value) {
    selectedRadio.value = value;
  }

  Rx<Gender> selected = Gender.male.obs;
  void setSelectedGender(Gender gender) {
    selected.value = gender;
  }

  Future<void> addMember(BuildContext context) async {
    if (nameController.value.text.isEmpty ||
        relationShipController.value.text.isEmpty ||
        ageController.value.text.isEmpty) {
      CustomMessage.errorMessage(context, 'Please Enter All the Fields');
      return;
    }
    String token = getbox.read(userToken);
    var data = {
      'name': nameController.value.text,
      'relationship': relationShipController.value.text,
      'age': ageController.value.text,
      'gender': selectedRadio.value == 0 ? 'Male' : 'Female',
    };
    final uri =
        Uri.parse('https://api.esplshowcase.in/api/patients/family-members');
    final response = await http.post(
      uri,
      body: data,
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode.toString());

    if (response.statusCode == 201) {
      await getUserFamilyMember();
      await Future.delayed(const Duration(milliseconds: 100), () {
        Get.back();
      });
    }
  }

  Future<void> getUserFamilyMember() async {
    try {
      isFamilyMemberLoading.value = true;
      String token = getbox.read(userToken);
      final uri =
          Uri.parse('https://api.esplshowcase.in/api/user/family-members');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<MemberModel?> member =
            data.map((json) => MemberModel.fromJson(json)).toList();
        memberList.assignAll(member);
        isFamilyMemberLoading.value = false;
      } else {
        isFamilyMemberLoading.value = false;
      }
    } catch (e) {
      log('Error in getUserFamilyMember');
      isFamilyMemberLoading.value = false;
    }
  }

  Future<void> addPatient(MemberModel model) async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      patients.add(model);
    });
  }
}
