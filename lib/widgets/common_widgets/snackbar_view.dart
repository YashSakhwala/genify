// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:genify/config/app_style.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import '../../config/app_colors.dart';

void showSnackbar(String title, String message, String path) {
  Get.snackbar(
    title,
    "",
    messageText: Text(
      message,
      style: AppTextStyle.regularTextStyle.copyWith(
        fontSize: 12,
        color: AppColors.primaryColor,
      ),
    ),
    colorText: AppColors.primaryColor,
    backgroundColor: AppColors.whiteColor,
    icon: Icon(
      Icons.add_alert,
      size: 25,
      color: AppColors.primaryColor,
    ),
    mainButton: TextButton(
      onPressed: () async {
        final result = await OpenFile.open(path);
      },
      child: Text(
        "View",
        style: AppTextStyle.regularTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ),
    ),
    onTap: (snack) async {
      final result = await OpenFile.open(path);
    },
  );
}
