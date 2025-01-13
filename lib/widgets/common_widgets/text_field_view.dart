// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import '../../utils/validation.dart';

class TextFieldView extends StatelessWidget {
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
  final bool addressValidator;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final bool? enabled;
  final TextAlign? textAlign;
  final TextStyle? style;
  final Function(String)? onChanged;
  final String? labelText;
  final double? vertical;
  final double? cursorHeight;
  final int? maxLines;
  final TextStyle? titleStyle;
  final Widget? anyWidget;
  final List<String>? dropdownItems;
  final bool? isDropDownItem;
  final bool? readOnly;
  final bool? autofocus;
  final VoidCallback? onTap;

  const TextFieldView({
    super.key,
    this.hintText,
    required this.title,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    required this.controller,
    this.needValidator = false,
    this.nameValidator = false,
    this.emailValidator = false,
    this.phoneNoValidator = false,
    this.passwordValidator = false,
    this.addressValidator = false,
    this.inputFormatters,
    this.decoration,
    this.enabled,
    this.textAlign,
    this.style,
    this.onChanged,
    this.labelText,
    this.vertical,
    this.cursorHeight,
    this.maxLines,
    this.titleStyle,
    this.anyWidget,
    this.isDropDownItem = false,
    this.dropdownItems = const [
      'Software Engineer',
      'Doctor',
      'Teacher',
      'Artist',
      'Designer',
      'Business Owner',
      'Developer',
      'Writer',
      'Architect',
      'Accountant',
      'Engineer',
      'Scientist',
      'Nurse',
      'Lawyer',
      'Chef',
      'Photographer',
      'Musician',
      'Psychologist',
      'Marketing Specialist',
      'Project Manager',
      'Data Analyst',
      'Researcher',
      'HR Specialist',
      'Sales Executive',
      'Social Worker',
      'Consultant',
      'Entrepreneur',
      'Mechanic',
      'Electrician',
      'Plumber',
      'Pharmacist',
      'Veterinarian',
      'Pilot',
      'Firefighter',
      'Police Officer',
      'Graphic Designer',
      'Application Developer',
      'Web Developer',
      'SEO Specialist',
      'UI/UX Designer',
      'Financial Analyst',
      'Writer/Journalist',
      'Event Planner',
      'Interpreter/Translator',
      'Farmer',
      'Fitness Trainer',
      'Public Relations Specialist',
      'Content Creator',
      'Digital Marketer',
    ],
    this.readOnly,
    this.onTap,
    this.autofocus,
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
                    ? titleStyle ??
                        AppTextStyle.regularTextStyle.copyWith(fontSize: 13)
                    : titleStyle ?? AppTextStyle.regularTextStyle,
              ),
        SizedBox(
          child: anyWidget,
        ),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          autofocus: autofocus ?? false,
          maxLines: maxLines ?? 1,
          readOnly: readOnly ?? false,
          obscureText: obscureText!,
          enabled: enabled,
          inputFormatters: inputFormatters,
          cursorHeight: cursorHeight,
          cursorColor: AppColors.greyColor,
          keyboardType: keyboardType,
          style: enabled == false
              ? AppTextStyle.regularTextStyle
                  .copyWith(color: AppColors.blackColor)
              : style ?? AppTextStyle.regularTextStyle,
          textAlign: textAlign ?? TextAlign.justify,
          decoration: decoration?.copyWith(hintText: hintText) ??
              InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: vertical ?? 0,
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
                suffixIcon: isDropDownItem == true
                    ? PopupMenuButton<String>(
                        color: AppColors.greyColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                        onSelected: (value) {
                          controller.text = value;
                        },
                        itemBuilder: (context) {
                          return dropdownItems!
                              .map((item) => PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style:
                                          AppTextStyle.smallTextStyle.copyWith(
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ))
                              .toList();
                        },
                      )
                    : suffixIcon,
                labelText: labelText,
                labelStyle: TextStyle(color: AppColors.greyColor),
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
        ),
      ],
    );
  }
}
