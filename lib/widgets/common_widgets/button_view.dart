import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';

class ButtonView extends StatelessWidget {
  final String? title;
  final double? width;
  final double? height;
  final Function() onTap;
  final BorderRadiusGeometry? borderRadius;
  final Color? containerColor;
  final TextStyle? style;
  final BoxBorder? border;
  final Widget? child;

  const ButtonView({
    super.key,
    this.title,
    this.width,
    this.height,
    required this.onTap,
    this.borderRadius,
    this.containerColor,
    this.style,
    this.border,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          border: border,
          color: containerColor ?? AppColors.primaryColor,
        ),
        child: child ??
            Center(
              child: Text(
                title ?? "",
                style: style ??
                    AppTextStyle.smallTextStyle.copyWith(
                      color: AppColors.whiteColor,
                    ),
              ),
            ),
      ),
    );
  }
}
