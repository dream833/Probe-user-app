import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uddipan/constants/string_constant.dart';


noData() {
  return const Center(
    child: Text(
      "No data available",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

loading() {
  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const CircularProgressIndicator(
        backgroundColor: Colors.green,
      ),
      SizedBox(
        height: 100.h,
      ),
      const Text("Please Wait ....."),
    ],
  ));
}

Future<dio.Response<dynamic>> dioPost(
    {bool? isPost, dynamic data, String? endUrl, bool? sendFile}) async {
  var method = dio.Dio();
  if (getbox.read(userLogin) ?? false) {
    method.options.headers['Authorization'] =
        "Bearer ${getbox.read(userToken) ?? ''}";
  }

  sendFile ?? false
      ? method.options.headers["Content-Type"] = "multipart/form-data"
      : null;

  if (isPost ?? true) {
    var response = await method.post(
      "$baseurl$endUrl",
      data: data,
      options: dio.Options(
        validateStatus: (status) => true,
        sendTimeout: const Duration(milliseconds: 300000),
        receiveTimeout: const Duration(milliseconds: 300000),
      ),
    );
    isdebugMode.value
        ? log(
            "\n\n${isPost ?? true ? 'POST:' : 'PUT'} $baseurl$endUrl\nSTATUS CODE: ${response.statusCode}\n${jsonEncode(response.data)}\n\n")
        : null;

    return response;
  } else {
    var response = await method.put(
      "$endUrl",
      data: data,
      options: dio.Options(
        validateStatus: (status) => true,
        sendTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
      ),
    );
    isdebugMode.value
        ? log(
            "\n\n${isPost ?? true ? 'POST:' : 'PUT'} $baseurl$endUrl\nSTATUS CODE: ${response.statusCode}\n${jsonEncode(response.data)}\n\n")
        : null;
    return response;
  }
}
