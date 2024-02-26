import 'package:dio/dio.dart';
import 'package:getx/models/Data/DetailResponseCRUD.dart';
import 'package:getx/res/url/appUrl.dart';

class DetailRepository {
  final Dio _dio = Dio();

  Future<DetailResponseCRUD> detailTask(String token, String id) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.get(
        '${AppUrl.detail}/$id',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return DetailResponseCRUD.fromJson(responseData);
      } else {
        throw Exception('Failed to show task: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to show task: $e');
    }
  }
}
