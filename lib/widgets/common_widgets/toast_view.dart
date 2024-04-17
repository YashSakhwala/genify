import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';

void toastMessage({required String msg, required BuildContext context}) {
  var snackBar = SnackBar(
    content: Center(
      child: Text(
        msg,
        style: AppTextStyle.regularTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
      ),
    ),
    backgroundColor: AppColors.blackColor.withOpacity(0.5),
    width: 200,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
  );
}
