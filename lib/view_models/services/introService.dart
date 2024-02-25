import 'dart:async';

import 'package:get/get.dart';
import 'package:getx/res/routes/routes_name.dart';

class IntroService {
  void isLogin() {
    Timer(const Duration(seconds: 3),
    () => Get.toNamed(RouteName.loginScreen));
  }
}