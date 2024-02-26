import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:getx/data/network/network_api_services.dart';
import 'package:getx/models/Data/ReadResponseCRUD.dart';
import 'package:getx/models/home/GetAllList.dart';
import 'package:getx/res/url/appUrl.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  final _apiService = NetworkApiServices();

  // Future<GetAllListModel> getAll(String token) async {
  //   try {
  //     final headers = {
  //       'Authorization': 'Bearer $token',
  //     };

  //     final dynamic response = await _apiService.getApi(AppUrl.read, headers: headers);
  //     print('Response: $response'); // Cetak respons ke konsol

  //     if (response != null) {
  //       return GetAllListModel.fromJson(response);
  //     } else {
  //       throw Exception('Empty response');
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e'); // Cetak kesalahan ke konsol jika terjadi
  //     throw Exception('Failed to get data');
  //   }
  // }

  final Dio _dio = Dio();
  Future<List<ReadResponseCRUD>> getAll(String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final Response response = await _dio.get(
        AppUrl.read,
        options: Options(headers: headers),
      );

      print("response data ${response.data}");

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        return responseData
            .map((json) => ReadResponseCRUD.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load data');
    }
  }
}
