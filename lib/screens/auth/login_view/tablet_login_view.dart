// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import 'login_common_view.dart';

class TabletLoginViewScreen extends StatefulWidget {
  const TabletLoginViewScreen({super.key});

  @override
  State<TabletLoginViewScreen> createState() => _TabletLoginViewScreenState();
}

class _TabletLoginViewScreenState extends State<TabletLoginViewScreen> {
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
            height: 40,
          ),
          Center(
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
                  child: LoginCommonView(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
