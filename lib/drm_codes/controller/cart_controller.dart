import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddipan/constants/string_constant.dart';

import '../../utils/custom_message.dart';
import '../models/cart_test_model.dart';

class CartController extends GetxController {
  var testCartModel = TestCartModel.fromJson({}).obs;
  var isLoading = false.obs;

  Future getTestCart() async {
    isLoading(true);

    var method = dio.Dio();
    var response =
        await method.get('https://api.esplshowcase.in/api/fetch-test',
            options: dio.Options(headers: {
              'Authorization': 'Bearer ${getbox.read(userToken)}',
            }));
    isLoading(false);
    log("DRM255\n${getbox.read(userToken)}");

    if (response.statusCode == 200) {
      testCartModel(TestCartModel.fromJson(response.data));
    } else {
      {
        CustomMessage.showSuccessSnackBar('Error',
            backgroundColor: Colors.red, title: 'Cart ');
      }
    }
  }

  Future deleteAllCart() async {
    isLoading(true);

    var method = dio.Dio();

    var list = [
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      67,
      68,
      69,
      70,
      71,
      72
    ];

    list.forEach((e) async {
      var response =
          await method.post('https://api.esplshowcase.in/api//delete-cart/$e',
              options: dio.Options(headers: {
                'Authorization': 'Bearer ${getbox.read(userToken)}',
              }));
      isLoading(false);
      log("DRM266\n${getbox.read(userToken)}");

      if (response.statusCode == 200) {
        testCartModel(TestCartModel.fromJson(response.data));
      } else {
        {
          CustomMessage.showSuccessSnackBar('Error',
              backgroundColor: Colors.red, title: 'Cart ');
        }
      }
    });
  }

  @override
  void onInit() {
    deleteAllCart();
    getTestCart();
    super.onInit();
  }
}
