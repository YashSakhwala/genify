// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'sign_up_view.dart/mobile_sign_up_view.dart';
import 'sign_up_view.dart/tablet_sign_up_view.dart';
import 'sign_up_view.dart/web_sign_up_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebSignUpViewScreen(),
      tabletView: TabletSignUpViewScreen(),
      mobileView: MobileSignUpViewScreen(),
    );
  }
}
