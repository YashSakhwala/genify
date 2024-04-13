import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';

PreferredSizeWidget appBarView({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: AppTextStyle.largeTextStyle.copyWith(
        color: AppColors.whiteColor,
      ),
    ),
    backgroundColor: AppColors.primaryColor,
  );
}
