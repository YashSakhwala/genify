// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/screens/profile/profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List settingTools = [
    {"icons": AppImages.aboutUs, "name": "About Us"},
    {"icons": AppImages.privacyPolicy, "name": "Privacy Policy"},
    {"icons": AppImages.terms, "name": "Terms & Condition"},
    {"icons": AppImages.contact, "name": "Contact Us"},
    {"icons": AppImages.logout, "name": "Logout"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: AppColors.greyColor.shade300,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                size: 25,
                                color: AppColors.greyColor,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width >= 900 ? 2 : 1,
                    mainAxisExtent: 50,
                  ),
                  shrinkWrap: true,
                  itemCount: settingTools.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(
                          width: 0.1,
                          color: AppColors.primaryColor.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Row(
                          children: [
                            Image(
                              image: Image.asset(settingTools[index]["icons"])
                                  .image,
                              color: AppColors.primaryColor,
                              height: 20,
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Text(settingTools[index]["name"]),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Version 1.0",
              style: AppTextStyle.regularTextStyle
                  .copyWith(color: AppColors.primaryColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
