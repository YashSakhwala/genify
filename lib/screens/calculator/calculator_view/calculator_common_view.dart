// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import "package:flutter/material.dart";
import "package:genify/config/app_colors.dart";
import "package:genify/controller/calculator_controller.dart";
import "package:genify/screens/calculator/financial_calculator_screen.dart";
import "package:genify/screens/calculator/other_calculator_screen.dart";
import "package:genify/screens/calculator/simple_calculator_screen.dart";
import "package:get/get.dart";
import "../../../config/app_image.dart";

class CalculatorCommonViewScreen extends StatefulWidget {
  const CalculatorCommonViewScreen({super.key});

  @override
  State<CalculatorCommonViewScreen> createState() =>
      _CalculatorCommonViewScreenState();
}

class _CalculatorCommonViewScreenState
    extends State<CalculatorCommonViewScreen> {
  List calculationScreen = [
    SimpleCalculatorScreen(),
    OtherCalculatorScreen(),
    FinancialCalculatorScreen(),
  ];

  CalculatorController calculatorController = Get.put(CalculatorController());
  PageController pageController = PageController();

  void onPageChanged(int index) {
    calculatorController.index.value = index;
  }

  @override
  void initState() {
    calculatorController.index.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        toolbarHeight: 70,
        title: Container(
          height: MediaQuery.of(context).size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  pageController.jumpToPage(0);
                },
                icon: Obx(
                  () => Image.asset(
                    calculatorController.index.value == 0
                        ? AppImages.fillEqual
                        : AppImages.blankEqual,
                    height: 25,
                    color: calculatorController.index.value == 0
                        ? AppColors.primaryColor
                        : AppColors.blackColor,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  pageController.jumpToPage(1);
                },
                icon: Obx(
                  () => Image.asset(
                    calculatorController.index.value == 1
                        ? AppImages.fillMore
                        : AppImages.blankMore,
                    height: 25,
                    color: calculatorController.index.value == 1
                        ? AppColors.primaryColor
                        : AppColors.blackColor,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  pageController.jumpToPage(2);
                },
                icon: Obx(
                  () => Image.asset(
                    calculatorController.index.value == 2
                        ? AppImages.fillMoney
                        : AppImages.blankMoney,
                    height: 25,
                    color: calculatorController.index.value == 2
                        ? AppColors.primaryColor
                        : AppColors.blackColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: calculationScreen.length,
        itemBuilder: (context, index) {
          return calculationScreen[index];
        },
      ),
    );
  }
}
