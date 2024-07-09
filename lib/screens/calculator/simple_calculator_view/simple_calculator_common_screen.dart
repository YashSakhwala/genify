// ignore_for_file: sized_box_for_whitespace

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_style.dart';

class SimpleCalculatorCommonViewScreen extends StatefulWidget {
  const SimpleCalculatorCommonViewScreen({Key? key}) : super(key: key);

  @override
  State<SimpleCalculatorCommonViewScreen> createState() =>
      _SimpleCalculatorCommonViewScreenState();
}

class _SimpleCalculatorCommonViewScreenState
    extends State<SimpleCalculatorCommonViewScreen> {
  double currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: FlipInX(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: SimpleCalculator(
              theme: CalculatorThemeData(
                expressionStyle:
                    AppTextStyle.regularTextStyle.copyWith(fontSize: 17),
                commandColor: AppColors.transparentColor,
                commandStyle:
                    AppTextStyle.regularTextStyle.copyWith(fontSize: 25),
                numColor: AppColors.transparentColor,
                numStyle: AppTextStyle.regularTextStyle.copyWith(fontSize: 25),
                operatorColor: AppColors.transparentColor,
                operatorStyle:
                    AppTextStyle.regularTextStyle.copyWith(fontSize: 25),
                borderColor: AppColors.transparentColor,
              ),
              value: currentValue,
              hideExpression: false,
              hideSurroundingBorder: true,
              autofocus: true,
              onChanged: (key, value, expression) {
                currentValue = value ?? 0;
              },
              onTappedDisplay: (value, details) {},
            ),
          ),
        ),
      ),
    );
  }
}
