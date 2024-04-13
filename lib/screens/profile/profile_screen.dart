// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/profile/profile_view/profile_common_view.dart';
import 'package:genify/screens/profile/profile_view/web_profile_view.dart';
import 'package:genify/widgets/layout_builder_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebProfileScreen(),
      tabletView: ProfileCommonViewScreen(),
      mobileView: ProfileCommonViewScreen(),
    );
  }
}
