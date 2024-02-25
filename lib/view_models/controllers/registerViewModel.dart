// RegisterController.dart
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx/models/Data/RegisterResponseCRUD.dart';
import 'package:getx/repository/register/RegisterRepository.dart';

class RegisterController extends GetxController {
  final RegisterRepository _registerRepository = RegisterRepository();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void register() async {
    try {
      RegisterResponseCRUD response = await _registerRepository.register(
        name: name.text,
        email: email.text,
        password: passwordController.text,
      );

      if (response.status == true) {
        // Registrasi sukses
        Get.toNamed('/login');
      } else {
        // Registrasi gagal
        Get.snackbar('Error', 'Gagal melakukan registrasi');
      }
    } catch (error) {
      // Tangani kesalahan yang mungkin terjadi
      print('Error: $error');
    }
  }
}
