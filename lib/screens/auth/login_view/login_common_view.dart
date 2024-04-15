// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/controller/auth_controller.dart';
import 'package:genify/screens/auth/sign_up_screen.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import 'package:get/get.dart';
import '../../../config/app_image.dart';
import '../../../widgets/common_widgets/text_field_view.dart';

class LoginCommonView extends StatefulWidget {
  const LoginCommonView({super.key});

  @override
  State<LoginCommonView> createState() => _LoginCommonViewState();
}

class _LoginCommonViewState extends State<LoginCommonView> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Welocme Back!",
            style: AppTextStyle.largeTextStyle,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        TextFieldView(
          title: "Email",
          hintText: "example@gmail.com",
          textEditingController: email,
        ),
        SizedBox(
          height: 30,
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
          height: 8,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            "Forget password?",
            style: AppTextStyle.largeTextStyle.copyWith(
              fontSize: 13,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        ButtonView(
          onTap: () {
            if (email.text.isEmpty && password.text.isEmpty) {
              toastMessage(msg: "Enter email and password");
            } else {
              authController.isSignUpScreen.value = false;
              authController.logIn(
                email: email.text,
                password: password.text,
                context: context,
              );
            }
          },
          title: "Login",
        ),
        SizedBox(
          height: 12,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Doesn\'t have an account? ',
                style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
              ),
              TextSpan(
                  text: 'Sign Up',
                  style: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
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
