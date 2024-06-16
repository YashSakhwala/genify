// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/appbar.dart';

class SalarySlipCommonViewScreen extends StatefulWidget {
  const SalarySlipCommonViewScreen({super.key});

  @override
  State<SalarySlipCommonViewScreen> createState() =>
      _SalarySlipCommonViewScreenState();
}

class _SalarySlipCommonViewScreenState
    extends State<SalarySlipCommonViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: "Salary slip",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView(
          children: [
            Text("Salary slip"),
          ],
        ),
      ),
    );
  }
}
