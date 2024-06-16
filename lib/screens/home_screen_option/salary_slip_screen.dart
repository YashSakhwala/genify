// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/home_screen_option/salary_slip_view/salary_slip_common_view.dart';
import '../../widgets/layout_builder_view.dart';

class SalarySlipScreen extends StatefulWidget {
  const SalarySlipScreen({super.key});

  @override
  State<SalarySlipScreen> createState() => _SalarySlipScreenState();
}

class _SalarySlipScreenState extends State<SalarySlipScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: SalarySlipCommonViewScreen(),
      tabletView: SalarySlipCommonViewScreen(),
      mobileView: SalarySlipCommonViewScreen(),
    );
  }
}
