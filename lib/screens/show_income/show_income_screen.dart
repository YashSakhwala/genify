// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'show_income_view/show_income_common_view.dart';
import 'show_income_view/web_show_income_view.dart';

class ShowIncomeScreen extends StatefulWidget {
  const ShowIncomeScreen({super.key});

  @override
  State<ShowIncomeScreen> createState() => _ShowIncomeScreenState();
}

class _ShowIncomeScreenState extends State<ShowIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilderView(
      webView: WebShowIncomeScreen(),
      tabletView: ShowIncomeCommonViewScreen(),
      mobileView: ShowIncomeCommonViewScreen(),
    );
  }
}