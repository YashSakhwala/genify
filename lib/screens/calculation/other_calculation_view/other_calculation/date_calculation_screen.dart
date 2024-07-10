// ignore_for_file: unused_element, prefer_const_constructors, sized_box_for_whitespace

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_style.dart';
import '../../../../widgets/common_widgets/appbar.dart';

class DateCalculationScreen extends StatefulWidget {
  final String title;

  const DateCalculationScreen({
    super.key,
    required this.title,
  });

  @override
  State<DateCalculationScreen> createState() => _DateCalculationScreenState();
}

class _DateCalculationScreenState extends State<DateCalculationScreen> {
  // Date calculator
  DateTime selectedBirthDate = DateTime(2005, 6, 17);
  DateTime selectedCurrentDate = DateTime.now();

  String selectedBirthDateString =
      DateFormat("dd MMMM yyyy").format(DateTime(2005, 6, 17));
  String selectedCurrentDateString =
      DateFormat("dd MMMM yyyy").format(DateTime.now());

  Future<void> _selectDate(BuildContext context, bool isBirthDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isBirthDate ? selectedBirthDate : selectedCurrentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isBirthDate) {
          selectedBirthDate = picked;
          selectedBirthDateString =
              DateFormat("dd MMMM yyyy").format(selectedBirthDate);
        } else {
          selectedCurrentDate = picked;
          selectedCurrentDateString =
              DateFormat("dd MMMM yyyy").format(selectedCurrentDate);
        }
        calculateAgeDifference();
      });
    }
  }

  Map<String, int> calculateAgeDifference() {
    int years = selectedCurrentDate.year - selectedBirthDate.year;
    int months = selectedCurrentDate.month - selectedBirthDate.month;
    int days = selectedCurrentDate.day - selectedBirthDate.day;

    if (days < 0) {
      months--;
      days +=
          DateTime(selectedCurrentDate.year, selectedCurrentDate.month, 0).day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }

    return {"years": years, "months": months, "days": days};
  }

  @override
  Widget build(BuildContext context) {
    final ageDifference = calculateAgeDifference();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: widget.title,
        style: AppTextStyle.regularTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width >= 900 ? false : true,
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
      ),
      body: FlipInX(
        child: Center(
          child: Container(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date of birth",
                        style: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 18,
                          color: AppColors.greyColor.shade800,
                        ),
                      ),
                      InkWell(
                        onTap: () => _selectDate(context, true),
                        child: Row(
                          children: [
                            Text(
                              selectedBirthDateString,
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 30,
                              color: AppColors.greyColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today",
                        style: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 18,
                          color: AppColors.greyColor.shade800,
                        ),
                      ),
                      InkWell(
                        onTap: () => _selectDate(context, false),
                        child: Row(
                          children: [
                            Text(
                              selectedCurrentDateString,
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 30,
                              color: AppColors.greyColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.greyColor.shade400,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Age",
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 30,
                            color: AppColors.blackColor.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${ageDifference["years"]} ",
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontSize: 35,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              TextSpan(
                                text: "years\n",
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontSize: 20,
                                  color: AppColors.greyColor,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${ageDifference["months"]} months | ${ageDifference["days"]} days",
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontSize: 13,
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
