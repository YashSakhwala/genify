// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/auth/login_view/mobile_login_view.dart';
import 'package:genify/screens/auth/login_view/tablet_login_view.dart';
import 'package:genify/screens/auth/login_view/web_login_view.dart';
import '../../widgets/layout_builder_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebLoginViewScreen(),
      tabletView: TabletLoginViewScreen(),
      mobileView: MobileLoginViewScreen(),
    );
  }
}
