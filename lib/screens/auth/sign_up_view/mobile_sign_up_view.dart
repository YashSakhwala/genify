// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/config/app_style.dart';
import 'sign_up_common_view.dart';

class MobileSignUpViewScreen extends StatefulWidget {
  const MobileSignUpViewScreen({super.key});

  @override
  State<MobileSignUpViewScreen> createState() => _MobileLoginViewScreenState();
}

class _MobileLoginViewScreenState extends State<MobileSignUpViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 240,
                width: double.infinity,
                color: AppColors.primaryColor,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Genify",
                  style: AppTextStyle.largeTextStyle.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 35,
                  ),
                ),
              ),
              Positioned.fill(
                child: Image.asset(
                  AppImages.main,
                  alignment: Alignment.bottomLeft,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: SignUpCommomView(),
          ),
        ],
      ),
    );
  }
}
