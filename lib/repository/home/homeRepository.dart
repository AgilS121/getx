import 'dart:convert';

import 'package:getx/data/network/network_api_services.dart';
import 'package:getx/models/home/GetAllList.dart';
import 'package:getx/res/url/appUrl.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();

  Future<GetAllListModel> getAll(String token) async {
    try {
      final headers = {
        'Authorization': 'Bearer $token',
      };

      final dynamic response = await _apiService.getApi(AppUrl.home, headers: headers);
      print('Response: $response'); // Cetak respons ke konsol

      if (response != null) {
        return GetAllListModel.fromJson(response);
      } else {
        throw Exception('Empty response');
      }
    } catch (e) {
      print('Error occurred: $e'); // Cetak kesalahan ke konsol jika terjadi
      throw Exception('Failed to get data');
    }
  }

}
