import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;

import '../constants/string_constant.dart';

Future<dio.Response<dynamic>> dioGet(String endUrl) async {
  var method = dio.Dio();

  if (getbox.read(userLogin) ?? false) {
    method.options.headers['Authorization'] =
        "Bearer ${getbox.read(userId) ?? ''}";
  }

  var response = await method.get("$baseurl$endUrl",
      options: dio.Options(
          validateStatus: (status) => true,
          sendTimeout: const Duration(
            milliseconds: 15000,
          ),
          receiveTimeout: const Duration(
            milliseconds: 15000,
          )));
  isdebugMode.value
      ? log(
          "\n\nGET: $endUrl\nSTATUS CODE: ${response.statusCode}\n${jsonEncode(response.data)}\n\n")
      : null;

  return response;
}
