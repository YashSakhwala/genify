// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import '../../../../config/app_style.dart';
import '../resume_make_functions.dart';

class AllResumeCommonScreen extends StatefulWidget {
  final String name;
  final String profession;
  final String email;
  final String phoneNo;
  final String address;
  final String aboutMe;
  final List experience;
  final List achivement;
  final List language;
  final List education;
  final List skill;
  final List project;

  const AllResumeCommonScreen({
    super.key,
    required this.name,
    required this.profession,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.aboutMe,
    required this.experience,
    required this.achivement,
    required this.language,
    required this.education,
    required this.skill,
    required this.project,
  });

  @override
  State<AllResumeCommonScreen> createState() => _AllResumeCommonScreenState();
}

class _AllResumeCommonScreenState extends State<AllResumeCommonScreen> {
  List resume = [
    {"image": AppImages.resume1},
    {"image": AppImages.resume2},
    {"image": AppImages.resume3},
    {"image": AppImages.resume4},
    {"image": AppImages.resume5},
    {"image": AppImages.resume6},
    {"image": AppImages.resume7},
    {"image": AppImages.resume8},
    {"image": AppImages.resume9},
    {"image": AppImages.resume10},
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ButtonView(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => BottomBarScreen(),
                          ),
                          (route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.whiteColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          "Home",
                          style: AppTextStyle.smallTextStyle.copyWith(
                            fontSize: 13,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                ),
                Expanded(
                  child: ButtonView(
                    onTap: () {
                      resumeSelection(selectedIndex);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Download",
                          style: AppTextStyle.smallTextStyle.copyWith(
                            fontSize: 13,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.whiteColor,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  Text(
                    "--- Select any one resume ---",
                    style: AppTextStyle.smallTextStyle
                        .copyWith(color: AppColors.greyColor),
                    textAlign: TextAlign.center,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: resume.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          height: 500,
                          width: 200,
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: selectedIndex == index
                                ? Border.all(
                                    color: AppColors.primaryColor,
                                    width: 3,
                                  )
                                : null,
                            image: DecorationImage(
                              image: Image.asset(
                                resume[index]["image"],
                              ).image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resumeSelection(int index) {
    if (index == 0) {
      ResumeMake.function1(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        aboutMe: widget.aboutMe,
        experience: widget.experience,
        achivement: widget.achivement,
        language: widget.language,
        education: widget.education,
        skill: widget.skill,
        project: widget.project,
        context: context,
      );
    } else if (index == 1) {
      ResumeMake.function2(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        aboutMe: widget.aboutMe,
        experience: widget.experience,
        achivement: widget.achivement,
        language: widget.language,
        education: widget.education,
        skill: widget.skill,
        project: widget.project,
        context: context,
      );
    } else if (index == 2) {
      ResumeMake.function3(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        aboutMe: widget.aboutMe,
        experience: widget.experience,
        achivement: widget.achivement,
        language: widget.language,
        education: widget.education,
        skill: widget.skill,
        project: widget.project,
        context: context,
      );
    } else if (index == 3) {
      ResumeMake.function4(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        aboutMe: widget.aboutMe,
        experience: widget.experience,
        achivement: widget.achivement,
        language: widget.language,
        education: widget.education,
        skill: widget.skill,
        project: widget.project,
        context: context,
      );
    } else if (index == 4) {
      ResumeMake.function5(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        aboutMe: widget.aboutMe,
        experience: widget.experience,
        achivement: widget.achivement,
        language: widget.language,
        education: widget.education,
        skill: widget.skill,
        project: widget.project,
        context: context,
      );
    } else if (index == 5) {
      ResumeMake.function6(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        aboutMe: widget.aboutMe,
        experience: widget.experience,
        achivement: widget.achivement,
        language: widget.language,
        education: widget.education,
        skill: widget.skill,
        project: widget.project,
        context: context,
      );
    } else if (index == 6) {
      ResumeMake.function7(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        aboutMe: widget.aboutMe,
        experience: widget.experience,
        achivement: widget.achivement,
        language: widget.language,
        education: widget.education,
        skill: widget.skill,
        project: widget.project,
        context: context,
      );
    } else if (index == 7) {
      ResumeMake.function8(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        aboutMe: widget.aboutMe,
        experience: widget.experience,
        achivement: widget.achivement,
        language: widget.language,
        education: widget.education,
        skill: widget.skill,
        project: widget.project,
        context: context,
      );
    } else if (index == 8) {
      ResumeMake.function9(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        aboutMe: widget.aboutMe,
        experience: widget.experience,
        achivement: widget.achivement,
        language: widget.language,
        education: widget.education,
        skill: widget.skill,
        project: widget.project,
        context: context,
      );
    } else if (index == 9) {
      ResumeMake.function10(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        aboutMe: widget.aboutMe,
        experience: widget.experience,
        achivement: widget.achivement,
        language: widget.language,
        education: widget.education,
        skill: widget.skill,
        project: widget.project,
        context: context,
      );
    }
  }
}
