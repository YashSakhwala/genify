// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/controller/auth_controller.dart';
import 'package:genify/screens/auth/sign_up_screen.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import 'package:get/get.dart';
import '../../../config/app_image.dart';
import '../../../widgets/common_widgets/indicatior.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';

class LoginCommonView extends StatefulWidget {
  const LoginCommonView({super.key});

  @override
  State<LoginCommonView> createState() => _LoginCommonViewState();
}

class _LoginCommonViewState extends State<LoginCommonView> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: FlipInX(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Welcome Back!",
                style: AppTextStyle.largeTextStyle,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextFieldView(
              title: "Email",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              hintText: "example@gmail.com",
              controller: email,
              needValidator: true,
              emailValidator: true,
            ),
            SizedBox(
              height: 30,
            ),
            Obx(
              () => TextFieldView(
                title: "Password",
                titleStyle: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "******",
                controller: password,
                obscureText: authController.isLoginPasswordShow.value,
                needValidator: true,
                passwordValidator: true,
                suffixIcon: GestureDetector(
                  onTap: () {
                    authController.isLoginPasswordShow.value =
                        !authController.isLoginPasswordShow.value;
                  },
                  child: Image.asset(
                    authController.isLoginPasswordShow.value
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
            GestureDetector(
              onTap: () async {
                if (RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email.text)) {
                  showIndicator(context);

                  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                  await firebaseAuth.sendPasswordResetEmail(email: email.text);

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
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Forgot Password?",
                  style: AppTextStyle.largeTextStyle.copyWith(
                    fontSize: 13,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ButtonView(
              onTap: () {
                if (_formkey.currentState!.validate()) {
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
              height: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                  ),
                  TextSpan(
                      text: 'Sign Up',
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
