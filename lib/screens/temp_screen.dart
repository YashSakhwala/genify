// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/widgets/common_widgets/appbar.dart';
import '../../../widgets/common_widgets/text_field_view.dart';

class TempScreen extends StatefulWidget {
  final int index;

  const TempScreen({required this.index});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  final Map<String, Map<String, dynamic>> calculators = {};

  Widget titleBar(BuildContext context, String title) {
    return AppBarView(
      title: title,
      style: AppTextStyle.regularTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      automaticallyImplyLeading:
          MediaQuery.of(context).size.width >= 900 ? false : true,
      centerTitle: true,
      backgroundColor: AppColors.transparentColor,
    );
  }

  @override
  void initState() {
    super.initState();

    calculators["Area"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Square kilometer km²", "Square kilometer km²"],
      "unitSymbols": {
        "Square kilometer km²": "km²",
        // other units...
      },
      "conversionFactors": <String, double>{
        "Square kilometer km²": 1e6,
        // other factors...
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Speed"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Lightspeed c", "Lightspeed c"],
      "unitSymbols": {
        "Lightspeed c": "c",
        // other units...
      },
      "conversionFactors": <String, double>{
        "Lightspeed c": 299792458,
        // other factors...
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Time"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Year y", "Year y"],
      "unitSymbols": {
        "Year y": "y",
        // other units...
      },
      "conversionFactors": <String, double>{
        "Year y": 31536000,
        // other factors...
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Temperature"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Celsius °C", "Celsius °C"],
      "unitSymbols": {
        "Celsius °C": "°C",
        "Fahrenheit °F": "°F",
        "Kelvin K": "K",
      },
      "conversionFactors": <String, double>{
        "Celsius °C": 1,
        "Fahrenheit °F": 5 / 9,
        "Kelvin K": 1,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators.forEach((_, calculator) {
      calculator["values"][0].addListener(() {
        handleInputChange(calculator, 0);
      });
      calculator["values"][1].addListener(() {
        handleInputChange(calculator, 1);
      });
    });
  }

  void handleInputChange(Map<String, dynamic> calculator, int index) {
    final fromController = calculator["values"][index];
    final toController = calculator["values"][1 - index];
    if (fromController.text.isEmpty) {
      toController.text = '';
      return;
    }
    final fromValue = double.tryParse(fromController.text);
    if (fromValue == null) {
      toController.text = '';
      return;
    }
    calculator["calculate"](
      calculator["units"][index],
      calculator["units"][1 - index],
      fromController,
      toController,
      calculator["conversionFactors"],
      setState,
    );
  }

  String formatResult(double result) {
    return (result < 1e-6 || result > 1e6)
        ? result.toStringAsExponential(2)
        : result.toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
  }

  void calculate(
      String fromUnit,
      String toUnit,
      TextEditingController fromController,
      TextEditingController toController,
      Map<String, double> conversionFactors,
      void Function(void Function()) setState) {
    double inputValue = double.tryParse(fromController.text) ?? 0.0;
    double fromFactor = conversionFactors[fromUnit] ?? 1.0;
    double toFactor = conversionFactors[toUnit] ?? 1.0;
    double result = inputValue * (fromFactor / toFactor);
    setState(() {
      toController.text = formatResult(result);
    });
  }

  void showUnitPicker(String calculatorType, String unitType) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final unitSymbols = calculators[calculatorType]!["unitSymbols"];
        return ListView.builder(
          itemCount: unitSymbols.length,
          itemBuilder: (BuildContext context, int index) {
            String unit = unitSymbols.keys.elementAt(index);
            return ListTile(
              title: Text(
                unit,
                style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
              ),
              onTap: () {
                setState(() {
                  calculators[calculatorType]!["units"]
                      [unitType == "from" ? 0 : 1] = unit;
                });
                Navigator.pop(context);
                calculators[calculatorType]!["calculate"](
                    calculators[calculatorType]!["units"][0],
                    calculators[calculatorType]!["units"][1],
                    calculators[calculatorType]!["values"][0],
                    calculators[calculatorType]!["values"][1],
                    calculators[calculatorType]!["conversionFactors"],
                    setState);
              },
            );
          },
        );
      },
    );
  }

  Widget unitInputField(String calculatorType, int unitIndex) {
    return Row(
      children: [
        GestureDetector(
          onTap: () =>
              showUnitPicker(calculatorType, unitIndex == 0 ? "from" : "to"),
          child: Row(
            children: [
              Text(
                calculators[calculatorType]!["unitSymbols"]
                    [calculators[calculatorType]!["units"][unitIndex]]!,
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
              controller: calculators[calculatorType]!["values"][unitIndex],
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9.]'), // Allowing both numbers and decimal points
                ),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter value",
                hintStyle: AppTextStyle.regularTextStyle
                    .copyWith(color: AppColors.greyColor),
              ),
              textAlign: TextAlign.end,
              style: AppTextStyle.regularTextStyle.copyWith(fontSize: 30),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCalculator(String calculatorType) {
    return Column(
      children: [
        titleBar(context, calculatorType),
        Center(
          child: Container(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  unitInputField(calculatorType, 0),
                  SizedBox(
                    height: 30,
                  ),
                  unitInputField(calculatorType, 1),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContainer(int index) {
    switch (index) {
      case 1:
        return buildCalculator("Area");
      case 2:
        return buildCalculator("Speed");
      case 3:
        return buildCalculator("Time");
      case 4:
        return buildCalculator("Temperature");
      default:
        return Container(
          color: Colors.grey,
          height: 100,
          width: 100,
          child: Center(child: Text("Default Case")),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Center(
            child: buildContainer(widget.index),
          ),
        ],
      ),
    );
  }
}
