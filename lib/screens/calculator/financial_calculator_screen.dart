// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'financial_calculator_view/financial_calculator_common_screen.dart';

class FinancialCalculatorScreen extends StatefulWidget {
  const FinancialCalculatorScreen({super.key});

  @override
  State<FinancialCalculatorScreen> createState() =>
      _FinancialCalculatorScreenState();
}

class _FinancialCalculatorScreenState extends State<FinancialCalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: FinancialCalculatorCommonViewScreen(),
      tabletView: FinancialCalculatorCommonViewScreen(),
      mobileView: FinancialCalculatorCommonViewScreen(),
    );
  }
}
