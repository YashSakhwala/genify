// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'calculator_view/calculator_common_view.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: CalculatorCommonViewScreen(),
      tabletView: CalculatorCommonViewScreen(),
      mobileView: CalculatorCommonViewScreen(),
    );
  }
}