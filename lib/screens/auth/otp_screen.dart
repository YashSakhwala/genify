// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/auth/otp_view/otp_common_view.dart';
import 'package:genify/screens/auth/otp_view/web_otp_view.dart';
import '../../widgets/layout_builder_view.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebOTPScreen(),
      tabletView: OTPCommonView(),
      mobileView: OTPCommonView(),
    );
  }
}