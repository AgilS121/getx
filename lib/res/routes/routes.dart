import 'package:get/get.dart';
import 'package:getx/res/routes/routes_name.dart';
import 'package:getx/view/Home/home.dart';
import 'package:getx/view/Login/login.dart';
import 'package:getx/view/Register/register.dart';
import 'package:getx/view/Tambah/tambah.dart';
import 'package:getx/view/Update/update.dart';
import 'package:getx/view/intro/intro.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RouteName.intro,
            page: () => Intro(),
            transitionDuration: Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.loginScreen,
            page: () => Login(),
            transitionDuration: Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.registerScreen,
            page: () => Register(),
            transitionDuration: Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.homeScreen,
            page: () => HomeView(),
            transitionDuration: Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        // GetPage(name: RouteName.detailScreen, page: () => DetailPage(), transitionDuration: Duration(milliseconds: 250),
        // transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.tambahScreen,
            page: () => TambahPage(),
            transitionDuration: Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),
        GetPage(
            name: RouteName.updateScreen,
            page: () => UpdateView(),
            transitionDuration: Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade)
      ];
}
