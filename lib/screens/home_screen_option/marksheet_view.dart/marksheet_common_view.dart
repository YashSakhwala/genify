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
import 'marksheet_make_function.dart';

class MarksheetCommonViewScreen extends StatefulWidget {
  const MarksheetCommonViewScreen({super.key});

  @override
  State<MarksheetCommonViewScreen> createState() =>
      _MarksheetCommonViewScreenState();
}

class _MarksheetCommonViewScreenState extends State<MarksheetCommonViewScreen> {
  final TextEditingController collegeName = TextEditingController();
  final TextEditingController passingMonth = TextEditingController();
  final TextEditingController passingYear = TextEditingController();
  final TextEditingController studentName = TextEditingController();
  final TextEditingController course = TextEditingController();
  final TextEditingController seatNumber = TextEditingController();
  String? classObtained;
  final List<Map<String, TextEditingController>> subjects = [];

  @override
  void initState() {
    MarksheetMake.collegeLogoImagePath = "";
    MarksheetMake.studentImagePath = "";
    MarksheetMake.principalSignatureImagePath = "";
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
              // College details
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
                        image: MarksheetMake.collegeLogoImagePath.isEmpty
                            ? Image.asset(
                                AppImages.addImage,
                                color: AppColors.greyColor.shade300,
                                scale: 12,
                              ).image
                            : Image.file(
                                File(MarksheetMake.collegeLogoImagePath),
                              ).image,
                        fit: MarksheetMake.collegeLogoImagePath.isEmpty
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
                            "Add College Logo",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Some college require marksheet without logo, so check before adding one.",
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
                                MarksheetMake.collegeLogoImagePath = xFile.path;
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
                                  "Upload Logo",
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
                title: "College Name",
                titleStyle: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                controller: collegeName,
                hintText: "S.V. Patel College",
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldView(
                      title: "Passsing Month",
                      titleStyle: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      controller: passingMonth,
                      hintText: "April",
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFieldView(
                      title: "Passsing Year",
                      titleStyle: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      controller: passingYear,
                      hintText: "2024",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),

              // Student details
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
                        image: MarksheetMake.studentImagePath.isEmpty
                            ? Image.asset(
                                AppImages.addImage,
                                color: AppColors.greyColor.shade300,
                                scale: 12,
                              ).image
                            : Image.file(
                                File(MarksheetMake.studentImagePath),
                              ).image,
                        fit: MarksheetMake.studentImagePath.isEmpty
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
                                MarksheetMake.studentImagePath = xFile.path;
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
                controller: studentName,
                hintText: "Varun Mishra",
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldView(
                title: "Course Name",
                titleStyle: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                controller: course,
                hintText: "Bachelor of Computer Application",
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldView(
                title: "Seat Number",
                titleStyle: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                controller: seatNumber,
                hintText: "123456",
              ),
              SizedBox(
                height: 30,
              ),

              // Subject List
              ...subjects.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, TextEditingController> subject = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldView(
                        title: "Subject Name",
                        titleStyle: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: subject["subjectName"]!,
                        hintText: "Maths",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFieldView(
                              title: "Total Marks",
                              titleStyle:
                                  AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              controller: subject["totalMarks"]!,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9\.]')),
                              ],
                              hintText: "100",
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFieldView(
                              title: "Qualifying Marks",
                              titleStyle:
                                  AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              controller: subject["qualifyingMarks"]!,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9\.]')),
                              ],
                              hintText: "33",
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFieldView(
                              title: "Obtained Marks",
                              titleStyle:
                                  AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              controller: subject["obtainedMarks"]!,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9\.]')),
                              ],
                              hintText: "70",
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
                      "subjectName": TextEditingController(),
                      "totalMarks": TextEditingController(),
                      "qualifyingMarks": TextEditingController(),
                      "obtainedMarks": TextEditingController(),
                      "grade": TextEditingController()
                    });
                  });
                },
              ),
              SizedBox(
                height: 40,
              ),

              //Principal signature
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
                        image: MarksheetMake.principalSignatureImagePath.isEmpty
                            ? Image.asset(
                                AppImages.addImage,
                                color: AppColors.greyColor.shade300,
                                scale: 12,
                              ).image
                            : Image.file(
                                File(MarksheetMake.principalSignatureImagePath),
                              ).image,
                        fit: MarksheetMake.principalSignatureImagePath.isEmpty
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
                            "Add Principal Signature",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Some college require marksheet without signature, so check before adding one.",
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
                                MarksheetMake.principalSignatureImagePath =
                                    xFile.path;
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
                                  "Upload Signature",
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

              SizedBox(
                height: 80,
              ),
              ButtonView(
                title: "Continue",
                onTap: () {
                  List<Map<String, String>> subjectList =
                      subjects.map((subject) {
                    double? qualifyingMarks =
                        double.tryParse(subject["qualifyingMarks"]!.text);
                    double? obtainedMarks =
                        double.tryParse(subject["obtainedMarks"]!.text);

                    if (obtainedMarks != null) {
                      if (obtainedMarks >= 90 && obtainedMarks <= 100) {
                        subject["grade"]?.text = "O";
                      } else if (obtainedMarks >= 80 && obtainedMarks <= 89) {
                        subject["grade"]?.text = "A";
                      } else if (obtainedMarks >= 70 && obtainedMarks <= 79) {
                        subject["grade"]?.text = "B";
                      } else if (obtainedMarks >= 60 && obtainedMarks <= 69) {
                        subject["grade"]?.text = "C";
                      } else if (obtainedMarks >= 50 && obtainedMarks <= 59) {
                        subject["grade"]?.text = "D";
                      } else if (obtainedMarks >= qualifyingMarks! &&
                          obtainedMarks <= 49) {
                        subject["grade"]?.text = "E";
                      } else {
                        subject["grade"]?.text = "F";
                      }
                    }

                    return {
                      "subjectName": subject["subjectName"]!.text,
                      "totalMarks": subject["totalMarks"]!.text,
                      "qualifyingMarks": subject["qualifyingMarks"]!.text,
                      "obtainedMarks": subject["obtainedMarks"]!.text,
                      "grade": subject["grade"]!.text
                    };
                  }).toList();

                  classObtained = "PASS";
                  for (var grade in subjectList) {
                    if (grade["grade"] == "F") {
                      classObtained = "FAIL";
                      break;
                    }
                  }

                  if (collegeName.text.isEmpty ||
                      passingYear.text.isEmpty ||
                      passingMonth.text.isEmpty ||
                      studentName.text.isEmpty ||
                      course.text.isEmpty ||
                      seatNumber.text.isEmpty) {
                    toastView(
                      msg: "Please fill all details",
                      context: context,
                    );
                  } else if (subjects.isEmpty) {
                    toastView(
                      msg: "Please add subjects",
                      context: context,
                    );
                  } else if (subjects.any((subject) =>
                      subject["subjectName"]!.text.isEmpty ||
                      subject["totalMarks"]!.text.isEmpty ||
                      subject["qualifyingMarks"]!.text.isEmpty ||
                      subject["obtainedMarks"]!.text.isEmpty ||
                      subject["grade"]!.text.isEmpty)) {
                    toastView(
                      msg: "Please fill all subject fields",
                      context: context,
                    );
                  } else {
                    MarksheetMake.generateMarksheet(
                      collegeName: collegeName.text,
                      passignYear: passingYear.text,
                      passignMonth: passingMonth.text,
                      studentName: studentName.text,
                      course: course.text,
                      seatNumber: seatNumber.text,
                      classObtained: classObtained!,
                      subjects: subjectList,
                      context: context,
                    );
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
