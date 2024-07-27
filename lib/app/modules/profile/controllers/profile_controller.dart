import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uddipan/app/modules/signup/views/signup_view.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/models/transaction_model.dart';
import 'package:uddipan/models/user_model.dart';
import 'package:uddipan/routes/app_pages.dart';

import '../../../../api/network_service_api.dart';
import '../../../../models/branch/branch_model.dart';
import '../../../../models/district/district_model.dart';
import '../../../../models/division/division_model.dart';
import '../../../../models/region/region_model.dart';
import '../../../../models/thana/thana_model.dart';
import '../../../../models/union/union_model.dart';
import '../../../../models/zone/zone_model.dart';
import '../../../../utils/Dialog/loading_dialog.dart';
import '../../../../utils/custom_message.dart';

class ProfileController extends GetxController {
  final name = "".obs;
  final phoneNumber = "".obs;
  final selectedCountryCode = "".obs;
  final selectedDigitalCode = "".obs;
  final isProfileLoading = false.obs;
  final image = "".obs;
  var profileImage = File("").obs;
  final ImagePicker picker = ImagePicker();

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final pinController = TextEditingController().obs;

  final Rx<UserModel?> userModel = Rx<UserModel?>(null);
  RxList<TransactionModel?> transactionList = <TransactionModel?>[].obs;
  var selectedRadio = 0.obs;
  final List<String> radioItems = ['Male', 'Female'];

  // var selectedRegionValue = RxString('');
  var selectedBranchValue = RxString('');
  var selectedDistrictValue = RxString('');
  var selectedDivisionValue = RxString('');
  var selectedThanaValue = RxString('');

  final isZoneLoading = false.obs;
  final zoneList = [].obs;
  var selectedZone = RxString('');
  RxInt selectedZoneId = 0.obs;

  final isRegionLoading = false.obs;
  RxInt selectedRegionId = 0.obs;
  var selectedRegion = RxString('');
  final regionModel = RegionModel().obs;
  final regionList = <Region>[].obs;
  var isLoading = false.obs;

  /// Branch
  final isBranchLoading = false.obs;
  RxInt selectedBranchId = 0.obs;
  var selectedBranch = RxString('');
  final branchModel = RegionModel().obs;
  final branchList = <Branch>[].obs;

  /// District
  final isDistrictLoading = false.obs;
  RxInt selectedDistrictId = 0.obs;
  var selectedDistrict = RxString('');
  final districtModel = RegionModel().obs;
  final districtList = <District>[].obs;

  /// Division
  final isDivisionLoading = false.obs;
  RxInt selectedDivisionId = 0.obs;
  var selectedDivision = RxString('');
  final divisionModel = RegionModel().obs;
  final divisionList = <Division>[].obs;

  /// Thana
  final isThanaLoading = false.obs;
  RxInt selectedThanaId = 0.obs;
  var selectedThana = RxString('');
  final thanaModel = RegionModel().obs;
  final thanaList = <Thana>[].obs;

  /// Union
  final isUnionLoading = false.obs;
  RxInt selectedUnionId = 0.obs;
  var selectedUnion = RxString('');
  final unionModel = RegionModel().obs;
  final unionList = <Union>[].obs;

  Future fetchZone() async {
    isZoneLoading.value = true;
    try {
      final response = await NetworkApiServices().fetchZone();
      if (response.statusCode == 200) {
        var allZone = [];
        allZone = jsonDecode(response.body);
        log('All Zone Lenth ${allZone.length.toString()}');
        zoneList.clear();
        for (var element in allZone) {
          zoneList.add(ZoneModel.fromJson(element));
        }
        isZoneLoading.value = false;
      } else {
        isZoneLoading.value = false;
      }
    } catch (e) {
      isZoneLoading.value = false;
    }
  }

