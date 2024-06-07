// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/home_screen_option/resume/resume_view/resume_common_view.dart';

import '../../../widgets/layout_builder_view.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: ResumeCommonViewScreen(),
      tabletView: ResumeCommonViewScreen(),
      mobileView: ResumeCommonViewScreen(),
    );
  }
}