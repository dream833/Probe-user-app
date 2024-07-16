import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uddipan/api/network_service_api.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/models/availability_model.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/models/review_model.dart';
import 'package:uddipan/models/user_model.dart';
import 'package:uddipan/utils/custom_message.dart';

class DoctorController extends GetxController {
  final favoritesKey = 'favoriteDoctors';
  late final TabController tabController;
  final networkApi = NetworkApiServices();
  var isDoctorSlotLoading = false.obs;
  var isDoctorReviewLoading = false.obs;
  var selectedWeekDay = "".obs;
  var doctorRating = 0.0.obs;
  final dateController = TextEditingController();
  final dayController = TextEditingController();
  final selectedSlotDate = DateTime.now().obs;
  final isDoctorSearchLoading = false.obs;
  final inSearchMode = false.obs;
  RxInt selectedIndex = RxInt(-1);
  final searchController = TextEditingController();
  List<DoctorModel?> searchedDoctors = [];
  RxList<DoctorModel?> doctorList = <DoctorModel?>[].obs;
  RxList<DoctorModel?> favouriteDoctors = <DoctorModel?>[].obs;
  Rx<AvailabilityModel?> selectedAvailability = Rx<AvailabilityModel?>(null);
  RxList<AvailabilityModel?> availabilityList = <AvailabilityModel?>[].obs;
  RxList<AvailabilityModel?> onlineSlots = <AvailabilityModel?>[].obs;
  RxList<AvailabilityModel?> offlineSlots = <AvailabilityModel?>[].obs;
  RxList<ReviewModel?> reviewList = <ReviewModel?>[].obs;

  @override
  void onInit() {
    super.onInit();

    loadFavoriteDoctors();
  }

  loadFavoriteDoctors() {
    final box = GetStorage();
    if (box.hasData(favoritesKey)) {
      List<DoctorModel> list = (box.read(favoritesKey) as List<dynamic>)
          .map((item) => DoctorModel.fromJson(item))
          .toList();

      favouriteDoctors.assignAll(list);

      update();
    }
  }

  void saveFavoriteDoctor(
      {DoctorModel? doctor, required BuildContext context}) {
    final box = GetStorage();
    if (!favouriteDoctors.any((p0) => p0?.id == doctor?.id)) {
      favouriteDoctors.add(doctor);
      box.write(favoritesKey,
          favouriteDoctors.map((doctor) => doctor?.toJson()).toList());
      CustomMessage.showSuccessSnackBar(
          'Doctor is added to your favourite list.');
      update();
    }
  }

  void removeFavoriteDoctor(
      {DoctorModel? doctor, required BuildContext context}) {
    final box = GetStorage();
    favouriteDoctors.removeWhere((element) => element?.id == doctor?.id);
    box.write(favoritesKey,
        favouriteDoctors.map((doctor) => doctor?.toJson()).toList());
    CustomMessage.errorMessage('Doctor is removed from your favourite list.');
    update();
  }

  List<String> specialization = [
    'Cardiology',
    'Dermatology',
    'Orthopedics',
    'Gastroenterology',
    'Neurology',
  ];

  List<String> experience = [
    '(5+years)',
    '(3+years)',
    '(6+years)',
    '(7+years)',
    '(1+years)',
  ];

  List<double> ratings = [4, 3.5, 3, 2, 1];

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  void selectAvailability(int index) {
    selectedIndex.value = index;

    log('Selected: Slot index ${selectedIndex.value}');
    selectedAvailability.value = availabilityList[index];

    update();
  }

  void changeToSearch() {
    inSearchMode.value = true;
    searchedDoctors = doctorList;
    update();
  }

  void removeFromSearch() {
    inSearchMode.value = false;
    searchController.text = '';
    searchedDoctors = [];

    update();
  }

