// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/screens/home_screen_option/resume/resume_view/resume_information_view.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_style.dart';

class ResumeCommonViewScreen extends StatefulWidget {
  const ResumeCommonViewScreen({super.key});

  @override
  State<ResumeCommonViewScreen> createState() => _ResumeCommonViewScreenState();
}

class _ResumeCommonViewScreenState extends State<ResumeCommonViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.whiteColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Resume",
          style: AppTextStyle.largeTextStyle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView(
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 230,
                mainAxisSpacing: 30,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResumeInformationViewScreen(),
                    ));
                  },
                  child: Image.asset(
                    AppImages.resumeImage,
                    height: 70,
                  ),
                  //  AnimatedContainer(
                  //   duration: Duration(milliseconds: 300),
                  //   margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //     color: AppColors.whiteColor,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: AppColors.blackColor.withOpacity(0.3),
                  //         spreadRadius: 1,
                  //         blurRadius: 2,
                  //         offset: Offset(0, 3),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Image.asset(
                  //     AppImages.resumeImage,
                  //     height: 70,
                  //   ),
                  // ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
