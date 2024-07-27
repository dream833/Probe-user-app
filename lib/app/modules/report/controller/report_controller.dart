import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uddipan/api/dio_get.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/models/admin_reports_model.dart';
import 'package:uddipan/models/user_report_model.dart';
import 'package:uddipan/utils/custom_message.dart';
import 'package:uddipan/utils/snippet.dart';

class ReportController extends GetxController {
  final isReportListLoading = false.obs;
  final nameController = TextEditingController();
  final recordDateController = TextEditingController();
  var adminReportsModel = AdminReportsModel().obs;
  Rx<PickedPDF?> pickPDF = Rx<PickedPDF?>(null);
  RxList<UserReportModel?> reportList = <UserReportModel?>[].obs;
  // RxList<AdminReportModel?> adminreportList = <AdminReportModel?>[].obs;
  RxList<AdminReportsModel?> adminreport = <AdminReportsModel?>[].obs;

  Future<String?> upload(
      String fileName, File file, BuildContext context) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.esplshowcase.in/api/upload/files'),
      );

      request.fields['name'] = fileName;

      var stream = http.ByteStream(file.openRead());
      stream.cast();

      var length = await file.length();

      request.files.add(http.MultipartFile(
        'file',
        stream,
        length,
        filename: '$fileName.pdf',
      ));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var parsedResponse = json.decode(responseBody);

        String? fileUrl = parsedResponse['data']['file'];
        log('File URL: $fileUrl');
        return fileUrl;
      } else {
        log('Error while uploading file');
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> addReport(BuildContext context) async {
    try {
      if (pickPDF.value == null) {
        CustomMessage.errorMessage('Please Select PDF');
        return;
      }
      if (nameController.text.isEmpty || recordDateController.text.isEmpty) {
        CustomMessage.errorMessage('Please fill all the fields');
        return;
      }
      final url =
          await upload(nameController.text, pickPDF.value!.file, context);
      final data = {
        'name': nameController.text,
        'report': url,
        'date': recordDateController.text
      };

      String token = getbox.read(userToken);
      final uri = Uri.parse('$baseurl/add/user_report');
      final response = await http.post(
        uri,
        body: data,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 201) {
        getAllUserReports();
        await Future.delayed(const Duration(milliseconds: 100), () {
          Get.back();
        });
      }
    } catch (e) {
      log('Error in catch ${e.toString()}');
    }
  }

  Future<void> getAllUserReports() async {
    try {
      isReportListLoading.value = true;
      String token = getbox.read(userToken);
      int id = getbox.read(userId);

      final uri = Uri.parse(
          'https://api.esplshowcase.in/api/get/user_report?user_id=$id');

      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        List<UserReportModel?> model =
            list.map((json) => UserReportModel.fromJson(json)).toList();
        reportList.assignAll(model);
        log('Report List ${reportList.length.toString()}');
        isReportListLoading.value = false;
      } else {
        log('Error in catch getAllUserReports');
        isReportListLoading.value = false;
      }
    } catch (e) {
      log('Error in catch getAllUserReports ${e.toString()}');
      isReportListLoading.value = false;
    }
  }

  Future<void> getAllAdminReports() async {
    try {
      isReportListLoading.value = true;
      var reposne =
          await dioGet("/get/app-user-reports/${getbox.read(userId)}");
      var data = reposne.data;

      adminReportsModel(AdminReportsModel.fromJson(data));
    } catch (e) {
      log('Error in catch getAllUserReports ${e.toString()}');
      isReportListLoading.value = false;
    }
  }
}
