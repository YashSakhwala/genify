// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import '../../../config/app_style.dart';
import 'login_common_view.dart';

class WebLoginViewScreen extends StatefulWidget {
  const WebLoginViewScreen({super.key});

  @override
  State<WebLoginViewScreen> createState() => _WebLoginViewScreenState();
}

class _WebLoginViewScreenState extends State<WebLoginViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 60),
                  child: Text(
                    "Genify",
                    style: AppTextStyle.largeTextStyle.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 35,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset(AppImages.main).image,
                        alignment: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 90,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 3,
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: LoginCommonView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
