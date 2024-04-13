// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import '../../../config/app_image.dart';
import '../../../widgets/common_widgets/appbar_view.dart';

class HomeCommonViewScreen extends StatefulWidget {
  const HomeCommonViewScreen({Key? key}) : super(key: key);

  @override
  State<HomeCommonViewScreen> createState() => _HomeCommonViewScreenState();
}

class _HomeCommonViewScreenState extends State<HomeCommonViewScreen> {
  List homeTools = [
    {"name": "Resume", "image": AppImages.resume},
    {"name": "Invoice", "image": AppImages.invoice},
    {"name": "Card", "image": AppImages.card},
    {"name": "Barcode", "image": AppImages.barcode},
    {"name": "Banner", "image": AppImages.banner},
    {"name": "Salary slip", "image": AppImages.salary}
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: appBarView(title: "Genify"),
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
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
