import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:getx/models/Data/RegisterResponseCRUD.dart';
import 'package:getx/res/url/appUrl.dart';

class RegisterRepository {
  final Dio _dio = Dio();

  Future<RegisterResponseCRUD> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await _dio.post(
        AppUrl.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return RegisterResponseCRUD.fromJson(response.data);
      } else {
        throw Exception('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }
}
