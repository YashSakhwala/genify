// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? style;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final bool? centerTitle;
  final IconThemeData? iconThemeData;

  const AppBarView({
    super.key,
    required this.title,
    this.style,
    required this.automaticallyImplyLeading,
    this.backgroundColor,
    this.centerTitle,
    this.iconThemeData,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor ?? AppColors.whiteColor,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: style ?? AppTextStyle.regularTextStyle,
      ),
      iconTheme: iconThemeData ?? IconThemeData(color: AppColors.blackColor),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
