import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uddipan/app/modules/bottom_navigation_bar/controllers/bottom_navigation_bar_controllers.dart';
import 'package:uddipan/app/modules/bottom_navigation_bar/view/bottom_navigation_bar_view.dart';
import 'package:uddipan/app/modules/profile/controllers/profile_controller.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/models/appointment_model.dart';
import 'package:uddipan/models/availability_model.dart';
import 'package:uddipan/models/member_model.dart';
import 'package:uddipan/models/user_report_model.dart';

import 'package:uddipan/utils/custom_message.dart';

import 'package:http/http.dart' as http;

import '../../../../api/network_service_api.dart';
import '../../../../utils/snippet.dart';
import '../../signup/views/signup_view.dart';

class AppointmentController extends GetxController {
  final selectedCountryCode = "IN".obs;
  final selectedDigitalCode = "91".obs;
  var selectedValue = RxString('');
  var selectedIndex = 0.obs;
  var genderType = 0.obs;
  var patientType = 0.obs;
  var selectedMember = RxString('');
  var selectedItemName = "".obs;
  var isAppointmentLoading = false.obs;
  final initialDateController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final getVideoId = ''.obs;
  final hasLabReport = false.obs;
  final hasPrescription = false.obs;

  final networkApi = NetworkApiServices();
  final locationController = TextEditingController();
  final patientController = TextEditingController();
  final priceController = TextEditingController();
  final clinicController = TextEditingController();
  final clinicAddressController = TextEditingController();
  final ageController = TextEditingController();
  final phone = TextEditingController();

