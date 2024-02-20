import 'dart:io';

import 'package:dio/dio.dart';

class UploadService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> uploadData({
    required String description,
    required String photoPath,
    required String jwtToken
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'description': description,
        'photo': await MultipartFile.fromFile(photoPath, filename: 'image.jpg'),
      });

      final response = await dio.post(
        'https://story-api.dicoding.dev/v1/stories',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $jwtToken', // Ganti dengan token yang sesuai
          },
        ),
      );

      return response.data;
    } catch (error) {
      throw Exception('Terjadi kesalahan: $error');
    }
  }
}
