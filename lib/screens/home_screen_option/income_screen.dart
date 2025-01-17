// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/widgets/layout_builder_view.dart';
import 'income_view/income_common_view.dart';
import 'income_view/web_income_view.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      mobileView: IncomeCommonViewScreen(),
      tabletView: IncomeCommonViewScreen(),
      webView: WebIncomeView(),
    );
  }
}
