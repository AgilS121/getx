import 'package:dio/dio.dart';

class HomeService {
  final Dio dio;

  HomeService(this.dio);

  Future<List<dynamic>> fetchData(String jwtToken) async {
  final apiUrl = 'https://story-api.dicoding.dev/v1/stories';
  dio.options.headers['Authorization'] = 'Bearer $jwtToken';

  try {
    final response = await dio.get(apiUrl);

    if (response.statusCode == 200) {
      // Check if the 'listStory' key exists in the response data
      if (response.data['listStory'] != null && response.data['listStory'] is List) {
        return response.data['listStory'] as List<dynamic>;
      } else {
        throw Exception('Invalid response format: Missing or incorrect key');
      }
    } else {
      throw Exception('Gagal mengambil data dari API');
    }
  } catch (e) {
    throw Exception('Terjadi kesalahan: $e');
  }
}

}