  var selectedSpecialistValue = RxString('');
  Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null);
  final List<String> genderItems = ['Male', 'Female'];
  final List<String> patientItems = ['For You', 'For Family Member'];
  Rx<DateTime?> selectedEndDateTime = Rx<DateTime?>(null);
  var isDateWiseAppointmentLoading = false.obs;
  final List<String> listOfAppointment = ['Today', 'Upcoming', 'Previous'];
  Rx<MemberModel?> selectedMemberModel = Rx<MemberModel?>(null);

  RxList<UserReportModel?> selectedReportFile = <UserReportModel?>[].obs;
  RxList<int> selectedReportFileIds = <int>[].obs;

  RxList<AppoinmentModel?> todayAppointmentList = <AppoinmentModel?>[].obs;
  RxList<AppoinmentModel?> upcommingAppointmentList = <AppoinmentModel?>[].obs;
  RxList<AppoinmentModel?> datewiseAppointmentList = <AppoinmentModel?>[].obs;

  void setSelectedGender(int value) {
    genderType.value = value;
  }

  void setSelectedPatient(int value) {
    final profileController = Get.find<ProfileController>();
    patientType.value = value;
    if (patientType.value == 0) {
      patientController.text =
          profileController.userModel.value!.name.toString();
      ageController.text = '';
    } else {
      patientController.text = '';
    }

    update();
  }

  Rx<Gender> selected = Gender.male.obs;

  final selectedTabIndex = 0.obs;

  void updateSelectedReportFile(UserReportModel model) {
    if (!selectedReportFile.any((p0) => p0?.id == model.id)) {
      selectedReportFile.add(model);
      selectedReportFileIds.add(model.id);

      update();
    } else {
      selectedReportFile.remove(model);
      selectedReportFileIds.remove(model.id);
      update();
    }
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
    selectedItemName.value = listOfAppointment[index];
  }

  void updateSelectedDateTime(DateTime newDateTime) {
    selectedDateTime.value = newDateTime;
  }

  void updateSelectedReport(bool val) {
    hasLabReport.value = val;
  }

  void updateSelectedPrescription(bool val) {
    hasPrescription.value = val;
  }

  void updateSelectedMember(MemberModel model) {
    selectedMemberModel.value = model;
    patientController.text = model.name;
    ageController.text = model.age.toString();
    setSelectedGender(model.gender == 'Male' ? 0 : 1);
    update();
  }

  void updateEndDateTime(DateTime newDateTime) {
    selectedEndDateTime.value = newDateTime;
  }

  toggleTab(int index) {
    selectedTabIndex.value = index;
  }

  clearDate() {
    startDateController.text == '';
    endDateController.text == '';
    selectedDateTime.value = null;
    selectedEndDateTime.value = null;
  }

  Future<void> getCurrentDateDayAppointments() async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final patientId = getbox.read(userId);
      log('Patient id ${patientId.toString()}');
      String token = getbox.read(userToken);

      final uri = Uri.parse(
        '$baseurl/patient/day_appointments',
      );

      final response = await http.get(
        uri.replace(queryParameters: {
          'patient_id': patientId.toString(),
          'appointment_date': formattedDate,
        }),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        List<AppoinmentModel?> appointmentModel =
            list.map((json) => AppoinmentModel.fromJson(json)).toList();
        todayAppointmentList.assignAll(appointmentModel);
      } else {
        // Handle other status codes if needed
      }
    } catch (error) {
      log("Error fetching getCurrentDateDayAppointments: $error");
    }
  }

  Future<void> upcommingAppointmentsList() async {
    try {
      final patientId = getbox.read(userId);
      String token = getbox.read(userToken);

      final uri = Uri.parse(
        '$baseurl/patient/upcoming_appointments',
      );
      final response = await http.get(
        uri.replace(queryParameters: {
          'patient_id': patientId.toString(),
        }),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);

        List<AppoinmentModel?> appointment =
            list.map((json) => AppoinmentModel.fromJson(json)).toList();
        upcommingAppointmentList.assignAll(appointment);
      } else {}
    } catch (error) {
      log("Error fetching getDoctorSlots: $error");
    }
  }

  Future<void> getDateWiseAppointmentList({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      isDateWiseAppointmentLoading.value = true;
      final patientId = getbox.read(userId);
      String startingDate = _formatDate(startDate);
      String endingDate = _formatDate(endDate);
      String token = getbox.read(userToken);
      final uri = Uri.parse(
        '$baseurl/patient/date_appointments',
      );
      final response = await http.get(
        uri.replace(queryParameters: {
          'startDate': startingDate,
          'endDate': endingDate,
          'patient_id': patientId.toString(),
        }),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        List<AppoinmentModel?> appointmentModel =
            list.map((json) => AppoinmentModel.fromJson(json)).toList();
        datewiseAppointmentList.assignAll(appointmentModel);
        log('dateWiseAppointment ${datewiseAppointmentList.length}');
        isDateWiseAppointmentLoading.value = false;
      } else {
        isDateWiseAppointmentLoading.value = false;
      }
    } catch (e) {
      log('dateWiseAppointment ${e.toString()}');
      isDateWiseAppointmentLoading.value = false;
    }
  }

  Future<void> getAppointmentVideoId(
      {required int appointmentId, int? videoId}) async {
    try {
      String token = getbox.read(userToken);

      final uri = Uri.parse(
        '$baseurl/get/video_id?appointment_id=$appointmentId',
      );
      // print("appointment $appointmentId");
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);

        getVideoId.value = result['video_id'];
        print("video id value ${getVideoId.value}");
      } else {
        debugPrint("error is ${response.body}");
      }

      print(getVideoId.value);
    } catch (e) {
      log("Error fetching video id: $e");
    }
  }

  Future<void> addAppointment(
      {required BuildContext context,
      required String doctorId,
      required AvailabilityModel availabilityModel,
      required String patientId}) async {
    try {
      if (patientController.text.isEmpty) {
        CustomMessage.errorMessage(context, 'Please Enter Name');
        // ignore: unnecessary_null_comparison
        return;
      } else if (ageController.text.isEmpty) {
        CustomMessage.errorMessage(context, 'Please Enter Age');
        return;
      } else if (phone.text.isEmpty) {
        CustomMessage.errorMessage(context, 'Please Enter phone Number');
        return;
      } else {
        print(selectedReportFileIds);
        var response = await networkApi.postApi(
          endpoint: 'appointments',
          data: {
            'patient_name': patientController.text,
            "gender": genderType.value == 0 ? "Male" : "Female",
            "age": ageController.text,
            "phone": "$selectedDigitalCode${phone.text}}",
            "clinic": "-",
            "clinic_address": "-",
            "availability_id": availabilityModel.id,
            "doctor_id": doctorId,
            "patient_id": patientId,
            "appointment_date": availabilityModel.slotDate,
            "availability": availabilityModel.toJson(),
            'amount': '100',
            'isForYou': patientType.value == 0 ? '1' : '0',
            'isForFamilyMember': patientType.value == 1 ? '1' : '0',
            'family_member_id': patientType.value == 1
                ? selectedMemberModel.value?.id.toString()
                : null,
            'user_report': selectedReportFileIds,
          },
        );

        if (response.statusCode == 201) {
          String url = response.data.toString();

          await customLaunch(url);

          Future.delayed(const Duration(milliseconds: 200), () {
            final controller = Get.find<BottomNavigationBarControllers>();
            controller.selectedIndex.value = 1;

            Get.offAll(() => BottomNavigationBarView());
          });
        } else {
          CustomMessage.errorMessage(context, 'Error');
        }
      }
    } catch (e) {
      CustomMessage.showSnackBar(e.toString());
    }
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      String day = date.day.toString().padLeft(2, '0');
      String month = date.month.toString().padLeft(2, '0');
      String year = date.year.toString();
      // return '$day-$month-$year';
      return '$year-$month-$day';
    }
    return '';
  }
}
