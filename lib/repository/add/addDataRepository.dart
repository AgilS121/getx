import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:getx/data/network/network_api_services.dart';
import 'package:getx/models/home/AddData.dart';
import 'package:getx/res/url/appUrl.dart';

class AddDataRepository {

  final Dio _dio = Dio();

  Future<bool> uploadStory(String token, String description, File photo, {double? lat, double? lon}) async {
    try {
      FormData formData = FormData.fromMap({
        'description': description,
        'photo': await MultipartFile.fromFile(photo.path, filename: 'photo.jpg'),
        if (lat != null) 'lat': lat.toString(),
        if (lon != null) 'lon': lon.toString(),
      });

      _dio.options.headers['Authorization'] = 'Bearer $token';
      _dio.options.headers['Content-Type'] = 'multipart/form-data';

      Response response = await _dio.post(AppUrl.add, data: formData);

      if (response.data['error'] == false) {
        return true; // Upload sukses
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      throw Exception('Failed to upload story: $e');
    }
  }
}