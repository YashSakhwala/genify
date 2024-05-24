// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import 'sign_up_common_view.dart';

class TabletSignUpViewScreen extends StatefulWidget {
  const TabletSignUpViewScreen({super.key});

  @override
  State<TabletSignUpViewScreen> createState() => _TabletLoginViewScreenState();
}

class _TabletLoginViewScreenState extends State<TabletSignUpViewScreen> {
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
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 50),
            child: Center(
              child: Material(
                elevation: 25,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SignUpCommomView(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
