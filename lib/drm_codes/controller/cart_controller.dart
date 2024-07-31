import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/constants/string_constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/custom_message.dart';
import '../models/cart_test_model.dart';

class CartController extends GetxController {
  var testCartModel = TestCartModel.fromJson({}).obs;
  var isLoading = false.obs;
  var totalAmount = 0.0.obs;
  Future getTestCart() async {
    isLoading(true);

    var method = dio.Dio();
    var response =
        await method.get('https://api.esplshowcase.in/api/fetch-test',
            options: dio.Options(headers: {
              'Authorization': 'Bearer ${getbox.read(userToken)}',
            }));
    isLoading(false);

    log("DRM266\n${response.data}");
    if (response.statusCode == 200) {
      testCartModel(TestCartModel.fromJson(response.data));
    } else {
      {
        CustomMessage.showSuccessSnackBar('Error',
            backgroundColor: Colors.red, title: 'Cart ');
      }
    }
  }

  Future deleteCartItem(String id) async {
    isLoading(true);

    var method = dio.Dio();

    var response = await method.post(
        'https://api.esplshowcase.in/api/delete-cart/${id.toString()}',
        options: dio.Options(headers: {
          'Authorization': 'Bearer ${getbox.read(userToken)}',
        }));
    isLoading(false);

    if (response.statusCode == 200) {
    } else {
      {
        CustomMessage.showSuccessSnackBar('Error',
            backgroundColor: Colors.red, title: 'Cart ');
      }
    }
    getTestCart();
  }

  @override
  void onInit() {
    getTestCart();
    super.onInit();
  }

  void checkOut() async {
    isLoading(true);

    var method = dio.Dio();

    var response = await method.post("$baseurl/test-payment",
        options: dio.Options(headers: {
          'Authorization': 'Bearer ${getbox.read(userToken)}',
        }));
    isLoading(false);

    log("DRM299\n${response.data}");
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
