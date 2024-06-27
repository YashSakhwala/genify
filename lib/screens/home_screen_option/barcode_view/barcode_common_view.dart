// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/appbar.dart';

class BarcodeCommonViewScreen extends StatefulWidget {
  const BarcodeCommonViewScreen({super.key});

  @override
  State<BarcodeCommonViewScreen> createState() =>
      _BarcodeCommonViewScreenState();
}

class _BarcodeCommonViewScreenState extends State<BarcodeCommonViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: "Barcode",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