  Future fetchRegion(int zoneId) async {
    final response = await NetworkApiServices().fetchRegion(zoneId.toString());
    if (response.statusCode == 200) {
      // await Future.delayed(const Duration(seconds: 1));
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['regions'] != null) {
        final regionModel = RegionModel.fromJson(data);

        if (regionModel.regions != null) {
          regionList.value = regionModel.regions!;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  /// Fetch Branch based on Region ID

  Future fetchBranch(int regionId) async {
    try {
      final response =
          await NetworkApiServices().fetchBranch(regionId.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['branches'] != null) {
          // Check if 'regions' is not null in the JSON data
          final branchModel = BranchModel.fromJson(data);

          if (branchModel.branches != null) {
            // Check if 'regions' in the model is not null
            branchList.value = branchModel.branches!;
            debugPrint(
                'Branch Length is ====================> ${branchList.length}');
          }
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('Stack Trace: $stackTrace');
    }
  }

  /// Fetch District based on branch ID

  Future fetchDistrict(int branchId) async {
    try {
      debugPrint("Branch id is ======> $branchId");
      final response = await NetworkApiServices().fetchDistrict(1.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['districts'] != null) {
          final districtModel = DistrictModel.fromJson(data);

          if (districtModel.districts != null) {
            districtList.value = districtModel.districts!;
            debugPrint(
                'District Length is ====================> ${districtList.length}');
          }
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        debugPrint(response.body);
        debugPrint(response.statusCode);
        throw Exception('Failed to load data');
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('Stack Trace: $stackTrace');
    }
  }

  ///! Fetch Division based
  Future fetchDivision() async {
    try {
      final response = await NetworkApiServices().fetchDivision();
      if (response.statusCode == 200) {
        divisionList.clear();
        final List<dynamic> responseData = json.decode(response.body);

        for (var item in responseData) {
          Division division = Division.fromJson(
              item); // Assuming fromJson method is available in Division model
          divisionList.add(division);
        }

        log('District Length is ====================> ${divisionList.length}');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e, stackTrace) {
      log('Error: $e');
      log('Stack Trace: $stackTrace');
    }
  }

  /// Fetch Thana
  Future fetchThana(int divisionId) async {
    try {
      debugPrint("Division ID $divisionId");
      final response =
          await NetworkApiServices().fetchThana(divisionId.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['thanas'] != null) {
          // Check if 'regions' is not null in the JSON data
          final thanaModel = ThanaModel.fromJson(data);

          if (thanaModel.thanas != null) {
            // Check if 'regions' in the model is not null
            thanaList.value = thanaModel.thanas!;
            debugPrint(
                'Thana Length is ====================> ${thanaList.length}');
          }
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        debugPrint("Code ${response.statusCode}");
        throw Exception('Failed to load data');
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('Stack Trace: $stackTrace');
    }
  }

  /// Fetch Union
  Future fetchUnion(int thanaId) async {
    try {
      final response =
          await NetworkApiServices().fetchUnion(thanaId.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['unions'] != null) {
          final unionModel = UnionModel.fromJson(data);

          if (unionModel.unions != null) {
            unionList.value = unionModel.unions!;
            debugPrint(
                'Union Length is ====================> ${unionList.length}');
            debugPrint(response.body);
          }
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('Stack Trace: $stackTrace');
    }
  }

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

    fetchZone();
    fetchDivision();
    getUserInfo();
  }

  void pcikProfilePicture() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage(File(image.path));
      uploadImage(profileImage.value);
    }
  }

  AudioPlayer audioPlayer = AudioPlayer();
  final networkApiServices = NetworkApiServices();

  Future<void> getUserInfo() async {
    isProfileLoading.value = true;
    try {
      var response = await networkApiServices.getApi(endpoint: 'users/profile');

      if (response.statusCode == 200) {
        userModel(UserModel.fromMap(response.data));
        name.value = userModel.value!.name.toString();
        image.value = userModel.value!.image.toString();
        debugPrint('---------------------- ${image.value}--');
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

  Future<String?> uploadImage(File imageFile) async {
    isLoading(true);
    const uploadUrl = 'https://api.esplshowcase.in/api/upload/files';
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    var response = await request.send();
    isLoading(false);

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);

      if (jsonResponse['url'].toString() != "null") {
        CustomMessage.showSuccessSnackBar("Image Uploaded");
        updateUserProfile();
      } else {
        CustomMessage.showSnackBar("Image Upload Failed",
            backgroundColor: Colors.red.withOpacity(0.7));
      }

      return jsonResponse['url'];
    } else {
      return null;
    }
  }

  Future<void> updateUserProfile() async {
    final apiUrl = '$baseurl/users/profile';
    final token = getbox.read(userToken);
    final controller = Get.find<ProfileController>();
    String? imgUrl;

    imgUrl = await uploadImage(profileImage.value);

    Map<String, String> requestBody = {
      'name': controller.nameController.value.text,
      'phone_number': controller.phoneController.value.text,
      'countryCode': controller.selectedCountryCode.value,
      'zone_id': controller.selectedZoneId.toString(),
      'region_id': controller.selectedRegionId.toString(),
      'branch_id': controller.selectedBranchId.toString(),
      'district_id': controller.selectedDistrictId.toString(),
      'division_id': controller.selectedDivisionId.toString(),
      'thana_id': controller.selectedThanaId.toString(),
      'union_id': controller.selectedUnionId.toString(),
      'digitalCode': controller.selectedDigitalCode.value,
      'present_address': controller.addressController.value.text,
      'pin': controller.pinController.value.text,
      // 'image': imgUrl ?? controller.image.value
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
      getbox.remove(userLogin);
      getbox.remove(userEmail);
      getbox.remove(userId);
      getbox.remove(isUserLoggedIN);
      getbox.remove(userToken);

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
        debugPrint(parsedResponse);
        String? fileUrl = parsedResponse['data']['file'];
        log('file url $fileUrl');
        return fileUrl;
      } else {
        var responseBody = await response.stream.bytesToString();
        var parsedResponse = json.decode(responseBody);
        debugPrint(parsedResponse);
        return '';
      }
    } catch (e) {
      CustomMessage.errorMessage('Please Enter Name');
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
      CustomMessage.errorMessage(e.toString());
    }
  }
}
