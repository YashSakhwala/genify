// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_style.dart';
import '../../../../widgets/common_widgets/appbar.dart';
import '../../../../widgets/common_widgets/text_field_view.dart';

class NumeralCalculationScreen extends StatefulWidget {
  const NumeralCalculationScreen({super.key});

  @override
  State<NumeralCalculationScreen> createState() =>
      _NumeralCalculationScreenState();
}

class _NumeralCalculationScreenState extends State<NumeralCalculationScreen> {
  final TextEditingController numeralFirstValue = TextEditingController();
  final TextEditingController numeralSecondValue = TextEditingController();
  String numeralFirstUnit = "Decimal DEC";
  String numeralSecondUnit = "Decimal DEC";
  bool isFirstFieldActive = true;

  final Map<String, int> numeralUnitSymbols = {
    "Binary BIN": 2,
    "Octal OCT": 8,
    "Decimal DEC": 10,
    "Hexadecimal HEX": 16,
  };

  final Map<String, String> numeraldataUnitSymbols = {
    "Binary BIN": "BIN",
    "Octal OCT": "OCT",
    "Decimal DEC": "DEC",
    "Hexadecimal HEX": "HEX",
  };

  void convertNumeralSystem(String source) {
    String inputText;
    int inputBase, outputBase;
    if (source == "input") {
      inputText = numeralFirstValue.text;
      inputBase = numeralUnitSymbols[numeralFirstUnit] ?? 10;
      outputBase = numeralUnitSymbols[numeralSecondUnit] ?? 10;
      if (inputText.isNotEmpty) {
        int inputValue = int.parse(inputText, radix: inputBase);
        String outputValue = inputValue.toRadixString(outputBase).toUpperCase();
        setState(() {
          numeralSecondValue.text = outputValue;
        });
      } else {
        setState(() {
          numeralSecondValue.text = "";
        });
      }
    } else {
      inputText = numeralSecondValue.text;
      inputBase = numeralUnitSymbols[numeralSecondUnit] ?? 10;
      outputBase = numeralUnitSymbols[numeralFirstUnit] ?? 10;
      if (inputText.isNotEmpty) {
        int inputValue = int.parse(inputText, radix: inputBase);
        String outputValue = inputValue.toRadixString(outputBase).toUpperCase();
        setState(() {
          numeralFirstValue.text = outputValue;
        });
      } else {
        setState(() {
          numeralFirstValue.text = "";
        });
      }
    }
  }

  void showNumeralUnitPicker(String unitType) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: numeralUnitSymbols.length,
          itemBuilder: (BuildContext context, int index) {
            String unit = numeralUnitSymbols.keys.elementAt(index);
            return ListTile(
              title: Text(
                unit,
                style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
              ),
              onTap: () {
                setState(() {
                  if (unitType == "input") {
                    numeralFirstUnit = unit;
                  } else {
                    numeralSecondUnit = unit;
                  }
                });
                Navigator.pop(context);
                convertNumeralSystem(unitType == "input" ? "input" : "output");
              },
            );
          },
        );
      },
    );
  }

  List<TextInputFormatter> numeralInputFormatters(String unit) {
    switch (unit) {
      case "Binary BIN":
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-1]'))];
      case "Octal OCT":
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-7]'))];
      case "Decimal DEC":
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))];
      case "Hexadecimal HEX":
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Fa-f]'))];
      default:
        return [];
    }
  }

  Widget numeralUnitInputField(
      String unit, TextEditingController controller, VoidCallback onTap) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                numeraldataUnitSymbols[unit]!,
                style: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 18,
                ),
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
              keyboardType: unit == "Hexadecimal HEX"
                  ? TextInputType.text
                  : TextInputType.number,
              inputFormatters: numeralInputFormatters(unit),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter value",
                hintStyle: AppTextStyle.regularTextStyle
                    .copyWith(color: AppColors.greyColor),
              ),
              textAlign: TextAlign.end,
              style: AppTextStyle.regularTextStyle.copyWith(fontSize: 30),
              onChanged: (value) {
                isFirstFieldActive = (controller == numeralFirstValue);
                convertNumeralSystem(isFirstFieldActive ? "input" : "output");
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
        title: "Numeral system",
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
                numeralUnitInputField(numeralFirstUnit, numeralFirstValue,
                    () => showNumeralUnitPicker("input")),
                SizedBox(
                  height: 30,
                ),
                numeralUnitInputField(numeralSecondUnit, numeralSecondValue,
                    () => showNumeralUnitPicker("output")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
