// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/controller/bottom_bar_controller.dart';
import 'package:genify/controller/calculator_controller.dart';
import 'package:genify/screens/home_screen_option/banner_screen.dart';
import 'package:genify/screens/home_screen_option/barcode_screen.dart';
import 'package:genify/screens/home_screen_option/card_screen.dart';
import 'package:genify/screens/home_screen_option/resume_screen.dart';
import 'package:genify/screens/home_screen_option/salary_slip_screen.dart';
import 'package:get/get.dart';
import '../../../config/app_image.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../calculation/other_calculation_view/other_calculation/date_calculation_screen.dart';
import '../../calculation/other_calculation_view/other_calculation_common_view.dart';
import '../../home_screen_option/invoice_screen.dart';
import '../../home_screen_option/voice_recorder_screen.dart';

class HomeCommonViewScreen extends StatefulWidget {
  const HomeCommonViewScreen({Key? key}) : super(key: key);

  @override
  State<HomeCommonViewScreen> createState() => _HomeCommonViewScreenState();
}

class _HomeCommonViewScreenState extends State<HomeCommonViewScreen>
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
    {
      "name": "Voice Recorder",
      "image": AppImages.microphone,
      "navigation": VoiceRecorderScreen(),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBarView(
            title: "Genify",
            style: AppTextStyle.largeTextStyle.copyWith(
              color: AppColors.whiteColor,
            ),
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 90,
                  ),
                  itemCount: homeTools.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => homeTools[index]["navigation"],
                        ));
                      },
                      child: ZoomIn(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 8),
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
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    homeTools[index]["name"],
                                    style: AppTextStyle.regularTextStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                  color: AppColors.greyColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                FlipInX(
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
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.primaryColor.withOpacity(0.85),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Transactions",
                                          style: AppTextStyle.regularTextStyle
                                              .copyWith(
                                            fontSize: 19,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      flyingImage(AppImages.transfer),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Calculators",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        bottomBarController.index.value = 2;
                        calculatorController.isOtherCalculator.value = true;
                      },
                      child: Row(
                        children: [
                          Text(
                            "More",
                            style: AppTextStyle.smallTextStyle.copyWith(
                              fontSize: 13,
                              color: AppColors.greyColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: AppColors.greyColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisExtent: 80,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              homeCalculator[index]["navigation"],
                        ));
                      },
                      child: FlipInX(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                homeCalculator[index]["image"],
                                scale: 18,
                                color: AppColors.primaryColor.withOpacity(0.7),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                homeCalculator[index]["name"],
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
        );
      },
    );
  }
}
