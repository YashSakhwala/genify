// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:email_otp/email_otp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_style.dart';
import '../../../controller/auth_controller.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../../widgets/common_widgets/button_view.dart';
import 'package:pinput/pinput.dart';
import '../../../widgets/common_widgets/toast_view.dart';

class OTPCommonView extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNo;
  final String password;
  final EmailOTP myAuth;

  const OTPCommonView({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.myAuth,
  });

  @override
  State<OTPCommonView> createState() => _OTPCommonViewState();
}

class _OTPCommonViewState extends State<OTPCommonView> {
  AuthController authController = Get.put(AuthController());

  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? null
          : AppBarView(
              title: "Genify",
              style: AppTextStyle.largeTextStyle.copyWith(
                color: AppColors.whiteColor,
              ),
              backgroundColor: AppColors.primaryColor,
              automaticallyImplyLeading: true,
            ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Please enter the 6-digit OTP sent to your registered email address",
                style: AppTextStyle.regularTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Pinput(
                controller: pinPutController,
                focusNode: pinPutFocusNode,
                length: 6,
                autofocus: true,
                closeKeyboardWhenCompleted: true,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ButtonView(
              height: 50,
              title: "Continue",
              onTap: () async {
                var inputOTP = pinPutController.text;

                var temp = await widget.myAuth.verifyOTP(
                  otp: inputOTP,
                );

                if (temp == true) {
                  authController.signUp(
                    name: widget.name,
                    email: widget.email,
                    password: widget.password,
                    phoneNo: widget.phoneNo,
                    context: context,
                  );
                } else {
                  toastView(
                    msg: "Please enter valid OTP",
                    context: context,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
