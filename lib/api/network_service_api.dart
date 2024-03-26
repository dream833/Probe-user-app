import 'dart:developer';
import 'package:dio/dio.dart';
import '../constants/string_constant.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices {
  Future<Response<dynamic>> postApi({
    required String endpoint,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    final dio = Dio();
    token ??= getbox.read(userToken);
    final url = '$baseurl/$endpoint';
    try {
      final response = await dio.post(
        url,
        data: data ?? {}, // Use an empty map if data is not provided
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      log('Status code: ${response.statusCode} on URL: $url Response Data ${response.data}');

      return response;
    } catch (e) {
      log("Error is ===========> $e ");
      rethrow;
    }
  }

  Future<Response<dynamic>> putApi({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final dio = Dio();
    final token = getbox.read(userToken);
    final url = '$baseurl/$endpoint';

    try {
      final response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          followRedirects: true,
          maxRedirects: 5,
        ),
      );
      log('Status code: ${response.statusCode} on URL: $url Response Data ${response.data}');

      return response;
    } catch (e, stackTrace) {
      log("Error is ===========> $e");
      print(stackTrace);
      rethrow;
    }
  }

  Future<Response<dynamic>> getApi({
    required String endpoint,
    String? token,
  }) async {
    final dio = Dio();

    token ??= getbox.read(userToken);

    final url = '$baseurl/$endpoint';

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      log('Status code: ${response.statusCode} on URL: $url ');
      print(response.data);
      return response;
    } catch (e) {
      log("Error is ===========> $e");
      rethrow;
    }
  }
}
