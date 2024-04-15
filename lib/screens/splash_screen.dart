// ignore_for_file: prefer_const_constructors

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/controller/local_storage.dart';
import 'package:genify/screens/auth/login_screen.dart';
import 'package:genify/screens/bottom_bar/bottom_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? logIn;

  @override
  void initState() {
    logIn = LocalStorage.sharedPreferences.getBool(LocalStorage.logIn);

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              logIn == true ? BottomBarScreen() : LoginScreen(),
        ),
        (route) => false,
      );
    });
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
