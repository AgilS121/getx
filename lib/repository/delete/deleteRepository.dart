import 'package:dio/dio.dart';
import 'package:getx/res/url/appUrl.dart';

class DeleteRepository {
  final Dio _dio = Dio();

  Future<void> deleteTask(String token, String id) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.delete(
        '${AppUrl.delete}/$id',
      );

      if (response.statusCode == 200) {
        print('Task deleted successfully');
      } else {
        throw Exception('Failed to delete task: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
}
