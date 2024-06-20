// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
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
    ResumeMake.webImageFile = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
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
                          "Some employers require resumes without photos, so check before adding one.",
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
                                  ResumeMake.webImageFile = file;
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
                                "Upload photo",
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
                          title: "Phone number",
                          titleStyle: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: phoneNo,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                                    titleStyle:
                                        AppTextStyle.regularTextStyle.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
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
                                    titleStyle:
                                        AppTextStyle.regularTextStyle.copyWith(
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
                                "Add languages",
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
                                    titleStyle:
                                        AppTextStyle.regularTextStyle.copyWith(
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
                                "Add skills",
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
                          title: "About me",
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
                                    titleStyle:
                                        AppTextStyle.regularTextStyle.copyWith(
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
                                "Add achivements",
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
                                    titleStyle:
                                        AppTextStyle.regularTextStyle.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
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
                                "Add educations",
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
                                    titleStyle:
                                        AppTextStyle.regularTextStyle.copyWith(
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
                                "Add projects",
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
                  log("Name-----> ${name.text}");
                  log("Profession-----> ${profession.text}");
                  log("Email-----> ${email.text}");
                  log("PhoneNo-----> ${phoneNo.text}");
                  log("Address-----> ${address.text}");
                  log("AboutMe-----> ${aboutMe.text}");
                  log("Experiance-----> ${experiences.map((controller) => controller.text).toList()}");
                  log("Achivement-----> ${achivements.map((controller) => controller.text).toList()}");
                  log("Languages-----> ${languages.map((controller) => controller.text).toList()}");
                  log("Eductions-----> ${educations.map((controller) => controller.text).toList()}");
                  log("Skills-----> ${skills.map((controller) => controller.text).toList()}");
                  log("Projects-----> ${projects.map((controller) => controller.text).toList()}");

                  List exp =
                      experiences.map((controller) => controller.text).toList();
                  List ach =
                      achivements.map((controller) => controller.text).toList();
                  List lan =
                      languages.map((controller) => controller.text).toList();
                  List edu =
                      educations.map((controller) => controller.text).toList();
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
                    ResumeMake.function1(
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
                      context: context,
                    );
                  }

                  // ResumeMake.function10(
                  //   name: "Yash sakhwala",
                  //   profession: "Flutter developer",
                  //   email: "yashsakhwala@gmail.com",
                  //   phoneNo: "9723831969",
                  //   address: "Surat",
                  //   aboutMe:
                  //       "Professional fluter developer for cross-platform developement",
                  //   experience: ["Flutter team manager \nTCS \n2020-current"],
                  //   achivement: [
                  //     "Best batsman award in inter school compatition",
                  //   ],
                  //   language: ["Hindi", "Gujarati", "English"],
                  //   education: [
                  //     "HSC \n2022 \nAkshar jyoti high school",
                  //     "BCA \n2024 \nS.V. patel college",
                  //     "BBA \n2020 \nSDJ college",
                  //   ],
                  //   skill: [
                  //     "Dart",
                  //     "GitHub",
                  //     "Problem Solving",
                  //   ],
                  //   project: [
                  //     "Quiz up \nMCQ exam application",
                  //     "Genify \nInvoice application"
                  //   ],
                  //   context: context,
                  // );

                  // ResumeMake.function6(
                  //   name: "Yash Sakhwala",
                  //   profession: "Flutter developer",
                  //   email: "yashsakhwal@gmail.com",
                  //   phoneNo: "9723831969",
                  //   address:
                  //       "19, Sangam society, rakatha road, ambatalavadi, katargam, Surat - 395004",
                  //   aboutMe:
                  //       "As a developer, I'm like a digital architect, crafting the intricate frameworks and structures that power the virtual world. My expertise spans across various programming languages, databases, and software development methodologies. Whether it's creating sleek websites, robust mobile applications, or complex software solutions, I thrive on turning ideas into functional, user-friendly realities. With a keen eye for detail and a passion for innovation, I'm dedicated to delivering high-quality, scalable solutions that meet and exceed client expectations.",
                  //   experience: [
                  //     "Junior developer \nMD infotexh \n2020-2022",
                  //     "Senior developer \nTCS \n2022-2023",
                  //     "CEO \nOracle \n2023-Current",
                  //   ],
                  //   achivement: [
                  //     "Earning a scholarship award in school.",
                  //     "Winning a championship at collagiate level.",
                  //     "Seleted for the National Defence Academy (NDA).",
                  //     "Best oppening betsman award in inter college cricket championship.",
                  //   ],
                  //   language: [
                  //     "English",
                  //     "Hindi",
                  //     "Gujarati",
                  //     "Marathi",
                  //     "Spanish",
                  //     "German",
                  //   ],
                  //   education: [
                  //     "SSC \n2020 \nYogi pravruti vidhyalay",
                  //     "HSC \n2022 \nAkshar jyoti high school",
                  //     "BCA \n2024 \nShri shambhubhai v. patel college of computer science and business management",
                  //   ],
                  //   skill: [
                  //     "Flutter",
                  //     "Dart",
                  //     "GitHub",
                  //     "Problem Solving",
                  //     "Python",
                  //     "SQL",
                  //     "VB.Net",
                  //   ],
                  //   project: [
                  //     "Quiz up \nMCQ based exam application for school and college students.",
                  //     "Genify \nInvoice application for business related work.",
                  //     "WhatsApp \nCommunication application for all type of purpose.",
                  //     "Travellingo \nTravelling relatedd application for all tourist.",
                  //   ],
                  //   context: context,
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
