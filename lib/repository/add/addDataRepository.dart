import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:getx/res/url/appUrl.dart';

class AddDataRepository {
  final Dio _dio = Dio();

  Future<bool> uploadStory(String token, String title, String details) async {
    try {
      FormData formData = FormData.fromMap({
        'title': title,
        'details': details,
      });

      _dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await _dio.post(AppUrl.post, data: formData);
      print('data response upload ${response.data}');

      if (response.data['status'] == true) {
        return true; // Upload sukses
      } else {
        throw Exception('Failed to upload story: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Failed to upload story: $e');
    }
  }
}
