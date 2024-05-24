// ignore_for_file: prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import '../../config/app_colors.dart';
import '../../config/app_style.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});
  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(
                  "assets/images/no_internet.jpg",
                ).image,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor.withOpacity(0.7),
                  BlendMode.darken,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Lottie.asset(
                      "assets/lottie/no_internet.json",
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                  ),
                  Center(
                    child: Text(
                      "No Internet \nConnection",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 28,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "Please check your internet \nconnection",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.regularTextStyle
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
