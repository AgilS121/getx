import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx/models/Data/LoginResponseCRUD.dart';
import 'package:getx/models/login/loginResponse.dart';
import 'package:getx/repository/login/loginRepository.dart';
import 'package:getx/res/routes/routes_name.dart';
import 'package:getx/utils/utils.dart';
import 'package:getx/view_models/controllers/userPreference.dart';

class LoginViewModel extends GetxController {
  final _api = LoginRepository();

  UserPreference userPreference = UserPreference();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNone = FocusNode().obs;

  RxBool loading = false.obs;

  void loginApi() {
    loading.value = true;
    Map data = {
      'email': emailController.value.text,
      'password': passwordController.value.text
    };
    _api
        .loginApi(data)
        .then((value) => {
              loading.value = false,
              if (value['error'] == 'Missing email or username')
                {Utils.snackBar('Login', value['error'])}
              else if (value['error'] == 'user not found')
                {Utils.snackBar('Login', value['error'])}
              else
                {
                  userPreference
                      .saveUser(LoginResponseCRUD.fromJson(value))
                      .then((value) {
                    // Penyimpanan pengguna berhasil, tampilkan Snackbar
                    Get.toNamed(RouteName.homeScreen);
                    Utils.snackBar('Login', 'Login Success $value');
                  }).catchError((error) {
                    // Penyimpanan pengguna gagal, tampilkan pesan kesalahan jika diperlukan
                    print('Error saving user: $error');
                  }),
                  Utils.snackBar('Login', 'Login Success')
                }
            })
        .onError((error, stackTrace) =>
            {loading.value = false, Utils.snackBar('Error', error.toString())});
  }
}
