// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/widgets/common_widgets/text_field_view.dart';

import '../../../../config/app_colors.dart';

class ResumeInformationViewScreen extends StatefulWidget {
  const ResumeInformationViewScreen({super.key});

  @override
  State<ResumeInformationViewScreen> createState() =>
      _ResumeInformationViewScreenState();
}

class _ResumeInformationViewScreenState
    extends State<ResumeInformationViewScreen> {
  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColors.greyColor.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 5,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
            TextFieldView(
              title: "Enter name",
              controller: name,
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Enter occupation",
              controller: name,
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Enter occupation",
              controller: name,
            ),
          ],
        ),
      ),
    );
  }
}
