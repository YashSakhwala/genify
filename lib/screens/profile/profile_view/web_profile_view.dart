// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/config/app_style.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;
import '../../../controller/auth_controller.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/indicatior.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';

class WebProfileScreen extends StatefulWidget {
  const WebProfileScreen({Key? key}) : super(key: key);

  @override
  State<WebProfileScreen> createState() => _WebProfileScreenState();
}

class _WebProfileScreenState extends State<WebProfileScreen> {
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Profile Info",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonView(
                      width: 150,
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
                      margin: EdgeInsets.symmetric(horizontal: 16),
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
                margin: EdgeInsets.symmetric(horizontal: 16),
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
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    ? kIsWeb
                                        ? Image.network(
                                            authController.imagePath.value,
                                            height: 160,
                                            width: 160,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            File(
                                                authController.imagePath.value),
                                            height: 160,
                                            width: 160,
                                            fit: BoxFit.cover,
                                          )
                                    : Image.network(
                                        authController.userData["image"],
                                        height: 160,
                                        width: 160,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Personalize your account with a photo. Your \nprofile photo will appear on apps and devices \nthat use your Genify account.",
                                style: AppTextStyle.smallTextStyle.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackColor.withOpacity(0.7),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (kIsWeb) {
                                    html.FileUploadInputElement uploadInput =
                                        html.FileUploadInputElement();
                                    uploadInput.accept = 'image/*';
                                    uploadInput.click();

                                    uploadInput.onChange.listen((event) {
                                      final file = uploadInput.files!.first;
                                      final reader = html.FileReader();

                                      reader.readAsDataUrl(file);
                                      reader.onLoadEnd.listen((event) {
                                        authController.webImageFile.value =
                                            file;
                                        authController.imagePath.value =
                                            reader.result as String;
                                      });
                                    });
                                  } else {
                                    ImagePicker imagePicker = ImagePicker();

                                    XFile? xFile = await imagePicker.pickImage(
                                        source: ImageSource.gallery);

                                    if (xFile != null &&
                                        xFile.path.isNotEmpty) {
                                      authController.imagePath.value =
                                          xFile.path;
                                    }
                                  }
                                },
                                child: Container(
                                  height: 37,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: AppColors.greyColor),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Change Photo",
                                      style: AppTextStyle.smallTextStyle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.15,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 0.4,
                        color: AppColors.greyColor,
                      ),
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            title: "",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.16,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 0.4,
                        color: AppColors.greyColor,
                      ),
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            title: "",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
