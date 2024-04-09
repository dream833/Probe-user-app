import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/data/local_data_sources.dart';
import '../constants/string_constant.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices {
  final client = http.Client();
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

  Future<dynamic> fetchZone() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(LocalDataSources.token);
    final uri = Uri.parse('$baseurl/zones');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(
      uri,
      headers: headers,
    );
    return response;
  }

  /// Fetch Region based on Zone ID
  Future<dynamic> fetchRegion(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(LocalDataSources.token);
    final uri = Uri.parse('$baseurl/zones/$id');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(
      uri,
      headers: headers,
    );
    return response;
  }

  /// Fetch Branch based on Region ID
  Future<dynamic> fetchBranch(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(LocalDataSources.token);
    final uri = Uri.parse('$baseurl/regions/$id');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(
      uri,
      headers: headers,
    );
    return response;
  }

  /// Fetch District based on Branch ID
  Future<dynamic> fetchDistrict(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(LocalDataSources.token);
    final uri = Uri.parse('$baseurl/branches/$id');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(
      uri,
      headers: headers,
    );
    return response;
  }

  /// Fetch Division based on District ID
  Future<dynamic> fetchDivision() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(LocalDataSources.token);
    final uri = Uri.parse('$baseurl/districts/');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(
      uri,
      headers: headers,
    );
    return response;
  }

  /// Fetch Thana based on Division ID
  Future<dynamic> fetchThana(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(LocalDataSources.token);
    final uri = Uri.parse('$baseurl/divisions/$id');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(
      uri,
      headers: headers,
    );
    return response;
  }

  /// Fetch Union based on Thana ID
  Future<dynamic> fetchUnion(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(LocalDataSources.token);
    final uri = Uri.parse('$baseurl/thanas/$id');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await client.get(
      uri,
      headers: headers,
    );
    return response;
  }
}
