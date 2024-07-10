// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/screens/add_expenses/add_expenses_screen.dart';
import 'package:genify/screens/add_income/add_income_screen.dart';
import 'package:get/get.dart';
import '../../../config/app_image.dart';
import '../../../controller/bottom_bar_controller.dart';
import '../../../controller/calculator_controller.dart';
import '../../calculation/other_calculation_view/other_calculation/date_calculation_screen.dart';
import '../../calculation/other_calculation_view/other_calculation_common_view.dart';
import '../../home_screen_option/banner_screen.dart';
import '../../home_screen_option/barcode_screen.dart';
import '../../home_screen_option/card_screen.dart';
import '../../home_screen_option/invoice_screen.dart';
import '../../home_screen_option/resume_screen.dart';
import '../../home_screen_option/salary_slip_screen.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen>
    with SingleTickerProviderStateMixin {
  BottomBarController bottomBarController = Get.put(BottomBarController());
  CalculatorController calculatorController = Get.put(CalculatorController());

  List homeTools = [
    {
      "name": "Resume",
      "image": AppImages.resume,
      "navigation": ResumeScreen(),
    },
    {
      "name": "Invoice",
      "image": AppImages.invoice,
      "navigation": InvoiceScreen(),
    },
    {
      "name": "Card",
      "image": AppImages.card,
      "navigation": CardScreen(),
    },
    {
      "name": "Barcode",
      "image": AppImages.barcode,
      "navigation": BarcodeScreen(),
    },
    {
      "name": "Banner",
      "image": AppImages.banner,
      "navigation": BannerScreen(),
    },
    {
      "name": "Salary Slip",
      "image": AppImages.salary,
      "navigation": SalarySlipScreen(),
    },
  ];

  List homeCalculator = [
    {
      "name": "Age",
      "image": AppImages.age,
      "navigation": DateCalculationScreen(
        title: 'Age',
      ),
    },
    {
      "name": "Length",
      "image": AppImages.length,
      "navigation": OtherCalculationCommonViewScreen(index: 7),
    },
    {
      "name": "Speed",
      "image": AppImages.speed,
      "navigation": OtherCalculationCommonViewScreen(index: 10),
    },
    {
      "name": "Power",
      "image": AppImages.power,
      "navigation": OtherCalculationCommonViewScreen(index: 17),
    },
    {
      "name": "Number",
      "image": AppImages.number,
      "navigation": OtherCalculationCommonViewScreen(index: 18),
    },
  ];

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget flyingImage(String image) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        height: 180,
        width: 150,
        decoration: BoxDecoration(
          color: AppColors.transparentColor,
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ZoomIn(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 100,
                      ),
                      itemCount: homeTools.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  homeTools[index]["navigation"],
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 0.5,
                              ),
                              color: AppColors.primaryColor.withOpacity(0.06),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Image.asset(
                                    homeTools[index]["image"],
                                    height: 45,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      homeTools[index]["name"],
                                      style: AppTextStyle.regularTextStyle
                                          .copyWith(fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: AppColors.greyColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ZoomIn(
                  child: Container(
                    height: 325,
                    width: 300,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              bottomBarController.index.value = 1;
                            },
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.primaryColor.withOpacity(0.85),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Transactions",
                                            style: AppTextStyle.regularTextStyle
                                                .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Find your experience to take care of your transactions",
                                            style: AppTextStyle.regularTextStyle
                                                .copyWith(
                                              fontSize: 10,
                                              color: AppColors.whiteColor,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    AddIncomeScreen(),
                                              ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .backgroundColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Image.asset(
                                                            AppImages.income),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Add Incomes",
                                                            style: AppTextStyle
                                                                .regularTextStyle
                                                                .copyWith(
                                                              fontSize: 11,
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 9,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    AddExpensesScreen(),
                                              ));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .backgroundColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Image.asset(
                                                            AppImages.expenses),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Add Expenses",
                                                            style: AppTextStyle
                                                                .regularTextStyle
                                                                .copyWith(
                                                              fontSize: 11,
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: flyingImage(AppImages.transfer),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ZoomIn(
                    child: Container(
                      height: 200,
                      width: 700,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 0.5,
                        ),
                        color: AppColors.primaryColor.withOpacity(0.04),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Calculators",
                                  style: AppTextStyle.regularTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    bottomBarController.index.value = 2;
                                    calculatorController
                                        .isOtherCalculator.value = true;
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "More",
                                        style: AppTextStyle.smallTextStyle
                                            .copyWith(
                                          fontSize: 12,
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 14,
                                        color: AppColors.greyColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisExtent: 80,
                              ),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          homeCalculator[index]["navigation"],
                                    ));
                                  },
                                  child: FlipInX(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            homeCalculator[index]["image"],
                                            scale: 18,
                                            color: AppColors.primaryColor,
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            homeCalculator[index]["name"],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
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
                  ),
                ),
                SizedBox(
                  width: 320,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
