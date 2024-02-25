import 'package:get/get.dart';
import 'package:getx/models/Data/LoginResponseCRUD.dart';
import 'package:getx/models/login/loginResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference extends GetxController {
  Future<bool> saveUser(LoginResponseCRUD responseLogin) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', responseLogin.token.toString());

    return true;
  }

  Future<LoginResponseCRUD> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    print("ini tokennya $token");

    return LoginResponseCRUD(token: token);
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }

  // static const String _keyUserId = 'userId';
  // static const String _keyName = 'name';
  // static const String _keyToken = 'token';

  // // Save user data to SharedPreferences
  // Future<void> saveUser(LoginResult user) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_keyUserId, user.userId ?? '');
  //   await prefs.setString(_keyName, user.name ?? '');
  //   await prefs.setString(_keyToken, user.token ?? '');
  // }

  // // Retrieve user data from SharedPreferences
  // Future<LoginResult?> getUser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String userId = prefs.getString(_keyUserId) ?? '';
  //   final String name = prefs.getString(_keyName) ?? '';
  //   final String token = prefs.getString(_keyToken) ?? '';

  //   if (userId.isNotEmpty && name.isNotEmpty && token.isNotEmpty) {
  //     return LoginResult(userId: userId, name: name, token: token);
  //   } else {
  //     return null;
  //   }
  // }

  // // Remove user data from SharedPreferences
  // Future<void> removeUser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(_keyUserId);
  //   await prefs.remove(_keyName);
  //   await prefs.remove(_keyToken);
  // }
}
