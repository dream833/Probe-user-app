import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uddipan/app/modules/signup/views/signup_view.dart';
import 'package:uddipan/routes/app_pages.dart';
import '../../../../api/network_service_api.dart';
import 'package:http/http.dart' as http;
import '../../../../constants/string_constant.dart';
import '../../../../models/branch/branch_model.dart';
import '../../../../models/district/district_model.dart';
import '../../../../models/division/division_model.dart';
import '../../../../models/region/region_model.dart';
import '../../../../models/thana/thana_model.dart';
import '../../../../models/union/union_model.dart';
import '../../../../models/zone/zone_model.dart';
import '../../../../utils/custom_message.dart';

class SignupController extends GetxController {
  final networkApi = NetworkApiServices();
  final selectedCountryCode = "IN".obs;
  final selectedDigitalCode = "91".obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final pinController = TextEditingController();
  File? profilePicture;
  final isPasswordVisible = true.obs;
  final isConfirmPasswordVisible = true.obs;
  var selectedRadio = 0.obs;
  final List<String> radioItems = ['Male', 'Female'];

  final imagePath = ''.obs;
  XFile? profilePic;

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

  @override
  void onInit() {
    super.onInit();
    fetchZone();
    fetchDivision();
    // fetchRegion();
  }

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
    try {
      final response =
          await NetworkApiServices().fetchRegion(zoneId.toString());
      if (response.statusCode == 200) {
        // await Future.delayed(const Duration(seconds: 1));
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['regions'] != null) {
          final regionModel = RegionModel.fromJson(data);

          if (regionModel.regions != null) {
            regionList.value = regionModel.regions!;
            debugPrint(
                'Region Length is ====================> ${regionList.length}');
          }
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        debugPrint(response.statusCode);
        debugPrint(response.body);
        throw Exception('Failed to load data');
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('Stack Trace: $stackTrace');
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
            debugPrint('Thana Length is ====================> ${thanaList.length}');
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
            debugPrint('Union Length is ====================> ${unionList.length}');
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

  final isLoading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void setProfilePicture(File? newProfilePicture) {
    profilePicture = newProfilePicture;
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
          'POST', Uri.parse('https://api.esplshowcase.in/api/projectImages'));

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
      debugPrint(e.toString());
      CustomMessage.errorMessage(context, e.toString());
      return '';
    }
  }

  getImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }

  userRegistration() async {
    isLoading.value = true;
    try {
      final uri = Uri.parse('https://api.esplshowcase.in/api/users');
      final request = http.MultipartRequest('POST', uri)
        ..fields['name'] = nameController.text
        ..fields['email'] = emailController.text
        ..fields['password'] = passwordController.text
        ..fields['password_confirmation'] = confirmPasswordController.text
        ..fields['countryCode'] = selectedDigitalCode.value
        ..fields['digitalCode'] = selectedCountryCode.value
        ..fields['phone_number'] = phoneController.text
        ..fields['zone_id'] = selectedZoneId.toString()
        ..fields['region_id'] = selectedRegionId.toString()
        ..fields['branch_id'] = selectedBranchId.toString()
        ..fields['district_id'] = selectedDistrictId.toString()
        ..fields['division_id'] = selectedDivisionId.toString()
        ..fields['thana_id'] = selectedThanaId.toString()
        ..fields['union_id'] = selectedUnionId.toString()
        ..fields['user_type'] = 23.toString()
        ..fields['is_she'] = 1.toString()
        ..fields['pin'] = pinController.text
        ..fields['permanent_address'] = addressController.text
        ..fields['present_address'] = addressController.text
        ..fields['user_pluck'] = 1.toString()
        ..files.add(http.MultipartFile(
            'image',
            File(imagePath.value).readAsBytes().asStream(),
            File(imagePath.value).lengthSync()))
        ..headers['Content-Type'] = 'application/x-www-form-urlencoded'
        ..headers['Accept'] = 'application/json';

      log(request.fields.toString());
      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200 || response.statusCode == 201) {
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomMessage.showSuccessSnackBar("Registration Successful");
          Get.offAllNamed(Routes.LOGIN);
        });
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomMessage.showSnackBar("Registration Failed");
          log("${response.body} \n ${response.reasonPhrase} \n ${response.statusCode} ");
        });
      }
    } catch (ex) {
      Fluttertoast.showToast(msg: ex.toString());
      log(ex.toString());
    }
  }

  Future signup(BuildContext context) async {
    isLoading.value = true;
    try {
      // if (profilePicture == null) {
      //   CustomMessage.errorMessage(context, 'Please Select Profile Photo');
      // } else if (nameController.text.isEmpty ||
      //     emailController.text.isEmpty ||
      //     phoneController.text.isEmpty ||
      //     passwordController.text.isEmpty ||
      //     confirmPasswordController.text.isEmpty ||
      //     selectedZoneId.value == 0 ||
      //     selectedRegionId.value == 0 ||
      //     selectedBranchId.value == 0 ||
      //     selectedDistrictId.value == 0 ||
      //     pinController.text.isEmpty ||
      //     selectedDivisionId.value == 0) {
      //   CustomMessage.errorMessage(
      //       context, 'Please fill in all the required fields');
      // } else if (passwordController.text.length < 8) {
      //   CustomMessage.errorMessage(context, 'Minimum Password is 8');
      // } else if (confirmPasswordController.text != passwordController.text) {
      //   CustomMessage.errorMessage(
      //       context, 'Password and confirm Password should be same');
      // } else {
      //   List<int> imageBytes = await profilePicture!.readAsBytes();
      //   String base64Image = base64Encode(imageBytes);

      final uri = Uri.parse('https://api.esplshowcase.in/api/users');
      var request = http.MultipartRequest('POST', uri);
      isLoading.value = true;

      request.fields['name'] = nameController.text;
      request.fields['email'] = emailController.text;
      request.fields['password'] = passwordController.text;
      request.fields['password_confirmation'] = confirmPasswordController.text;
      request.fields['countryCode'] = selectedDigitalCode.value;
      request.fields['digitalCode'] = selectedCountryCode.value;
      request.fields['phone_number'] = phoneController.text;
      request.fields['zone_id'] = selectedZoneId.toString();
      request.fields['region_id'] = selectedRegionId.toString();
      request.fields['branch_id'] = selectedBranchId.toString();
      request.fields['district_id'] = selectedDistrictId.toString();
      request.fields['division_id'] = selectedDivisionId.toString();
      request.fields['thana_id'] = selectedThanaId.toString();
      request.fields['union_id'] = selectedUnionId.toString();
      request.fields['user_type'] = 23.toString();
      request.fields['is_she'] = 0.toString();
      request.fields['pin'] = pinController.text;
      request.fields['permanent_address'] = addressController.text;
      request.fields['present_address'] = addressController.text;
      request.fields['user_pluck'] = 1.toString();
      var pic =
          await http.MultipartFile.fromPath('image', profilePicture!.path);
      request.files.add(pic);
      var response = await request.send();

      debugPrint(response.toString());

      if (response.statusCode == 200) {
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomMessage.showSuccessSnackBar("Registration Successful");
          Get.offAllNamed(Routes.LOGIN);
        });
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomMessage.showSnackBar("Registration Failed");
          log("${response.request} \n ${response.reasonPhrase} \n ${response.statusCode} ");
        });
      }
      // }
    } on DioException catch (e) {
      // ignore: use_build_context_synchronously
      log(e.response.toString());
      log(e.type.toString());
      CustomMessage.errorMessage(context, e.toString());
    }
  }
}
