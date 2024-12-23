// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_to_list_in_spreads, unused_local_variable

import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';
import '../resume_view/resume_make_functions.dart';

class MarksheetCommonViewScreen extends StatefulWidget {
  const MarksheetCommonViewScreen({super.key});

  @override
  State<MarksheetCommonViewScreen> createState() =>
      _MarksheetCommonViewScreenState();
}

class _MarksheetCommonViewScreenState extends State<MarksheetCommonViewScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController profession = TextEditingController();
  final List<Map<String, TextEditingController>> subjects = [];

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
        title: "Marksheet",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: FlipInX(
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
                            "Add Student Image",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Some person require marksheet without image, so check before adding one.",
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
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              TextFieldView(
                title: "Student Name",
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

              // Subject List
              ...subjects.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, TextEditingController> item = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFieldView(
                          title: "Subject Name",
                          titleStyle: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: item["name"]!,
                          hintText: "Science",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFieldView(
                          title: "Total Marks",
                          titleStyle: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: item["totalMarks"]!,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9\.]')),
                          ],
                          hintText: "0",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFieldView(
                          title: "Given Marks",
                          titleStyle: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: item["givenMarks"]!,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9\.]')),
                          ],
                          hintText: "0",
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            subjects.removeAt(index);
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
                      "Add Subjects",
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
                    subjects.add({
                      "name": TextEditingController(),
                      "totalMarks": TextEditingController(),
                      "givenMarks": TextEditingController()
                    });
                  });
                },
              ),

              SizedBox(
                height: 80,
              ),
              ButtonView(
                title: "Continue",
                onTap: () {
                  List<Map<String, String>> subjectList = subjects.map((item) {
                    return {
                      "name": item["name"]!.text,
                      "totalMarks": item["totalMarks"]!.text,
                      "givenMarks": item["givenMarks"]!.text
                    };
                  }).toList();

                  if (name.text.isEmpty || profession.text.isEmpty) {
                    toastView(
                      msg: "Please fill all details",
                      context: context,
                    );
                  } else if (subjects.isEmpty) {
                    toastView(
                      msg: "Please fill item details",
                      context: context,
                    );
                  } else if (subjects
                      .any((subject) => subject["name"]!.text.isEmpty)) {
                    toastView(
                      msg: "Please fill item name",
                      context: context,
                    );
                  } else {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => AllResumeCommonScreen(
                    //     name: name.text,
                    //     profession: profession.text,
                    //     email: email.text,
                    //     phoneNo: phoneNo.text,
                    //     address: address.text,
                    //     aboutMe: aboutMe.text,
                    //     experience: exp,
                    //     achivement: ach,
                    //     language: lan,
                    //     education: edu,
                    //     skill: skill,
                    //     project: prj,
                    //   ),
                    // ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
