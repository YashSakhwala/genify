// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:genify/controller/bottom_bar_controller.dart';
import 'package:genify/screens/calculator/calculator_screen.dart';
import 'package:genify/screens/Finances/finances_screen.dart';
import 'package:genify/screens/home/home_screen.dart';
import 'package:genify/screens/settings/settings_screen.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';

class BottomBarCommonView extends StatefulWidget {
  const BottomBarCommonView({super.key});

  @override
  State<BottomBarCommonView> createState() => _BottomBarCommonViewState();
}

class _BottomBarCommonViewState extends State<BottomBarCommonView> {
  List bottomScreen = [
    HomeScreen(),
    FinancesScreen(),
    CalculatorScreen(),
    SettingsScreen(),
  ];

  BottomBarController bottomBarController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 25,
        child: Container(
          height: 58,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  bottomBarController.index.value = 0;
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Image.asset(
                        bottomBarController.index.value == 0
                            ? AppImages.fillHome
                            : AppImages.blankHome,
                        height: 18,
                        color: bottomBarController.index.value == 0
                            ? AppColors.primaryColor
                            : AppColors.blackColor,
                      ),
                    ),
                    Obx(
                      () => Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 12,
                          color: bottomBarController.index.value == 0
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomBarController.index.value = 1;
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Image.asset(
                        bottomBarController.index.value == 1
                            ? AppImages.fillHand
                            : AppImages.blankHand,
                        height: 18,
                        color: bottomBarController.index.value == 1
                            ? AppColors.primaryColor
                            : AppColors.blackColor,
                      ),
                    ),
                    Obx(
                      () => Text(
                        "Finances",
                        style: TextStyle(
                          fontSize: 12,
                          color: bottomBarController.index.value == 1
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomBarController.index.value = 2;
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Image.asset(
                        bottomBarController.index.value == 2
                            ? AppImages.fillCalculator
                            : AppImages.blankCalculator,
                        height: 18,
                        color: bottomBarController.index.value == 2
                            ? AppColors.primaryColor
                            : AppColors.blackColor,
                      ),
                    ),
                    Obx(
                      () => Text(
                        "Calculators",
                        style: TextStyle(
                          fontSize: 12,
                          color: bottomBarController.index.value == 2
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomBarController.index.value = 3;
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => Image.asset(
                        bottomBarController.index.value == 3
                            ? AppImages.fillSettings
                            : AppImages.blankSettings,
                        height: 18,
                        color: bottomBarController.index.value == 3
                            ? AppColors.primaryColor
                            : AppColors.blackColor,
                      ),
                    ),
                    Obx(
                      () => Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 12,
                          color: bottomBarController.index.value == 3
                              ? AppColors.primaryColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => bottomScreen[bottomBarController.index.value]),
    );
  }
}