  void searchDoctors(String value) {
    searchedDoctors = doctorList
        .where((element) =>
            element!.firstName
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            element.lastName
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase().toString()))
        .toList();
    log('searchedDoctor ${searchedDoctors.length.toString()}');
    update();
  }

  Future<void> getAllDoctors() async {
    try {
      final response = await networkApi.getApi(endpoint: 'get-all-doctors');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<DoctorModel?> doctors =
            data.map((json) => DoctorModel.fromJson(json)).toList();
        doctorList.assignAll(doctors);
        log('Get All Doctors Length ${doctorList.length}');
      } else {
        log("Error fetching doctors: Else");
      }
    } catch (error) {
      log("Error fetching doctors: $error");
    }
  }

  void pickSlotDate({required DateTime date, required String doctorId}) async {
    selectedSlotDate.value = date;
    log('Selected Slot Date ${selectedSlotDate.value.toString()}');
    final dayFormat = DateFormat('EEEE');
    dayController.text = dayFormat.format(selectedSlotDate.value);
    selectedWeekDay.value = dayFormat.format(selectedSlotDate.value);
    await getDoctorSlotsAccordingToSelectedDate(doctorId: doctorId);
    update();
  }

  Future getDoctorSlotsAccordingToSelectedDate(
      {required String doctorId}) async {
    try {
      isDoctorSlotLoading.value = true;
      onlineSlots.clear();
      offlineSlots.clear();
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(selectedSlotDate.value);
      final response = await networkApi
          .postApi(endpoint: 'selected/date/availability', data: {
        "doctor_id": doctorId,
        "slot_date": formattedDate,
      });
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['availability'];
        List<AvailabilityModel?> availabilityModel =
            data.map((json) => AvailabilityModel.fromJson(json)).toList();
        availabilityList.assignAll(availabilityModel);
        for (var element in availabilityModel) {
          if (element!.status == '1') {
            onlineSlots.add(element);
            log('Online Slots ${onlineSlots.length.toString()}');
          } else {
            offlineSlots.add(element);
            log('offlineSlots Slots ${offlineSlots.length.toString()}');
          }
        }

        isDoctorSlotLoading.value = false;
      } else {
        log("Error fetching getDoctorSlots: Else");
        isDoctorSlotLoading.value = false;
      }
    } catch (error) {
      isDoctorSlotLoading.value = false;
      log("Error fetching getDoctorSlots: $error");
    }
  }

  Future<void> getDoctorByCategoryId({required categoryId}) async {
    try {
      String token = getbox.read(userToken);

      final uri = Uri.parse(
          '$baseurl/get/user_category/doctor?category_id=$categoryId');
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<DoctorModel?> doctors =
            data.map((json) => DoctorModel.fromJson(json)).toList();
        doctorList.assignAll(doctors);
      } else {
        log('error in fetching specializationCategory list');
      }
    } catch (error) {
      log("Error fetching specializationCategory: $error");
    }
  }

  Future<Map<String, dynamic>?> getDoctorAverageRating(
      {required int doctorId}) async {
    try {
      final uri =
          Uri.parse('$baseurl/api/get/doctor_review/?doctor_id=$doctorId');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<ReviewModel?> reviews =
            data.map((json) => ReviewModel.fromJson(json)).toList();

        // Calculate the average rating
        double totalRating = 0;
        for (var review in reviews) {
          totalRating += review?.rating ?? 0;
        }
        double averageRating =
            reviews.isNotEmpty ? totalRating / reviews.length : 0;
        Map<String, dynamic> value = {
          'averageRating': averageRating.toPrecision(2),
          'totalReviews': reviews.length.toString()
        };
        return value;
      } else {
        log('Error in fetching doctor review list');
        return null;
      }
    } catch (error) {
      log("Error fetching doctor review list: $error");
      return null;
    }
  }

  Future<void> getDoctorReviewList({required int doctorId}) async {
    try {
      isDoctorReviewLoading.value = true;
      final uri =
          Uri.parse('$baseurl/api/get/doctor_review/?doctor_id=$doctorId');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<ReviewModel?> reviews =
            data.map((json) => ReviewModel.fromJson(json)).toList();
        reviewList.assignAll(reviews);

        double totalRating = 0;
        for (var review in reviews) {
          totalRating += review?.rating ?? 0;
        }
        doctorRating.value =
            reviews.isNotEmpty ? totalRating / reviews.length : 0;
        isDoctorReviewLoading.value = false;
      } else {
        log('Error in fetching doctor review list');
        isDoctorReviewLoading.value = false;
      }
    } catch (error) {
      log("Error fetching doctor review list: $error");
      isDoctorReviewLoading.value = false;
    }
  }

  Future<UserModel?> getUserById({required int userId}) async {
    try {
      final uri = Uri.parse('$baseurl/get/single/user?user_id=$userId');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> userModel = json.decode(response.body);
        UserModel userInfo = UserModel.fromMap(userModel);
        return userInfo; // Return the UserModel object
      } else {
        log('Error: ${response.statusCode}');
        return null; // Return null when there's an error
      }
    } catch (error) {
      log("Error fetching user: $error");
      return null; // Return null when there's an error
    }
  }
}
