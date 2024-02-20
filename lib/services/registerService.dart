import 'package:dio/dio.dart';

class RegisterService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        'https://story-api.dicoding.dev/v1/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      return response.data;
    } on DioError catch (error) {
      if (error.response != null) {
        // Respons diterima dari server, tetapi dengan kode status yang tidak berhasil (tidak 2xx)
        print('Server error ${error.response?.statusCode}: ${error.response?.data}');
        throw Exception('Server error ${error.response?.statusCode}');
      } else {
        // Terjadi kesalahan selama permintaan, misalnya masalah jaringan
        print('Network error: $error');
        throw Exception('Network error');
      }
    }
  }
}
