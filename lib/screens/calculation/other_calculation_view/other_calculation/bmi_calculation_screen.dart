// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:genify/widgets/common_widgets/appbar.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_style.dart';
import '../../../../widgets/common_widgets/text_field_view.dart';

class BMICalculationScreen extends StatefulWidget {
  const BMICalculationScreen({super.key});

  @override
  State<BMICalculationScreen> createState() => _BMICalculationScreenState();
}

class _BMICalculationScreenState extends State<BMICalculationScreen> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String weightUnit = "Kilograms kg";
  String heightUnit = "Centimeters cm";
  String bmiResult = "";

  final Map<String, String> bmiUnitSymbols = {
    "Kilograms kg": "kg",
    "Pounds lb": "lb",
    "Centimeters cm": "cm",
    "Meters m": "m",
    "Feet ft": "ft",
    "Inches in": "in",
  };

  final Map<String, double> bmiConversionFactors = {
    "Kilograms kg": 1,
    "Pounds lb": 0.453592,
    "Centimeters cm": 1,
    "Meters m": 100,
    "Feet ft": 30.48,
    "Inches in": 2.54,
  };

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;

    weight *= bmiConversionFactors[weightUnit] ?? 1;
    height *= bmiConversionFactors[heightUnit] ?? 1;

    if (height > 0 && weight > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      setState(() {
        bmiResult = bmi.toStringAsFixed(2);
      });
    } else {
      setState(() {
        bmiResult = "";
      });
    }
  }

  void showBMIUnitPicker(String type) {
    List<String> units = type == "weight"
        ? ["Kilograms kg", "Pounds lb"]
        : ["Centimeters cm", "Meters m", "Feet ft", "Inches in"];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            children: units.map((unit) {
              return ListTile(
                title: Text(
                  unit,
                  style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    if (type == "weight") {
                      weightUnit = unit;
                    } else {
                      heightUnit = unit;
                    }
                  });
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget bmiUnitInputField(
      String unit, TextEditingController controller, VoidCallback onTap) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                bmiUnitSymbols[unit]!,
                style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
              ),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: TextFieldView(
              title: "",
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter value",
                hintStyle: AppTextStyle.regularTextStyle
                    .copyWith(color: AppColors.greyColor),
              ),
              textAlign: TextAlign.end,
              style: AppTextStyle.regularTextStyle.copyWith(fontSize: 30),
              onChanged: (value) => calculateBMI(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(
        title: "BMI",
        style: AppTextStyle.regularTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width >= 900 ? false : true,
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
      ),
      body: Center(
        child: Container(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                bmiUnitInputField(weightUnit, weightController,
                    () => showBMIUnitPicker("weight")),
                SizedBox(height: 30),
                bmiUnitInputField(heightUnit, heightController,
                    () => showBMIUnitPicker("height")),
                SizedBox(
                  height: 70,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.greyColor.shade400,
                    ),
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: bmiResult,
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 35,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: " BMI",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 20,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
