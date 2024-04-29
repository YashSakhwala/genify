// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import '../../utils/validation.dart';

class TextFieldView extends StatelessWidget {
  final double? width;
  final String title;
  final TextInputType? keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController textEditingController;
  final bool needValidator;
  final bool emailValidator;
  final bool phoneNoValidator;
  final bool passwordValidator;

  const TextFieldView({
    super.key,
    required this.hintText,
    required this.title,
    this.width,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    required this.textEditingController,
    this.needValidator = false,
    this.emailValidator = false,
    this.phoneNoValidator = false,
    this.passwordValidator = false,
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
        TextFormField(
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
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.redColor),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.redColor),
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.greyColor),
            suffixIcon: suffixIcon,
          ),
          validator: needValidator
              ? (value) => TextFieldValidation.validation(
                    isEmailValidator: emailValidator,
                    isPasswordValidator: passwordValidator,
                    isPhoneNumberValidator: phoneNoValidator,
                    message: title,
                    value: value,
                  )
              : null,
        )
      ],
    );
  }
}
