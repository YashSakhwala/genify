// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/config/local_storage.dart';
import 'package:genify/controller/auth_controller.dart';
import 'package:genify/screens/auth/login_screen.dart';
import 'package:genify/screens/profile/profile_screen.dart';
import 'package:genify/widgets/common_widgets/alert_dialog_box.dart';
import 'package:genify/widgets/common_widgets/indicatior.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthController authController = Get.put(AuthController());

  void logOut() {
    showAlertDialogBox(
        context: context,
        yesOnTap: () async {
          showIndicator(context);

          LocalStorage.sharedPreferences.clear();

          FirebaseAuth firebaseAuth = FirebaseAuth.instance;

          await firebaseAuth.signOut();

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false);
        },
        noOnTap: () {
          Navigator.of(context).pop();
        },
        title: "Log Out",
        subTitle: "Are you sure you want to log out?");
  }

  List settingTools = [
    {"icons": AppImages.aboutUs, "name": "About Us"},
    {"icons": AppImages.privacyPolicy, "name": "Privacy & Policy"},
    {"icons": AppImages.terms, "name": "Terms & Conditions"},
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
                        child: Obx(
                          () => Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: AppColors.whiteColor,
                                    strokeWidth: 2,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(150),
                                    child: Image.network(
                                      authController.userData["image"],
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      authController.userData["name"],
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.whiteColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      authController.userData["email"],
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
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
                    return InkWell(
                      onTap: () async {
                        if (index == 0) {
                          final Uri _url = Uri.parse(
                              "https://doc-hosting.flycricket.io/about-us/4b8bf7f0-0c19-438c-9080-182a6ae68b8f/other");

                          if (!await launchUrl(_url)) {
                            throw Exception("Could not launch $_url");
                          }
                        } else if (index == 1) {
                          final Uri _url = Uri.parse(
                              "https://doc-hosting.flycricket.io/genify-privacy-policy/7fc983ea-570d-437c-938d-bf558fcdeff1/privacy");

                          if (!await launchUrl(_url)) {
                            throw Exception("Could not launch $_url");
                          }
                        } else if (index == 2) {
                          final Uri _url = Uri.parse(
                              "https://doc-hosting.flycricket.io/genify-terms-conditions/30c06fca-c5be-4252-9fa6-c76d1e54bbe6/terms");

                          if (!await launchUrl(_url)) {
                            throw Exception("Could not launch $_url");
                          }
                        } else if (index == 3) {
                          final Uri emailLaunchUri = Uri(
                            scheme: "mailto",
                            path: "yashsakhwala@gmail.com",
                          );

                          await launchUrl(emailLaunchUri);
                        } else if (index == 4) {
                          logOut();
                        }
                      },
                      child: Container(
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
              "Version 1.0.0",
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
