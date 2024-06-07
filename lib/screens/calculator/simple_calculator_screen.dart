// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'simple_calculator_view/simple_calculator_common_screen.dart';

class SimpleCalculatorScreen extends StatefulWidget {
  const SimpleCalculatorScreen({super.key});

  @override
  State<SimpleCalculatorScreen> createState() => _SimpleCalculatorScreenState();
}

class _SimpleCalculatorScreenState extends State<SimpleCalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: SimpleCalculatorCommonViewScreen(),
      tabletView: SimpleCalculatorCommonViewScreen(),
      mobileView: SimpleCalculatorCommonViewScreen(),
    );
  }
}
