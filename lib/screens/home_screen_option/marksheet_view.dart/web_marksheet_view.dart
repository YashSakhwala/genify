// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_to_list_in_spreads

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';
import 'marksheet_make_function.dart';

class WebMarksheetScreen extends StatefulWidget {
  const WebMarksheetScreen({super.key});

  @override
  State<WebMarksheetScreen> createState() => _WebMarksheetScreenState();
}

class _WebMarksheetScreenState extends State<WebMarksheetScreen> {
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
                          //College Logo
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.greyColor.shade300,
                              image: DecorationImage(
                                image:
                                    MarksheetMake.collegeLogoImagePath.isEmpty
                                        ? Image.asset(
                                            AppImages.addImage,
                                            color: AppColors.greyColor.shade300,
                                            scale: 12,
                                          ).image
                                        : Image.network(
                                            MarksheetMake.collegeLogoImagePath,
                                          ).image,
                                fit: MarksheetMake.collegeLogoImagePath.isEmpty
                                    ? BoxFit.scaleDown
                                    : BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Some school/college require marksheet without logo, so check before adding one.",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 25,
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
                                    MarksheetMake.collegeLogoImagePath =
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

                          //Student Image
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.greyColor.shade300,
                              image: DecorationImage(
                                image: MarksheetMake.studentImagePath.isEmpty
                                    ? Image.asset(
                                        AppImages.addImage,
                                        color: AppColors.greyColor.shade300,
                                        scale: 12,
                                      ).image
                                    : Image.network(
                                        MarksheetMake.studentImagePath,
                                      ).image,
                                fit: MarksheetMake.studentImagePath.isEmpty
                                    ? BoxFit.scaleDown
                                    : BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Some person require marksheet without image, so check before adding one.",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 25,
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
                                    MarksheetMake.studentImagePath =
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

                          //Principal Signature
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.greyColor.shade300,
                              image: DecorationImage(
                                image: MarksheetMake
                                        .principalSignatureImagePath.isEmpty
                                    ? Image.asset(
                                        AppImages.addImage,
                                        color: AppColors.greyColor.shade300,
                                        scale: 12,
                                      ).image
                                    : Image.network(
                                        MarksheetMake
                                            .principalSignatureImagePath,
                                      ).image,
                                fit: MarksheetMake
                                        .principalSignatureImagePath.isEmpty
                                    ? BoxFit.scaleDown
                                    : BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Some school/college require marksheet without signature, so check before adding one.",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 25,
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
                                    MarksheetMake.principalSignatureImagePath =
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 60,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    TextFieldView(
                                      title: "College Name",
                                      titleStyle: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: collegeName,
                                      hintText: "S.V. Patel College",
                                      isCompulsory: true,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      thickness: 1.5,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldView(
                                      title: "Student Name",
                                      titleStyle: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: studentName,
                                      hintText: "Varun Mishra",
                                      isCompulsory: true,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldView(
                                      title: "Seat Number",
                                      titleStyle: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: seatNumber,
                                      hintText: "123456",
                                      isCompulsory: true,
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
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFieldView(
                                            title: "Passsing Month",
                                            titleStyle: AppTextStyle
                                                .regularTextStyle
                                                .copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            controller: passingMonth,
                                            hintText: "April",
                                            isCompulsory: true,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: TextFieldView(
                                            title: "Passsing Year",
                                            titleStyle: AppTextStyle
                                                .regularTextStyle
                                                .copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            controller: passingYear,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            hintText: "2024",
                                            isCompulsory: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      thickness: 1.5,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFieldView(
                                      title: "Course Name",
                                      titleStyle: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: course,
                                      hintText:
                                          "Bachelor of Computer Application",
                                      isCompulsory: true,
                                    ),
                                    SizedBox(
                                      height: 60,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              // Subject List
                              ...subjects.asMap().entries.map((entry) {
                                int index = entry.key;
                                Map<String, TextEditingController> subject =
                                    entry.value;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextFieldView(
                                          title: "Subject Name",
                                          titleStyle: AppTextStyle
                                              .regularTextStyle
                                              .copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          controller: subject["subjectName"]!,
                                          hintText: "Maths",
                                          isCompulsory: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextFieldView(
                                          title: "Total Marks",
                                          titleStyle: AppTextStyle
                                              .regularTextStyle
                                              .copyWith(
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
                                          isCompulsory: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextFieldView(
                                          title: "Qualifying Marks",
                                          titleStyle: AppTextStyle
                                              .regularTextStyle
                                              .copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          controller:
                                              subject["qualifyingMarks"]!,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9\.]')),
                                          ],
                                          hintText: "33",
                                          isCompulsory: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: TextFieldView(
                                          title: "Obtained Marks",
                                          titleStyle: AppTextStyle
                                              .regularTextStyle
                                              .copyWith(
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
                                          isCompulsory: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
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
                                          .copyWith(
                                              color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                                height: 50,
                                containerColor: AppColors.backgroundColor,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                onTap: () {
                                  setState(() {
                                    subjects.add({
                                      "subjectName": TextEditingController(),
                                      "totalMarks": TextEditingController(),
                                      "qualifyingMarks":
                                          TextEditingController(),
                                      "obtainedMarks": TextEditingController(),
                                      "grade": TextEditingController()
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 400,
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
                              List<Map<String, String>> subjectList =
                                  subjects.map((subject) {
                                double? qualifyingMarks = double.tryParse(
                                    subject["qualifyingMarks"]!.text);
                                double? obtainedMarks = double.tryParse(
                                    subject["obtainedMarks"]!.text);

                                if (obtainedMarks != null) {
                                  if (obtainedMarks >= 90 &&
                                      obtainedMarks <= 100) {
                                    subject["grade"]?.text = "O";
                                  } else if (obtainedMarks >= 80 &&
                                      obtainedMarks <= 89) {
                                    subject["grade"]?.text = "A";
                                  } else if (obtainedMarks >= 70 &&
                                      obtainedMarks <= 79) {
                                    subject["grade"]?.text = "B";
                                  } else if (obtainedMarks >= 60 &&
                                      obtainedMarks <= 69) {
                                    subject["grade"]?.text = "C";
                                  } else if (obtainedMarks >= 50 &&
                                      obtainedMarks <= 59) {
                                    subject["grade"]?.text = "D";
                                  } else if (obtainedMarks >=
                                          qualifyingMarks! &&
                                      obtainedMarks <= 49) {
                                    subject["grade"]?.text = "E";
                                  } else {
                                    subject["grade"]?.text = "F";
                                  }
                                }

                                return {
                                  "subjectName": subject["subjectName"]!.text,
                                  "totalMarks": subject["totalMarks"]!.text,
                                  "qualifyingMarks":
                                      subject["qualifyingMarks"]!.text,
                                  "obtainedMarks":
                                      subject["obtainedMarks"]!.text,
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
