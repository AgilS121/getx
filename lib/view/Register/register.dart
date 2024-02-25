// Register.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/res/colors/pallete.dart';
import 'package:getx/view_models/controllers/registerViewModel.dart';

class Register extends StatelessWidget {
  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Bagian Header
          Container(
            height: 150,
            decoration: const BoxDecoration(
              color: MyColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(55),
                bottomRight: Radius.circular(55),
              ),
            ),
          ),
          // Gambar Avatar
          Transform.translate(
            offset: Offset(0, -80),
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image.asset(
                        "assets/images/default.png",
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Judul
          Center(
            child: Text(
              "JOIN WITH US !",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 42,
                fontWeight: FontWeight.w800,
                color: MyColors.secondary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Form Registrasi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // TextField untuk Nama
                TextFieldWithIcon(
                  hintText: 'Username',
                  icon: Icons.person,
                  controller: controller.name,
                ),
                const SizedBox(height: 20),
                // TextField untuk Email
                TextFieldWithIcon(
                  hintText: 'Email',
                  icon: Icons.email,
                  controller: controller.email,
                ),
                const SizedBox(height: 20),
                // TextField untuk Password
                TextFieldWithIcon(
                  hintText: 'Create Password',
                  icon: Icons.lock,
                  obscureText: true,
                  controller: controller.passwordController,
                ),
                const SizedBox(height: 20),
                // Tombol Registrasi
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: MyColors.secondary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Panggil fungsi register
                        controller.register();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: MyColors.accent,
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 25),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: MyColors.accent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
          // Pindah ke Halaman Login jika sudah memiliki akun
          Center(
            child: Column(
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontFamily: "Poppins-Regular",
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: MyColors.secondary,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Pindah ke halaman login
                    Get.toNamed('/login');
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldWithIcon extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;

  const TextFieldWithIcon({
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: (value) {
        // Validasi inputan jika diperlukan
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.7),
        ),
        fillColor: MyColors.primary,
        filled: true,
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
