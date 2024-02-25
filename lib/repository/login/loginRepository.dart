import 'package:getx/data/network/network_api_services.dart';
import 'package:getx/res/url/appUrl.dart';

class LoginRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    dynamic response = _apiService.postApi(data, AppUrl.login);
    return response;
  }
}