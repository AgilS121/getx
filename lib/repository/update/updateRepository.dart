import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:getx/models/Data/UpdateResponseCRUD.dart';
import 'package:getx/res/url/appUrl.dart';
import 'package:http/http.dart' as http;

class UpdateDataRepository {
  final Dio _dio = Dio();

  Future<UpdateResponseCRUD> updateTask(
      String token, String title, String details, String id) async {
    try {
      Map<String, dynamic> taskData = {
        'title': title,
        'details': details,
      };

      _dio.options.headers['Authorization'] = 'Bearer $token';
      _dio.options.headers['Content-Type'] = 'application/json';

      final response = await _dio.patch(
        '${AppUrl.update}/$id',
        data: jsonEncode(taskData),
      );

      if (response.statusCode == 200) {
        return UpdateResponseCRUD.fromJson(response.data);
      } else {
        throw Exception('Failed to update task: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }
}
