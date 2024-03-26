import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/constants/string_constant.dart';

import 'package:http/http.dart' as http;
import 'package:uddipan/models/health_care_model.dart';
import 'package:uddipan/models/member_model.dart';
import 'package:uddipan/utils/custom_message.dart';

class HealthController extends GetxController {
  final isMemberListLoading = false.obs;
  var selectedMember = RxString('');
  RxInt selectedMemberId = 0.obs;
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final sugarController = TextEditingController();
  final recordDateController = TextEditingController();
  RxList<MemberModel?> memberList = <MemberModel?>[].obs;
  RxList<HealthCareModel?> healthCareList = <HealthCareModel?>[].obs;
  List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void onInit() async {
    super.onInit();
    await getUserFamilyMember();
    await getMemberHealthCareList();
  }

  Future<void> getUserFamilyMember() async {
    log('getFamilyMember in health Controller');
    try {
      String token = getbox.read(userToken);
      final uri = Uri.parse('$baseurl/user/family-members');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<MemberModel?> member =
            data.map((json) => MemberModel.fromJson(json)).toList();
        memberList.assignAll(member);
      }
    } catch (e) {
      log('Error in getting member list in health controller');
    }
  }

  Future<void> addFamilyMemberHealth(BuildContext context) async {
    log('AddFamily in health Controller');
    try {
      if (selectedMember.value.isEmpty) {
        CustomMessage.errorMessage(context, 'Please Select Member');
        return;
      }
      if (heightController.text.isEmpty ||
          weightController.text.isEmpty ||
          bloodPressureController.text.isEmpty ||
          bloodGroupController.text.isEmpty ||
          sugarController.text.isEmpty ||
          recordDateController.text.isEmpty) {
        CustomMessage.errorMessage(context, 'Please fill the fields');
        return;
      }
      // Check if blood group is valid
      if (!bloodGroups.contains(bloodGroupController.text)) {
        CustomMessage.errorMessage(context, 'Invalid blood group');
        return;
      }

      final data = {
        'family_member_id': selectedMemberId.value.toString(),
        'height': heightController.text,
        'weight': weightController.text,
        'blood_pressure': bloodPressureController.text,
        'blood_group': bloodGroupController.text,
        'sugar': sugarController.text,
        'record_date': recordDateController.text
      };
      String token = getbox.read(userToken);
      final uri = Uri.parse('$baseurl/health-profiles');
      final response = await http.post(
        uri,
        body: data,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 201) {
        log('Success');
      } else {
        log('Error in addFamilyMemberHealth');
      }
    } catch (e) {
      print(e.toString());
      log('Error in addFamilyMemberHealth');
    }
  }

  Future<void> getMemberHealthCareList() async {
    log('Get Member Health Care');
    String token = getbox.read(userToken);
    final uri = Uri.parse(
        'https://doctor.suranjanbhattacharjee.tech/api/all-health-profiles');
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<HealthCareModel?> member =
          data.map((json) => HealthCareModel.fromJson(json)).toList();
      healthCareList.assignAll(member);
    }
  }
}
