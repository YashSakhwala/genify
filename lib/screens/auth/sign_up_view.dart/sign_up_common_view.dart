// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/controller/auth_controller.dart';
import 'package:genify/screens/auth/login_screen.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_image.dart';
import '../../../widgets/common_widgets/text_field_view.dart';

class SignUpCommomView extends StatefulWidget {
  const SignUpCommomView({super.key});

  @override
  State<SignUpCommomView> createState() => _SignUpCommomViewState();
}

class _SignUpCommomViewState extends State<SignUpCommomView> {
  AuthController authController = Get.put(AuthController());

  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Create an account",
              style: AppTextStyle.largeTextStyle,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () async {
              ImagePicker imagePicker = ImagePicker();

              XFile? xFile =
                  await imagePicker.pickImage(source: ImageSource.gallery);

              if (xFile != null && xFile.path.isNotEmpty) {
                authController.imagePath.value = xFile.path;
              }
            },
            child: Stack(
              children: [
                Obx(
                  () => Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.shade300,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: authController.imagePath.value.isEmpty
                            ? Image.asset(
                                AppImages.addImage,
                                color: AppColors.greyColor,
                                scale: 11,
                              ).image
                            : kIsWeb
                                ? Image.network(
                                    authController.imagePath.value,
                                  ).image
                                : Image.file(
                                    File(authController.imagePath.value),
                                  ).image,
                        fit: authController.imagePath.value.isEmpty
                            ? BoxFit.scaleDown
                            : BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 5,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldView(
            title: "Email",
            hintText: "example@gmail.com",
            textEditingController: email,
            needValidator: true,
            emailValidator: true,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldView(
            title: "Phone number",
            hintText: "1234567890",
            keyboardType: TextInputType.phone,
            textEditingController: phoneNo,
            needValidator: true,
            phoneNoValidator: true,
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => TextFieldView(
              title: "Password",
              hintText: "******",
              textEditingController: password,
              obscureText: authController.isSignUpPasswordShow.value,
              needValidator: true,
              passwordValidator: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  authController.isSignUpPasswordShow.value =
                      !authController.isSignUpPasswordShow.value;
                },
                child: Image.asset(
                  authController.isSignUpPasswordShow.value
                      ? AppImages.openEye
                      : AppImages.closeEye,
                  color: AppColors.greyColor,
                  scale: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => TextFieldView(
              title: "Confirm password",
              hintText: "******",
              textEditingController: confirmPassword,
              obscureText: authController.isConfirmPasswordShow.value,
              needValidator: true,
              passwordValidator: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  authController.isConfirmPasswordShow.value =
                      !authController.isConfirmPasswordShow.value;
                },
                child: Image.asset(
                  authController.isConfirmPasswordShow.value == true
                      ? AppImages.openEye
                      : AppImages.closeEye,
                  color: AppColors.greyColor,
                  scale: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 55,
          ),
          ButtonView(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                if (password.text != confirmPassword.text) {
                  toastMessage(
                      msg: "Both passwords are not same", context: context);
                } else if (authController.imagePath.value.isEmpty) {
                  toastMessage(
                      msg: "Please select profile image", context: context);
                } else {
                  authController.signUp(
                    email: email.text,
                    phoneNo: phoneNo.text,
                    password: password.text,
                    context: context,
                  );
                }
              }
            },
            title: "Sign Up",
          ),
          SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Do you have an account? ',
                  style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                ),
                TextSpan(
                    text: 'Log In',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
