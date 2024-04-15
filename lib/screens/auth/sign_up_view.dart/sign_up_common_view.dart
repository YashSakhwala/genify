// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/controller/auth_controller.dart';
import 'package:genify/screens/auth/login_screen.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Stack(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: AppColors.greyColor.shade300,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                AppImages.addImage,
                scale: 11,
                color: AppColors.greyColor,
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
        SizedBox(
          height: 10,
        ),
        TextFieldView(
          title: "Email",
          hintText: "example@gmail.com",
          textEditingController: email,
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldView(
          title: "Phone number",
          hintText: "1234567890",
          keyboardType: TextInputType.phone,
          textEditingController: phoneNo,
          textInputFormatter: [LengthLimitingTextInputFormatter(10)],
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => TextFieldView(
            title: "Password",
            hintText: "******",
            textEditingController: password,
            obscureText: authController.isPasswordShow.value,
            suffixIcon: GestureDetector(
              onTap: () {
                authController.isPasswordShow.value =
                    !authController.isPasswordShow.value;
              },
              child: Image.asset(
                authController.isPasswordShow.value
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
            if (email.text.isEmpty ||
                phoneNo.text.isEmpty ||
                password.text.isEmpty ||
                confirmPassword.text.isEmpty) {
              toastMessage(msg: "Fill the information");
            } else if (password.text != confirmPassword.text) {
              toastMessage(msg: "Both passwords are not same");
            } else {
              authController.isSignUpScreen.value = true;
              authController.logIn(
                email: email.text,
                password: password.text,
                context: context,
              );
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
    );
  }
}
