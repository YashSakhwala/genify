// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import '../../utils/validation.dart';

class TextFieldView extends StatelessWidget {
  final double? width;
  final String title;
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController controller;
  final bool needValidator;
  final bool nameValidator;
  final bool emailValidator;
  final bool phoneNoValidator;
  final bool passwordValidator;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final bool? enabled;
  
  const TextFieldView({
    super.key,
    this.hintText,
    required this.title,
    this.width,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    required this.controller,
    this.needValidator = false,
    this.nameValidator = false,
    this.emailValidator = false,
    this.phoneNoValidator = false,
    this.passwordValidator = false,
    this.inputFormatters,
    this.decoration,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == ""
            ? Container()
            : Text(
                title,
                style: MediaQuery.of(context).size.width >= 900
                    ? AppTextStyle.regularTextStyle.copyWith(fontSize: 13)
                    : AppTextStyle.regularTextStyle,
              ),
        TextFormField(
          controller: controller,
          obscureText: obscureText!,
          enabled: enabled,
          inputFormatters: inputFormatters,
          cursorColor: AppColors.greyColor,
          keyboardType: keyboardType,
          style: enabled == false
              ? AppTextStyle.regularTextStyle.copyWith(color: AppColors.blackColor)
              : AppTextStyle.regularTextStyle,
          decoration: decoration?.copyWith(hintText: hintText) ??
              InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
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
