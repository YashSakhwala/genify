// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/config/app_style.dart';

class ProfileCommonViewScreen extends StatefulWidget {
  const ProfileCommonViewScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCommonViewScreen> createState() =>
      _ProfileCommonViewScreenState();
}

class _ProfileCommonViewScreenState extends State<ProfileCommonViewScreen> {
  List profile = [
    {"type": "Date of birth", "name": "Birth Date"},
    {"type": "Country or region", "name": "India"},
  ];

  List account = [
    {"type": "Email address", "name": "Email Address"},
    {"type": "Phone number", "name": "Phone Number"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView(
          children: [
            Text(
              "Profile Info",
              style: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blueColor.shade50,
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.key,
                      color: AppColors.blueColor,
                      height: 25,
                    ),
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                Text(
                  "Change password",
                  style: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 0.4, color: AppColors.greyColor),
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
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.greyColor.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                        color: AppColors.greyColor,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Personalize your account with a photo. Your profile photo will appear on apps and devices that use your Genify account.",
                      style: AppTextStyle.smallTextStyle.copyWith(
                        fontSize: 14,
                        color: AppColors.blackColor.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.greyColor),
                      ),
                      child: Center(
                        child: Text(
                          "Change Photo",
                          style: AppTextStyle.smallTextStyle,
                        ),
                      ),
                    ),
                    Divider(),
                    Text(
                      "Full name",
                      style: AppTextStyle.smallTextStyle.copyWith(
                        fontSize: 13,
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      "Name",
                      style: AppTextStyle.regularTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 0.4, color: AppColors.greyColor),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Profile info",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: profile
                          .map(
                            (e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e["type"],
                                  style: AppTextStyle.smallTextStyle.copyWith(
                                    fontSize: 13,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                                Text(
                                  e["name"],
                                  style: AppTextStyle.regularTextStyle,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 0.4, color: AppColors.greyColor),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Account info",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: account
                          .map(
                            (e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e["type"],
                                  style: AppTextStyle.smallTextStyle.copyWith(
                                    fontSize: 13,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                                Text(
                                  e["name"],
                                  style: AppTextStyle.regularTextStyle,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
