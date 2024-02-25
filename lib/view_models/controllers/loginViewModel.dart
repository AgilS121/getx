import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx/repository/login/loginRepository.dart';
import 'package:getx/utils/utils.dart';

class LoginViewModel extends GetxController {

  final _api = LoginRepository();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNone = FocusNode().obs;

  RxBool loading = false.obs;

  void loginApi() {
    loading.value = true;
    Map data = {
      'email' : emailController.value.text,
      'password': passwordController.value.text
    };
    _api.loginApi(data).then((value) => {
      loading.value = false,
      if (value['error'] == 'Missing email or username') {
        Utils.snackBar('Login', value['error'])
      } else if (value['error'] == 'user not found') {
        Utils.snackBar('Login', value['error'])
      } else {
        Utils.snackBar('Login', 'Login Success')
      }
      
    }).onError((error, stackTrace) => {
      loading.value = false,
      Utils.snackBar('Error', error.toString())
    });
  }
}