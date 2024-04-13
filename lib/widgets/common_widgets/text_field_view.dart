// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';

class TextFieldView extends StatelessWidget {
  final double? width;
  final String title;
  final TextInputType? keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController textEditingController;
  const TextFieldView({
    super.key,
    required this.hintText,
    required this.title,
    this.width,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: MediaQuery.of(context).size.width >= 900
              ? AppTextStyle.regularTextStyle.copyWith(fontSize: 13)
              : AppTextStyle.regularTextStyle,
        ),
        TextField(
          controller: textEditingController,
          obscureText: obscureText!,
          cursorColor: AppColors.greyColor,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 8,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyColor),
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.greyColor),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
