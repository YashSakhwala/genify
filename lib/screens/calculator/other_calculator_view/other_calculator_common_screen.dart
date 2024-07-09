// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genify/screens/calculation/other_calculation_view/other_calculation/bmi_calculation_screen.dart';
import 'package:genify/screens/calculation/other_calculation_view/other_calculation/date_calculation_screen.dart';
import 'package:genify/screens/calculation/other_calculation_view/other_calculation/discount_calculation_screen.dart';
import 'package:genify/screens/calculation/other_calculation_view/other_calculation/numeral_calculation_screen.dart';
import 'package:genify/screens/calculation/other_calculation_view/other_calculation/temperature_calculation_screen.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../calculation/other_calculation_view/other_calculation_common_view.dart';

class OtherCalculatorCommonViewScreen extends StatefulWidget {
  const OtherCalculatorCommonViewScreen({super.key});

  @override
  State<OtherCalculatorCommonViewScreen> createState() =>
      _OtherCalculatorCommonViewScreenState();
}

class _OtherCalculatorCommonViewScreenState
    extends State<OtherCalculatorCommonViewScreen> {
  List option = [
    {"image": AppImages.age, "name": "Age"},
    {"image": AppImages.area, "name": "Area"},
    {"image": AppImages.bmi, "name": "BMI"},
    {"image": AppImages.data, "name": "Data"},
    {"image": AppImages.date, "name": "Date"},
    {"image": AppImages.discount, "name": "Discount"},
    {"image": AppImages.length, "name": "Length"},
    {"image": AppImages.mass, "name": "Mass"},
    {"image": AppImages.numeral, "name": "Numeral System"},
    {"image": AppImages.speed, "name": "Speed"},
    {"image": AppImages.temperature, "name": "Temperature"},
    {"image": AppImages.time, "name": "Time"},
    {"image": AppImages.volume, "name": "Volume"},
    {"image": AppImages.pressure, "name": "Pressure"},
    {"image": AppImages.force, "name": "Force"},
    {"image": AppImages.density, "name": "Density"},
    {"image": AppImages.power, "name": "Power"},
    {"image": AppImages.number, "name": "Number"},
    {"image": AppImages.frequency, "name": "Frequency"},
    {"image": AppImages.radiation, "name": "Radiation"},
    {"image": AppImages.energy, "name": "Energy"},
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
                  // Date difference
                  if (index == 0 || index == 4) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DateCalculationScreen(
                        title: index == 0 ? "Age" : "Date",
                      ),
                    ));
                  }

                  // BMI calculator
                  else if (index == 2) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BMICalculationScreen(),
                    ));
                  }

                  // Discount calculator
                  else if (index == 5) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DiscountCalculationScreen(),
                    ));
                  }

                  // Numeral calculator
                  else if (index == 8) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NumeralCalculationScreen(),
                    ));
                  }

                  // Temperature calculator
                  else if (index == 10) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TemperatureCalculationScreen(),
                    ));
                  }

                  // All other calculator
                  else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          OtherCalculationCommonViewScreen(index: index + 1),
                    ));
                  }
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
          ),
        ],
      ),
    );
  }
}
