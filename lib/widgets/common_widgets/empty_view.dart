import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import 'package:genify/config/app_style.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.empty,
          scale: 2,
        ),
        Text(
          "No Data Found",
          style: AppTextStyle.largeTextStyle.copyWith(
            color: AppColors.greyColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
