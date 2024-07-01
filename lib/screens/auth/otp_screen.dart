// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/auth/otp_view/otp_common_view.dart';
import 'package:genify/screens/auth/otp_view/web_otp_view.dart';
import '../../widgets/layout_builder_view.dart';

class OTPScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNo;
  final String password;
  final String verificationId;

  const OTPScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebOTPScreen(
        name: name,
        email: email,
        password: password,
        phoneNo: phoneNo,
        verificationId: verificationId,
      ),
      tabletView: OTPCommonView(
        name: name,
        email: email,
        password: password,
        phoneNo: phoneNo,
        verificationId: verificationId,
      ),
      mobileView: OTPCommonView(
        name: name,
        email: email,
        password: password,
        phoneNo: phoneNo,
        verificationId: verificationId,
      ),
    );
  }
}
