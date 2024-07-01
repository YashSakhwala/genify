// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import '../../config/app_colors.dart';

void showSnackbar(String title, String message, String path) {
  Get.snackbar(
    title,
    message,
    colorText: AppColors.primaryColor,
    backgroundColor: AppColors.whiteColor,
    icon: Icon(
      Icons.add_alert,
      size: 25,
      color: AppColors.primaryColor,
    ),
    onTap: (snack) async {
      log('---------------$path');
      try {
        final result = await OpenFile.open(path);
      } catch (e) {
        log('---------------${e.toString()}');
      }
    },
  );
}
