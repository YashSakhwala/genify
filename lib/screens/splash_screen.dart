// ignore_for_file: prefer_const_constructors

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/config/local_storage.dart';
import 'package:genify/screens/auth/login_screen.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.put(AuthController());
  bool? isLogIn;

  @override
  void initState() {
    isLogIn = LocalStorage.sharedPreferences.getBool(LocalStorage.logIn);

    if (isLogIn == true) {
      authController.getProfile(context: context);
    } else {
      Future.delayed(
        Duration(seconds: 3),
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (route) => false,
          );
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AvatarGlow(
          startDelay: const Duration(milliseconds: 1000),
          glowColor: AppColors.greyColor,
          glowShape: BoxShape.circle,
          curve: Curves.fastOutSlowIn,
          child: Material(
            elevation: 8.0,
            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: 70.0,
              child: Image.asset(
                AppImages.whiteLogo,
                height: 130,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
