// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable, unnecessary_to_list_in_spreads

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/screens/home_screen_option/resume_view/all_resume_view/web_all_resume_view.dart';
import "package:universal_html/html.dart" as html;
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';
import 'resume_make_functions.dart';

class WebResumeScreen extends StatefulWidget {
  const WebResumeScreen({super.key});

  @override
  State<WebResumeScreen> createState() => _WebResumeScreenState();
}

class _WebResumeScreenState extends State<WebResumeScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController profession = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController aboutMe = TextEditingController();
  final List experiences = [];
  final List achivements = [];
  final List languages = [];
  final List educations = [];
  final List skills = [];
  final List projects = [];

  @override
  void initState() {
    ResumeMake.imagePath = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: FlipInX(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 7,
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.greyColor.shade300,
                              image: DecorationImage(
                                image: ResumeMake.imagePath.isEmpty
                                    ? Image.asset(
                                        AppImages.addImage,
                                        color: AppColors.greyColor.shade300,
                                        scale: 12,
                                      ).image
                                    : Image.network(
                                        ResumeMake.imagePath,
                                      ).image,
                                fit: ResumeMake.imagePath.isEmpty
                                    ? BoxFit.scaleDown
                                    : BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Some person require resume without image, so check before adding one.",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          InkWell(
                            onTap: () async {
                              html.FileUploadInputElement uploadInput =
                                  html.FileUploadInputElement();
                              uploadInput.accept = 'image/*';
                              uploadInput.click();

                              uploadInput.onChange.listen((event) {
                                final file = uploadInput.files!.first;
                                final reader = html.FileReader();

                                reader.readAsDataUrl(file);
                                reader.onLoadEnd.listen((event) {
                                  setState(() {
                                    ResumeMake.imagePath =
                                        reader.result as String;
                                  });
                                });
                              });
                            },
                            child: Container(
                              height: 43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Upload Image",
                                  style: AppTextStyle.regularTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 60,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFieldView(
                            title: "Name",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: name,
                            hintText: "Varun Mishra",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldView(
                            title: "Phone Number",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: phoneNo,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            hintText: "9876543210",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldView(
                            title: "Address",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: address,
                            maxLines: 4,
                            vertical: 4,
                            hintText:
                                "105-A, Ambar society, Neharu chock, surat.",
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Experiences
                          ...experiences.asMap().entries.map((entry) {
                            int experianceIndex = entry.key;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFieldView(
                                      title: "Experience",
                                      titleStyle: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      anyWidget: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7),
                                        child: Text(
                                          'eg: (Job title\n Company\n Date)',
                                          style: AppTextStyle.regularTextStyle
                                              .copyWith(
                                            fontSize: 12,
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                      ),
                                      controller: experiences[experianceIndex],
                                      maxLines: 4,
                                      vertical: 4,
                                      hintText: "Job-title \nCompany \nDate",
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        experiences.removeAt(experianceIndex);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 23,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add Experiences",
                                  style: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                            height: 50,
                            containerColor: AppColors.backgroundColor,
                            border: Border.all(color: AppColors.primaryColor),
                            onTap: () {
                              setState(() {
                                experiences.add(TextEditingController());
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Languages
                          ...languages.asMap().entries.map((entry) {
                            int languageIndex = entry.key;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFieldView(
                                      title: "Language",
                                      titleStyle: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: languages[languageIndex],
                                      hintText: "Hindi",
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        languages.removeAt(languageIndex);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 23,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add Languages",
                                  style: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                            height: 50,
                            containerColor: AppColors.backgroundColor,
                            border: Border.all(color: AppColors.primaryColor),
                            onTap: () {
                              setState(() {
                                languages.add(TextEditingController());
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Skills
                          ...skills.asMap().entries.map((entry) {
                            int skillIndex = entry.key;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFieldView(
                                      title: "Skill",
                                      titleStyle: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: skills[skillIndex],
                                      hintText: "Problem solving",
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        skills.removeAt(skillIndex);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 23,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add Skills",
                                  style: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                            height: 50,
                            containerColor: AppColors.backgroundColor,
                            border: Border.all(color: AppColors.primaryColor),
                            onTap: () {
                              setState(() {
                                skills.add(TextEditingController());
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 60,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFieldView(
                            title: "Profession",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: profession,
                            hintText: "Software Engineer",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldView(
                            title: "Email",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: email,
                            hintText: "mishra.varun@email.com",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldView(
                            title: "Summary",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: aboutMe,
                            maxLines: 4,
                            vertical: 4,
                            hintText:
                                "I am a professional software developer for all type of cross-plateform developement.",
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Achivements
                          ...achivements.asMap().entries.map((entry) {
                            int achivementIndex = entry.key;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFieldView(
                                      title: "Achivement",
                                      titleStyle: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: achivements[achivementIndex],
                                      hintText: "Best in sports",
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        achivements.removeAt(achivementIndex);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 23,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add Achivements",
                                  style: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                            height: 50,
                            containerColor: AppColors.backgroundColor,
                            border: Border.all(color: AppColors.primaryColor),
                            onTap: () {
                              setState(() {
                                achivements.add(TextEditingController());
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Educations
                          ...educations.asMap().entries.map((entry) {
                            int educationIndex = entry.key;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFieldView(
                                      title: "Education",
                                      titleStyle: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      anyWidget: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7),
                                        child: Text(
                                          "eg: (Degree\n Year\n Collage name)",
                                          style: AppTextStyle.regularTextStyle
                                              .copyWith(
                                            fontSize: 12,
                                            color: AppColors.greyColor,
                                          ),
                                        ),
                                      ),
                                      controller: educations[educationIndex],
                                      maxLines: 4,
                                      vertical: 4,
                                      hintText: "Degree \nYear \nCollage name",
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        educations.removeAt(educationIndex);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 23,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add Educations",
                                  style: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                            height: 50,
                            containerColor: AppColors.backgroundColor,
                            border: Border.all(color: AppColors.primaryColor),
                            onTap: () {
                              setState(() {
                                educations.add(TextEditingController());
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Projects
                          ...projects.asMap().entries.map((entry) {
                            int projectIndex = entry.key;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFieldView(
                                      title: "Project",
                                      titleStyle: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: projects[projectIndex],
                                      maxLines: 4,
                                      vertical: 4,
                                      hintText: "Project-name \nAbout project",
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        projects.removeAt(projectIndex);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 23,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add Projects",
                                  style: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                            height: 50,
                            containerColor: AppColors.backgroundColor,
                            border: Border.all(color: AppColors.primaryColor),
                            onTap: () {
                              setState(() {
                                projects.add(TextEditingController());
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                ButtonView(
                  height: 45,
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.whiteColor,
                        size: 15,
                      ),
                    ],
                  ),
                  onTap: () {
                    List exp = experiences
                        .map((controller) => controller.text)
                        .toList();
                    List ach = achivements
                        .map((controller) => controller.text)
                        .toList();
                    List lan =
                        languages.map((controller) => controller.text).toList();
                    List edu = educations
                        .map((controller) => controller.text)
                        .toList();
                    List skill =
                        skills.map((controller) => controller.text).toList();
                    List prj =
                        projects.map((controller) => controller.text).toList();

                    if (name.text.isEmpty ||
                        profession.text.isEmpty ||
                        email.text.isEmpty ||
                        phoneNo.text.isEmpty ||
                        address.text.isEmpty ||
                        aboutMe.text.isEmpty) {
                      toastView(
                        msg: "Please fill all details",
                        context: context,
                      );
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebAllResumeScreen(
                          name: name.text,
                          profession: profession.text,
                          email: email.text,
                          phoneNo: phoneNo.text,
                          address: address.text,
                          aboutMe: aboutMe.text,
                          experience: exp,
                          achivement: ach,
                          language: lan,
                          education: edu,
                          skill: skill,
                          project: prj,
                        ),
                      ));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
