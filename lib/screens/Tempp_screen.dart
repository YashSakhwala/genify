// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, file_names, sized_box_for_whitespace

import "package:flutter/material.dart";
import "package:genify/config/app_colors.dart";
import "package:genify/config/app_style.dart";
import "../../../widgets/common_widgets/text_field_view.dart";

class TempScreen extends StatefulWidget {
  final int index;

  const TempScreen({required this.index});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  final Map calculators = {};

  // All covertation
  @override
  void initState() {
    super.initState();

    calculators["Area"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Square kilometer km²", "Square kilometer km²"],
      "unitSymbols": {
        "Square kilometer km²": "km²",
        "Hectare ha": "ha",
        "Are a": "a",
        "Square meter m²": "m²",
        "Square decimeter dm²": "dm²",
      },
      "conversionFactors": <String, double>{
        "Square kilometer km²": 1e6,
        "Hectare ha": 1e4,
        "Are a": 100,
        "Square meter m²": 1,
        "Square decimeter dm²": 0.01,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Data"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Byte B", "Byte B"],
      "unitSymbols": {
        "Byte B": "B",
        "Kilobyte KB": "KB",
        "Megabyte MB": "MB",
        "Gigabyte GB": "GB",
        "Terabyte TB": "TB",
        "Petabyte PB": "PB",
      },
      "conversionFactors": <String, double>{
        "Byte B": 1,
        "Kilobyte KB": 1024,
        "Megabyte MB": 1024 * 1024,
        "Gigabyte GB": 1024 * 1024 * 1024,
        "Terabyte TB": 1024 * 1024 * 1024 * 1024,
        "Petabyte PB": 1024 * 1024 * 1024 * 1024 * 1024,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Length"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Meter m", "Meter m"],
      "unitSymbols": {
        "Kilometer km": "km",
        "Meter m": "m",
        "Decimeter dm": "dm",
        "Centimeter cm": "cm",
        "Millimeter mm": "mm",
        "Micrometer μm": "μm",
      },
      "conversionFactors": <String, double>{
        "Kilometer km": 1000.0,
        "Meter m": 1.0,
        "Decimeter dm": 0.1,
        "Centimeter cm": 0.01,
        "Millimeter mm": 0.001,
        "Micrometer μm": 0.000001,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators.forEach((_, calculator) {
      calculator["values"][0].addListener(() {
        handleInputChange(calculator);
      });
      calculator["values"][1].addListener(() {
        handleInputChange(calculator);
      });
    });
  }

  void handleInputChange(Map<String, dynamic> calculator) {
    final fromController = calculator["values"][0];
    final toController = calculator["values"][1];
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
      calculator["units"][0],
      calculator["units"][1],
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
                  setState,
                );
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
        return Text("Date calculation");
      case 2:
        return buildCalculator("Area");
      case 3:
        return Text("BMI calculation");
      case 4:
        return buildCalculator("Data");
      case 5:
        return Text("Date calculation");
      case 6:
        return Text("Discount calculation");
      case 7:
        return buildCalculator("Length");
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
