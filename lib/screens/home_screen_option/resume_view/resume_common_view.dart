// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable, avoid_print

import "dart:io";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:genify/screens/home_screen_option/resume_view/resume_make_functions.dart";
import "package:genify/widgets/common_widgets/text_field_view.dart";
import "package:image_picker/image_picker.dart";
import "../../../../config/app_colors.dart";
import "../../../../config/app_image.dart";
import "../../../../config/app_style.dart";
import "../../../../widgets/common_widgets/appbar.dart";
import "../../../../widgets/common_widgets/button_view.dart";
import "../../../widgets/common_widgets/toast_view.dart";
import "all_resume_view/all_resume_common_view.dart";

class ResumeCommonViewScreen extends StatefulWidget {
  const ResumeCommonViewScreen({super.key});

  @override
  State<ResumeCommonViewScreen> createState() => _ResumeCommonViewScreenState();
}

class _ResumeCommonViewScreenState extends State<ResumeCommonViewScreen> {
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
      appBar: AppBarView(
        title: "Resume",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.greyColor.shade300,
                    image: DecorationImage(
                      image: ResumeMake.imagePath.isEmpty
                          ? Image.asset(
                              AppImages.addImage,
                              color: AppColors.greyColor.shade300,
                              scale: 12,
                            ).image
                          : Image.file(
                              File(ResumeMake.imagePath),
                            ).image,
                      fit: ResumeMake.imagePath.isEmpty
                          ? BoxFit.scaleDown
                          : BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 17,
                ),
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add a Photo",
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Some employers require resumes without photos, so check before adding one.",
                          style: AppTextStyle.regularTextStyle
                              .copyWith(fontSize: 9),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            ImagePicker imagePicker = ImagePicker();

                            XFile? xFile = await imagePicker.pickImage(
                                source: ImageSource.gallery);

                            if (xFile != null && xFile.path.isNotEmpty) {
                              ResumeMake.imagePath = xFile.path;
                            }

                            setState(() {});
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
                                "Upload Photo",
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
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
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
              title: "Phone Number",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: phoneNo,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              hintText: "9876543210",
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
              title: "Address",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: address,
              maxLines: 4,
              vertical: 4,
              hintText: "105-A, Ambar society, Neharu chock, surat.",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "About Me",
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
                        titleStyle: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: experiences[experianceIndex],
                        maxLines: 4,
                        vertical: 4,
                        hintText: "Job title \nCompany \nDate",
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
              height: 30,
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
                        titleStyle: AppTextStyle.regularTextStyle.copyWith(
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
              height: 30,
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
                        titleStyle: AppTextStyle.regularTextStyle.copyWith(
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
              height: 30,
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
                        titleStyle: AppTextStyle.regularTextStyle.copyWith(
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
              height: 30,
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
                        titleStyle: AppTextStyle.regularTextStyle.copyWith(
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
            SizedBox(
              height: 30,
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
                        titleStyle: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: projects[projectIndex],
                        maxLines: 4,
                        vertical: 4,
                        hintText: "Project name \nAbout project",
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

            SizedBox(
              height: 80,
            ),
            ButtonView(
              title: "Continue",
              onTap: () {
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AllResumeCommonScreen(
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
    );
  }
}
