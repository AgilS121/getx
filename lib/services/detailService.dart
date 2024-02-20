import 'package:dio/dio.dart';

class DetailService {
  final Dio dio;

  DetailService(this.dio);

  Future<Map<String, dynamic>> fetchStoryById(String jwtToken, String storyId) async {
    final apiUrl = 'https://story-api.dicoding.dev/v1/stories/$storyId';
    dio.options.headers['Authorization'] = 'Bearer $jwtToken';

    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        return response.data['story'] as Map<String, dynamic>;
      } else {
        throw Exception('Gagal mengambil data dari API');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
