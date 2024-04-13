// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/screens/auth/sign_up_screen.dart';
import 'package:genify/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';

class LoginCommonView extends StatelessWidget {
  const LoginCommonView({super.key});

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
        ),
        SizedBox(
          height: 30,
        ),
        TextFieldView(
          title: "Password",
          hintText: "******",
          suffixIcon: Icon(Icons.remove_red_eye_outlined),
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
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomBarScreen()),
              (route) => false,
            );
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
