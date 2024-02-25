import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:getx/data/app_exceptions.dart';
import 'package:getx/data/network/base_api_services.dart';
import 'package:http/http.dart' as http ;

class NetworkApiServices extends BaseApiServices {

  @override
  Future<dynamic> getApi(String url, {Map<String, String>? headers}) async {
    if (kDebugMode) {
      print(url);
    }
    
    dynamic responseJson ;
    try {
      final response = await http.get(Uri.parse(url), headers: headers).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet connection');
    } on http.ClientException {
      throw BadRequestException('Bad request');
    } 

    return responseJson;
  }

  @override
  Future<dynamic> postApi(dynamic data, String url) async {

    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson ;
    try {
          final response = await http.post(Uri.parse(url),
          body: data
          ).timeout(const Duration(seconds: 10));

          responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet Connection');
      // return responseJson;

    } on BadRequestException {
      throw BadRequestException('');
    }
    if (kDebugMode) {
      print(responseJson);

    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch(response.statusCode) {
      case 200 :
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400 :
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default :
        throw FetchDataException("Error secured white communication" + response.statusCode.toString());
    }
  }

}