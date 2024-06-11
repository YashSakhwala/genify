// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_style.dart';
import '../../../../widgets/common_widgets/appbar.dart';
import '../../../../widgets/common_widgets/text_field_view.dart';

class TemperatureCalculationScreen extends StatefulWidget {
  const TemperatureCalculationScreen({super.key});

  @override
  State<TemperatureCalculationScreen> createState() =>
      _TemperatureCalculationScreenState();
}

class _TemperatureCalculationScreenState
    extends State<TemperatureCalculationScreen> {
  final TextEditingController tempFirstValue = TextEditingController();
  final TextEditingController tempSecondValue = TextEditingController();
  String tempFirstUnit = "Celsius °C";
  String tempSecondUnit = "Celsius °C";
  bool tempFirstFieldActive = true;

  final Map<String, String> tempUnitSymbols = {
    "Celsius °C": "°C",
    "Fahrenheit °F": "°F",
    "Kelvin K": "K",
    "Rankine °R": "°R",
    "Réaumur °Re": "°Re",
  };

  void calculateTemperature(
      String fromUnit,
      String toUnit,
      TextEditingController fromController,
      TextEditingController toController) {
    double inputValue = double.tryParse(fromController.text) ?? 0.0;
    double result;

    switch (fromUnit) {
      case "Celsius °C":
        result = convertFromCelsius(inputValue, toUnit);
        break;
      case "Fahrenheit °F":
        result = convertFromFahrenheit(inputValue, toUnit);
        break;
      case "Kelvin K":
        result = convertFromKelvin(inputValue, toUnit);
        break;
      case "Rankine °R":
        result = convertFromRankine(inputValue, toUnit);
        break;
      case "Réaumur °Re":
        result = convertFromReaumur(inputValue, toUnit);
        break;
      default:
        result = inputValue;
    }

    setState(() {
      toController.text = tempFormatResult(result);
    });
  }

  double convertFromCelsius(double value, String toUnit) {
    switch (toUnit) {
      case "Fahrenheit °F":
        return (value * 9 / 5) + 32;
      case "Kelvin K":
        return value + 273.15;
      case "Rankine °R":
        return (value + 273.15) * 9 / 5;
      case "Réaumur °Re":
        return value * 4 / 5;
      default:
        return value;
    }
  }

  double convertFromFahrenheit(double value, String toUnit) {
    switch (toUnit) {
      case "Celsius °C":
        return (value - 32) * 5 / 9;
      case "Kelvin K":
        return (value + 459.67) * 5 / 9;
      case "Rankine °R":
        return value + 459.67;
      case "Réaumur °Re":
        return (value - 32) * 4 / 9;
      default:
        return value;
    }
  }

  double convertFromKelvin(double value, String toUnit) {
    switch (toUnit) {
      case "Celsius °C":
        return value - 273.15;
      case "Fahrenheit °F":
        return (value * 9 / 5) - 459.67;
      case "Rankine °R":
        return value * 9 / 5;
      case "Réaumur °Re":
        return (value - 273.15) * 4 / 5;
      default:
        return value;
    }
  }

  double convertFromRankine(double value, String toUnit) {
    switch (toUnit) {
      case "Celsius °C":
        return (value - 491.67) * 5 / 9;
      case "Fahrenheit °F":
        return value - 459.67;
      case "Kelvin K":
        return value * 5 / 9;
      case "Réaumur °Re":
        return (value - 491.67) * 4 / 9;
      default:
        return value;
    }
  }

  double convertFromReaumur(double value, String toUnit) {
    switch (toUnit) {
      case "Celsius °C":
        return value * 5 / 4;
      case "Fahrenheit °F":
        return (value * 9 / 4) + 32;
      case "Kelvin K":
        return (value * 5 / 4) + 273.15;
      case "Rankine °R":
        return (value * 9 / 4) + 491.67;
      default:
        return value;
    }
  }

  String tempFormatResult(double result) {
    if (result < 1e-6 || result > 1e6) {
      return result.toStringAsExponential(2);
    } else {
      return result
          .toStringAsFixed(2)
          .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
    }
  }

  void showTempUnitPicker(String unitType) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: tempUnitSymbols.length,
          itemBuilder: (BuildContext context, int index) {
            String unit = tempUnitSymbols.keys.elementAt(index);
            return ListTile(
              title: Text(
                unit,
                style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
              ),
              onTap: () {
                setState(() {
                  if (unitType == "from") {
                    tempFirstUnit = unit;
                  } else {
                    tempSecondUnit = unit;
                  }
                });
                Navigator.pop(context);
                if (tempFirstFieldActive) {
                  calculateTemperature(tempFirstUnit, tempSecondUnit,
                      tempFirstValue, tempSecondValue);
                } else {
                  calculateTemperature(tempSecondUnit, tempFirstUnit,
                      tempSecondValue, tempFirstValue);
                }
              },
            );
          },
        );
      },
    );
  }

  Widget tempUnitInputField(
      String unit, TextEditingController controller, VoidCallback onTap) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                tempUnitSymbols[unit]!,
                style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
              ),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: AppColors.greyColor,
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter value",
                hintStyle: AppTextStyle.regularTextStyle
                    .copyWith(color: AppColors.greyColor),
              ),
              textAlign: TextAlign.end,
              style: AppTextStyle.regularTextStyle.copyWith(fontSize: 30),
              onChanged: (value) {
                if (controller == tempFirstValue) {
                  tempFirstFieldActive = true;
                  calculateTemperature(tempFirstUnit, tempSecondUnit,
                      tempFirstValue, tempSecondValue);
                } else {
                  tempFirstFieldActive = false;
                  calculateTemperature(tempSecondUnit, tempFirstUnit,
                      tempSecondValue, tempFirstValue);
                }
              },
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
        title: "Temperature",
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
                tempUnitInputField(tempFirstUnit, tempFirstValue,
                    () => showTempUnitPicker("from")),
                SizedBox(
                  height: 30,
                ),
                tempUnitInputField(tempSecondUnit, tempSecondValue,
                    () => showTempUnitPicker("to")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
