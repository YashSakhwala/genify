// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/controller/auth_controller.dart';
import 'package:genify/screens/auth/login_screen.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import 'package:get/get.dart';
import '../../../widgets/common_widgets/text_field_view.dart';

class SignUpCommomView extends StatefulWidget {
  const SignUpCommomView({super.key});

  @override
  State<SignUpCommomView> createState() => _SignUpCommomViewState();
}

class _SignUpCommomViewState extends State<SignUpCommomView> {
  AuthController authController = Get.put(AuthController());

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
              child: Icon(
                Icons.add_a_photo_outlined,
                size: 40,
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
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldView(
          title: "Phone number",
          hintText: "1234567890",
          keyboardType: TextInputType.phone,
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldView(
          title: "Password",
          hintText: "******",
          suffixIcon: Icon(Icons.remove_red_eye_outlined),
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldView(
          title: "Confirm password",
          hintText: "******",
          suffixIcon: Icon(Icons.remove_red_eye_outlined),
        ),
        SizedBox(
          height: 55,
        ),
        ButtonView(
          onTap: () {
            // Navigator.of(context).pushAndRemoveUntil(
            //   MaterialPageRoute(builder: (context) => BottomBarScreen()),
            //   (route) => false,
            // );

            authController.signUp(
                email: "yash@gmail.com", password: "password");
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
