// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/button_view.dart';
import 'package:pinput/pinput.dart';

class OTPCommonView extends StatefulWidget {
  const OTPCommonView({super.key});

  @override
  State<OTPCommonView> createState() => _OTPCommonViewState();
}

class _OTPCommonViewState extends State<OTPCommonView> {
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? null
          : AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "Verification",
                style: AppTextStyle.largeTextStyle.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              backgroundColor: AppColors.primaryColor,
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
              onTap: () {
                // var inputOTP = pinPutController.text;

                // var temp = await widget.myAuth.verifyOTP(
                //   otp: inputOTP,
                // );

                // if (temp == true) {
                //   authController.signUp(
                //     name: widget.name,
                //     email: widget.email,
                //     password: widget.password,
                //     phoneNo: widget.phoneNo,
                //     context: context,
                //   );
                // } else {
                //   toastView(msg: "Please enter valid OTP", context: context,);
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
