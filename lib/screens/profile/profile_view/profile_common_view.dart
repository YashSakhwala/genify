// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/controller/auth_controller.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import 'package:genify/widgets/common_widgets/indicatior.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../widgets/common_widgets/text_field_view.dart';

class ProfileCommonViewScreen extends StatefulWidget {
  const ProfileCommonViewScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCommonViewScreen> createState() =>
      _ProfileCommonViewScreenState();
}

class _ProfileCommonViewScreenState extends State<ProfileCommonViewScreen> {
  AuthController authController = Get.put(AuthController());

  final TextEditingController name = TextEditingController();
  final TextEditingController birthDate = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();

  @override
  void initState() {
    name.text = authController.userData["name"];
    birthDate.text = authController.userData["birthDate"];
    country.text = authController.userData["country"];
    email.text = authController.userData["email"];
    phoneNo.text = authController.userData["phoneNo"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(13),
          child: ListView(
            children: [
              Row(
                children: [
                  Text(
                    "Profile Info",
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  ButtonView(
                    width: 130,
                    title: "Save changes",
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      authController.updateProfile(
                        name: name.text,
                        email: email.text,
                        phoneNo: phoneNo.text,
                        birthDate: birthDate.text,
                        country: country.text,
                        context: context,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () async {
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(email.text)) {
                    showIndicator(context);

                    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                    await firebaseAuth.sendPasswordResetEmail(
                        email: email.text);

                    Navigator.of(context).pop();

                    toastView(
                      msg: "Check your email to reset password",
                      context: context,
                    );
                  } else {
                    toastView(
                      msg: "Please enter valid email",
                      context: context,
                    );
                  }
                },
                child: Row(
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
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 2,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: authController.imagePath.value.isNotEmpty
                                ? Image.file(
                                    File(authController.imagePath.value),
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    authController.userData["image"],
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
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
                      InkWell(
                        onTap: () async {
                          ImagePicker imagePicker = ImagePicker();

                          XFile? xFile = await imagePicker.pickImage(
                              source: ImageSource.gallery);

                          authController.imagePath.value = xFile!.path;
                        },
                        child: Container(
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
                      ),
                      Divider(),
                      Text(
                        "Full name",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          fontSize: 13,
                          color: AppColors.greyColor,
                        ),
                      ),
                      TextFieldView(
                        controller: name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        title: "",
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
                      Text(
                        "Email address",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          fontSize: 13,
                          color: AppColors.greyColor,
                        ),
                      ),
                      TextFieldView(
                        controller: email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        enabled: false,
                        title: "",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Phone number",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          fontSize: 13,
                          color: AppColors.greyColor,
                        ),
                      ),
                      TextFieldView(
                        controller: phoneNo,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        title: "",
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
                      Text(
                        "Date of birth",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          fontSize: 13,
                          color: AppColors.greyColor,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2040),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                      primary: AppColors.primaryColor),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (dateTime != null) {
                            setState(() {
                              birthDate.text =
                                  dateTime.toString().split(' ').first;
                            });
                          }
                        },
                        child: TextFieldView(
                          controller: birthDate,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          hintText: "YYYY-MM-DD",
                          enabled: false,
                          title: "",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Country or region",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          fontSize: 13,
                          color: AppColors.greyColor,
                        ),
                      ),
                      TextFieldView(
                        controller: country,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        title: "",
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
      ),
    );
  }
}
