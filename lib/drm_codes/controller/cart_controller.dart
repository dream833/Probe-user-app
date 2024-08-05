import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:uddipan/drm_codes/models/cart_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/custom_message.dart';
import '../models/cart_test_model.dart';

class CartController extends GetxController {
  var testCartModel = TestCartModel.fromJson({}).obs;
  var isLoading = false.obs;
  var totalAmount = 0.0.obs;
  var cartmodel = Cartmodel.fromJson({}).obs;

  Future getcart() async {
    var method = dio.Dio();
    var response = await method.get(
      'https://api.esplshowcase.in/api/test-cart',
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer ${getbox.read(userToken)}',
        },
      ),
    );
    isLoading(false);

    if (response.statusCode == 200) {
      cartmodel(Cartmodel.fromJson(response.data));
    } else {
      CustomMessage.showSuccessSnackBar('Error',
          backgroundColor: Colors.red, title: 'Cart ');
    }
  }

  Future removeTestFromCart(
      {String? cartID, String? itemID, String? type}) async {
    isLoading(true);
    var method = dio.Dio();
    var response = await method.post(
      '$baseurl/remove-test',
      data: (type == "package")
          ? {"package_id": itemID, "type": type}
          : (type == "test")
              ? {"test_id": itemID, "type": type}
              : {"profile_id": itemID, "type": type},
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer ${getbox.read(userToken)}',
        },
      ),
    );

    isLoading(false);

    if (response.statusCode == 200) {
    } else {
      {
        CustomMessage.showSuccessSnackBar('Error',
            backgroundColor: Colors.red, title: 'Cart ');
      }
    }
    getcart();
  }

  void checkOut() async {
    isLoading(true);

    var method = dio.Dio();

    var response = await method.post(
      "$baseurl/test-payment",
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer ${getbox.read(userToken)}',
        },
      ),
    );
    isLoading(false);

    launchUrl(Uri.parse(response.data));

    if (response.statusCode == 200) {
    } else {
      {
        CustomMessage.showSuccessSnackBar('Error',
            backgroundColor: Colors.red, title: 'Cart ');
      }
    }
  }
}
