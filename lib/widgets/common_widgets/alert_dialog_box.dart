// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';

void showAlertDialogBox({
  required BuildContext context,
  required Function() yesOnTap,
  required Function() noOnTap,
  required String title,
  required String subTitle,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonView(
              title: "Yes",
              onTap: yesOnTap,
              width: 70,
            ),
            SizedBox(
              width: 8,
            ),
            ButtonView(
              title: "No",
              onTap: noOnTap,
              width: 70,
            ),
          ],
        ),
      ],
      title: Text(
        title,
        style: AppTextStyle.largeTextStyle,
      ),
      content: Text(
        subTitle,
        style: AppTextStyle.regularTextStyle,
      ),
    ),
  );
}
