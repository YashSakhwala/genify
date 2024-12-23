// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/widgets/common_widgets/appbar.dart';

import '../../../config/app_style.dart';

class CertificateCommonViewScreen extends StatefulWidget {
  const CertificateCommonViewScreen({super.key});

  @override
  State<CertificateCommonViewScreen> createState() =>
      _CertificateCommonViewScreenState();
}

class _CertificateCommonViewScreenState
    extends State<CertificateCommonViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: "Certificate",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: EdgeInsets.all(13),
        child: Text("Certificate Screen"),
      ),
    );
  }
}
