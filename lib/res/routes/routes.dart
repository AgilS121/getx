import 'package:get/get.dart';
import 'package:getx/res/routes/routes_name.dart';
import 'package:getx/view/Login/login.dart';
import 'package:getx/view/intro/intro.dart';

class AppRoutes {
  static appRoutes () => [
    GetPage(name: RouteName.intro, page: () => Intro(), transitionDuration: Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade),
    GetPage(name: RouteName.loginScreen, page: () => Login(), transitionDuration: Duration(milliseconds: 250),
    transition: Transition.leftToRightWithFade)
  ];
}