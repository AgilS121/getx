import 'package:getx/res/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/res/routes/routes_name.dart';
import 'package:getx/view/Home/homeView.dart';
import 'package:getx/view/Login/login.dart';
import 'package:getx/res/colors/pallete.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SewaIn extends StatefulWidget {
  const SewaIn({Key? key}) : super(key: key);

  @override
  _SewaInState createState() => _SewaInState();
}

class _SewaInState extends State<SewaIn> {
  @override
  void initState() {
    super.initState();
    // Periksa apakah token tersimpan saat aplikasi dimulai
    checkToken();
  }

  // Fungsi untuk memeriksa apakah token tersimpan
  void checkToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    print('initoken $token');

    if (token != null && token.isNotEmpty) {
      // Jika token tersimpan, arahkan pengguna langsung ke halaman utama
      // atau halaman yang sesuai dengan logika navigasi aplikasi Anda.
      navigateToHome();
    }
  }

  // Fungsi untuk mengarahkan pengguna ke halaman utama
  void navigateToHome() {
    // Misalnya, Anda dapat menggunakan Navigator untuk mengarahkan pengguna
    // ke halaman utama aplikasi Anda. Sesuaikan dengan logika navigasi Anda.
    Get.toNamed(RouteName.myHome);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SewaIn",
      theme: ThemeData(
        primaryColor: MyColors.bg,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: MyColors.bg,
      ),
      // initialRoute: '/intro',
      getPages: AppRoutes.appRoutes(),
      home: Login(), // Jika token tidak tersimpan, arahkan pengguna ke halaman login
    );
  }
}


Future<void> main(List<String> args) async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SewaIn());
}
