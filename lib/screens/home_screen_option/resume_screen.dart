// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'resume_view/resume_common_view.dart';
import 'resume_view/web_resume_view.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({super.key});

  @override
  State<ResumeScreen> createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebResumeScreen(),
      tabletView: ResumeCommonViewScreen(),
      mobileView: ResumeCommonViewScreen(),
    );
  }
}