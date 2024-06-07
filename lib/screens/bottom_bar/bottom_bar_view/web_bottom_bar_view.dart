// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/screens/expenses/expenses_screen.dart';
import 'package:genify/screens/home/home_screen.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_style.dart';
import '../../../controller/bottom_bar_controller.dart';
import '../../calculator/calculator_screen.dart';
import '../../settings/settings_screen.dart';

class WebBottomBarScreen extends StatefulWidget {
  const WebBottomBarScreen({super.key});

  @override
  State<WebBottomBarScreen> createState() => _WebBottomBarScreenState();
}

class _WebBottomBarScreenState extends State<WebBottomBarScreen> {
  BottomBarController bottomBarController = Get.put(BottomBarController());

  List bottomTools = [
    {
      "fillIcons": AppImages.blankHome,
      "blankIcons": AppImages.fillHome,
      "name": "Home"
    },
    {
      "fillIcons": AppImages.blankHand,
      "blankIcons": AppImages.fillHand,
      "name": "Expenses"
    },
    {
      "fillIcons": AppImages.blankCalculator,
      "blankIcons": AppImages.fillCalculator,
      "name": "Calculators"
    },
    {
      "fillIcons": AppImages.blankSettings,
      "blankIcons": AppImages.fillSettings,
      "name": "Settings"
    },
  ];

  List bottomScreen = [
    HomeScreen(),
    ExpensesScreen(),
    CalculatorScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: AppColors.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.whiteLogo,
                        height: 70,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Genify",
                        style: AppTextStyle.largeTextStyle.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: bottomTools.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          bottomBarController.index.value = index;
                        },
                        child: Obx(
                          () => Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: bottomBarController.index.value == index
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Image(
                                    image: bottomBarController.index.value ==
                                            index
                                        ? Image.asset(bottomTools[index]
                                                ["blankIcons"])
                                            .image
                                        : Image.asset(
                                                bottomTools[index]["fillIcons"])
                                            .image,
                                    height: 23,
                                    color:
                                        bottomBarController.index.value == index
                                            ? AppColors.primaryColor
                                            : AppColors.whiteColor,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    bottomTools[index]["name"],
                                    style:
                                        AppTextStyle.regularTextStyle.copyWith(
                                      color: bottomBarController.index.value ==
                                              index
                                          ? AppColors.primaryColor
                                          : AppColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => bottomScreen[bottomBarController.index.value],
            ),
          ),
        ],
      ),
    );
  }
}
