// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'other_calculator_view/other_calculator_common_screen.dart';

class OtherCalculatorScreen extends StatefulWidget {
  const OtherCalculatorScreen({super.key});

  @override
  State<OtherCalculatorScreen> createState() => _OtherCalculatorScreenState();
}

class _OtherCalculatorScreenState extends State<OtherCalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: OtherCalculatorCommonViewScreen(),
      tabletView: OtherCalculatorCommonViewScreen(),
      mobileView: OtherCalculatorCommonViewScreen(),
    );
  }
}
