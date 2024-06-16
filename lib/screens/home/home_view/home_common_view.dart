// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/screens/home_screen_option/banner_screen.dart';
import 'package:genify/screens/home_screen_option/card_screen.dart';
import 'package:genify/screens/home_screen_option/resume_screen.dart';
import 'package:genify/screens/home_screen_option/salary_slip_screen.dart';
import '../../../config/app_image.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../home_screen_option/invoice_screen.dart';

class HomeCommonViewScreen extends StatefulWidget {
  const HomeCommonViewScreen({Key? key}) : super(key: key);

  @override
  State<HomeCommonViewScreen> createState() => _HomeCommonViewScreenState();
}

class _HomeCommonViewScreenState extends State<HomeCommonViewScreen> {
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
      "navigation": ResumeScreen(),
    },
    {
      "name": "Banner",
      "image": AppImages.banner,
      "navigation": BannerScreen(),
    },
    {
      "name": "Salary slip",
      "image": AppImages.salary,
      "navigation": SalarySlipScreen(),
    }
  ];

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
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(13),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 180,
                  ),
                  itemCount: homeTools.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => homeTools[index]["navigation"],
                        ));
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              homeTools[index]["image"],
                              height: 70,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                homeTools[index]["name"],
                                style: AppTextStyle.regularTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
