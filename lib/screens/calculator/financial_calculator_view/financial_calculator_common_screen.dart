// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../calculation/financial_calculation_view/financial_calculation_common_view.dart';

class FinancialCalculatorCommonViewScreen extends StatefulWidget {
  const FinancialCalculatorCommonViewScreen({super.key});

  @override
  State<FinancialCalculatorCommonViewScreen> createState() =>
      _FinancialCalculatorCommonViewScreenState();
}

class _FinancialCalculatorCommonViewScreenState
    extends State<FinancialCalculatorCommonViewScreen> {
  List option = [
    {"image": AppImages.gst, "name": "GST"},
    {"image": AppImages.investment, "name": "Investment"},
    {"image": AppImages.loan, "name": "Loan"},
    {"image": AppImages.dividend, "name": "Dividend"},
    {"image": AppImages.gain, "name": "Capital Gain"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent:
                  MediaQuery.of(context).size.width >= 900 ? 150 : null,
            ),
            itemCount: option.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        FinancialCalculationCommonViewScreen(index: index + 1),
                  ));
                },
                child: FlipInX(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: MediaQuery.of(context).size.width >= 900
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image:
                                    Image.asset(option[index]["image"]).image,
                                height: 35,
                                color: AppColors.primaryColor,
                              ),
                              Text(
                                option[index]["name"],
                                textAlign: TextAlign.center,
                                style: AppTextStyle.smallTextStyle.copyWith(
                                  color: AppColors.greyColor.shade600,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image:
                                    Image.asset(option[index]["image"]).image,
                                height: 30,
                                color: AppColors.primaryColor,
                              ),
                              Text(
                                option[index]["name"],
                                textAlign: TextAlign.center,
                                style: AppTextStyle.smallTextStyle.copyWith(
                                    color: AppColors.greyColor.shade600),
                              ),
                            ],
                          ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
