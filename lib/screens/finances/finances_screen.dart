// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'Finances_view/web_finances_view.dart';
import 'finances_view/finances_common_view.dart';

class FinancesScreen extends StatefulWidget {
  const FinancesScreen({super.key});

  @override
  State<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebFinancesScreen(),
      tabletView: FinancesCommonViewScreen(),
      mobileView: FinancesCommonViewScreen(),
    );
  }
}
