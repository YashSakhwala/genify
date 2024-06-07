// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'add_income_view/add_income_common_view.dart';
import 'add_income_view/web_add_income_view.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebAddIncomeScreen(),
      tabletView: AddIncomeCommonViewScreen(),
      mobileView: AddIncomeCommonViewScreen(),
    );
  }
}