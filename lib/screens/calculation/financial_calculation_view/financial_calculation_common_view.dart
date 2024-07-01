// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_string_interpolations, sized_box_for_whitespace

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "../../../config/app_colors.dart";
import "../../../config/app_style.dart";
import "../../../widgets/common_widgets/appbar.dart";
import "../../../widgets/common_widgets/text_field_view.dart";
import "dart:math";

class FinancialCalculationCommonViewScreen extends StatefulWidget {
  final int index;

  const FinancialCalculationCommonViewScreen({
    super.key,
    required this.index,
  });

  @override
  State<FinancialCalculationCommonViewScreen> createState() =>
      _FinancialCalculationCommonViewScreenState();
}

class _FinancialCalculationCommonViewScreenState
    extends State<FinancialCalculationCommonViewScreen> {
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

  // GST calculator
  final TextEditingController originalPriceController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController finalPriceController = TextEditingController();

  void calculateGst() {
    double originalPrice = double.tryParse(originalPriceController.text) ?? 0.0;
    double gst = double.tryParse(gstController.text) ?? 0.0;

    double gstAmount = originalPrice * gst / 100;
    double finalPrice = originalPrice + gstAmount;

    setState(() {
      finalPriceController.text = finalPrice.toStringAsFixed(2);
    });
  }

  Widget gstUnitInputField(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
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
                hintStyle: TextStyle(color: Colors.grey),
              ),
              textAlign: TextAlign.end,
              style: AppTextStyle.regularTextStyle.copyWith(fontSize: 19),
            ),
          ),
        ),
      ],
    );
  }

  // Investment calculator
  TextEditingController investmentController = TextEditingController();
  TextEditingController investmentInterestController = TextEditingController();
  int investmentSelectedYears = 0;
  int investmentSelectedMonths = 0;
  double maturityAmount = 0.0;
  bool investmentUpdating = false;

  void calculateMaturityAmount() {
    double investment = double.tryParse(investmentController.text) ?? 0;
    double annualInterestRate =
        double.tryParse(investmentInterestController.text) ?? 0;
    int totalMonths = investmentSelectedYears * 12 + investmentSelectedMonths;

    if (investment != 0 && annualInterestRate != 0 && totalMonths != 0) {
      double monthlyRate = annualInterestRate / 12 / 100;
      double totalPeriods = totalMonths.toDouble();
      double calculatedMaturityAmount =
          investment * pow((1 + monthlyRate), totalPeriods);

      setState(() {
        maturityAmount = calculatedMaturityAmount;
      });
    } else {
      setState(() {
        maturityAmount = 0.0;
      });
    }
  }

  // Loan calculator
  TextEditingController principalController = TextEditingController();
  TextEditingController loanInterestController = TextEditingController();
  int loanSelectedYears = 0;
  int loanSelectedMonths = 0;
  double monthlyPayment = 0.0;
  bool loanUpdating = false;

  void calculateMonthlyPayment() {
    double principal = double.tryParse(principalController.text) ?? 0;
    double annualInterestRate =
        double.tryParse(loanInterestController.text) ?? 0;
    int totalMonths = loanSelectedYears * 12 + loanSelectedMonths;

    if (principal != 0 && annualInterestRate != 0 && totalMonths != 0) {
      double monthlyRate = annualInterestRate / 12 / 100;
      double calculatedMonthlyPayment = principal *
          monthlyRate *
          pow(1 + monthlyRate, totalMonths) /
          (pow(1 + monthlyRate, totalMonths) - 1);

      setState(() {
        monthlyPayment = calculatedMonthlyPayment;
      });
    } else {
      setState(() {
        monthlyPayment = 0.0;
      });
    }
  }

  // Dividend calculator
  TextEditingController sharePriceController = TextEditingController();
  TextEditingController annualDividendController = TextEditingController();
  TextEditingController dividendYieldController = TextEditingController();
  bool dividendUpdating = false;

  void updateDividendYieldFromSharePrice() {
    double sharePrice = double.tryParse(sharePriceController.text) ?? 0;
    double annualDividend = double.tryParse(annualDividendController.text) ?? 0;
    if (sharePrice != 0) {
      double yield = (annualDividend / sharePrice) * 100;
      if (yield.toStringAsFixed(2) != dividendYieldController.text) {
        dividendYieldController.text = yield.toStringAsFixed(2);
      }
    } else {
      dividendYieldController.text = "0";
    }
  }

  void updateDividendYieldFromAnnualDividend() {
    double sharePrice = double.tryParse(sharePriceController.text) ?? 0;
    double annualDividend = double.tryParse(annualDividendController.text) ?? 0;
    if (sharePrice != 0) {
      double yield = (annualDividend / sharePrice) * 100;
      if (yield.toStringAsFixed(2) != dividendYieldController.text) {
        dividendYieldController.text = yield.toStringAsFixed(2);
      }
    } else {
      dividendYieldController.text = "0";
    }
  }

  void updateAnnualDividendFromYield() {
    double sharePrice = double.tryParse(sharePriceController.text) ?? 0;
    double yield = double.tryParse(dividendYieldController.text) ?? 0;
    if (yield != 0) {
      double annualDividend = (yield / 100) * sharePrice;
      if (annualDividend.toStringAsFixed(2) != annualDividendController.text) {
        annualDividendController.text = annualDividend.toStringAsFixed(2);
      }
    } else {
      annualDividendController.text = "0";
    }
  }

  // Capital gain calculator
  TextEditingController boughtPriceController = TextEditingController();
  TextEditingController currentPriceController = TextEditingController();
  TextEditingController capitalGainsController = TextEditingController();
  TextEditingController capitalGainsYieldController = TextEditingController();
  bool gainUpdating = false;

  void updateCapitalGainsAndYield() {
    double boughtPrice = double.tryParse(boughtPriceController.text) ?? 0;
    double currentPrice = double.tryParse(currentPriceController.text) ?? 0;
    double capitalGains = currentPrice - boughtPrice;
    double capitalGainsYield = (capitalGains / boughtPrice) * 100;

    capitalGainsController.text = capitalGains.toStringAsFixed(2);
    capitalGainsYieldController.text = capitalGainsYield.toStringAsFixed(2);
  }

  // Init state
  @override
  void initState() {
    super.initState();

    // GST calculator
    originalPriceController.addListener(calculateGst);
    gstController.addListener(calculateGst);

    // Investment calculator
    investmentController.addListener(() {
      if (investmentUpdating) return;
      investmentUpdating = true;
      calculateMaturityAmount();
      investmentUpdating = false;
    });

    investmentInterestController.addListener(() {
      if (investmentUpdating) return;
      investmentUpdating = true;
      calculateMaturityAmount();
      investmentUpdating = false;
    });

    // Loan calculator
    principalController.addListener(() {
      if (loanUpdating) return;
      loanUpdating = true;
      calculateMonthlyPayment();
      loanUpdating = false;
    });

    loanInterestController.addListener(() {
      if (loanUpdating) return;
      loanUpdating = true;
      calculateMonthlyPayment();
      loanUpdating = false;
    });

    // Dividend calculator
    sharePriceController.addListener(() {
      if (dividendUpdating) return;
      dividendUpdating = true;
      updateDividendYieldFromSharePrice();
      dividendUpdating = false;
    });

    annualDividendController.addListener(() {
      if (dividendUpdating) return;
      dividendUpdating = true;
      updateDividendYieldFromAnnualDividend();
      dividendUpdating = false;
    });

    dividendYieldController.addListener(() {
      if (dividendUpdating) return;
      dividendUpdating = true;
      updateAnnualDividendFromYield();
      dividendUpdating = false;
    });

    // Capital gain calculator
    boughtPriceController.addListener(() {
      if (gainUpdating) return;
      gainUpdating = true;
      updateCapitalGainsAndYield();
      gainUpdating = false;
    });

    currentPriceController.addListener(() {
      if (gainUpdating) return;
      gainUpdating = true;
      updateCapitalGainsAndYield();
      gainUpdating = false;
    });
  }

  Widget buildContainer(int index) {
    switch (index) {
      case 1:
        return Column(
          children: [
            titleBar(context, "GST"),
            Center(
              child: Container(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      gstUnitInputField(
                          "Original price", originalPriceController),
                      SizedBox(
                        height: 20,
                      ),
                      gstUnitInputField("GST", gstController),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Final price",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Text(
                            finalPriceController.text,
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 19),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            titleBar(context, "Investment"),
            Center(
              child: Container(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total Investment",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: investmentController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter value",
                                  hintStyle: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.regularTextStyle
                                    .copyWith(fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Interest (%)",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: investmentInterestController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter value",
                                  hintStyle: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.regularTextStyle
                                    .copyWith(fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Duration",
                                  style: AppTextStyle.regularTextStyle
                                      .copyWith(fontSize: 18),
                                ),
                                TextSpan(
                                  text: " (year/month)",
                                  style: AppTextStyle.regularTextStyle
                                      .copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              DropdownButton<int>(
                                value: investmentSelectedYears,
                                items: List.generate(31, (index) => index)
                                    .map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    investmentSelectedYears = value!;
                                    calculateMaturityAmount();
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton<int>(
                                value: investmentSelectedMonths,
                                items: List.generate(12, (index) => index)
                                    .map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    investmentSelectedMonths = value!;
                                    calculateMaturityAmount();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Total value: ",
                                style: AppTextStyle.regularTextStyle,
                              ),
                              TextSpan(
                                text: "${maturityAmount.toStringAsFixed(2)}",
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case 3:
        return Column(
          children: [
            titleBar(context, "Loan"),
            Center(
              child: Container(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Principal Amount",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: principalController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter value",
                                  hintStyle: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.regularTextStyle
                                    .copyWith(fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Interest (%)",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: loanInterestController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter value",
                                  hintStyle: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.regularTextStyle
                                    .copyWith(fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Loan tenure",
                                  style: AppTextStyle.regularTextStyle
                                      .copyWith(fontSize: 18),
                                ),
                                TextSpan(
                                  text: " (year/month)",
                                  style: AppTextStyle.regularTextStyle
                                      .copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              DropdownButton<int>(
                                value: loanSelectedYears,
                                items: List.generate(31, (index) => index)
                                    .map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    loanSelectedYears = value!;
                                    calculateMonthlyPayment();
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton<int>(
                                value: loanSelectedMonths,
                                items: List.generate(12, (index) => index)
                                    .map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    loanSelectedMonths = value!;
                                    calculateMonthlyPayment();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "EMI: ",
                                style: AppTextStyle.regularTextStyle,
                              ),
                              TextSpan(
                                text: "${monthlyPayment.toStringAsFixed(2)}",
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case 4:
        return Column(
          children: [
            titleBar(context, "Dividend"),
            Center(
              child: Container(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Share price",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: sharePriceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter value",
                                  hintStyle: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.regularTextStyle
                                    .copyWith(fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Annual dividend \nper share",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: annualDividendController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter value",
                                  hintStyle: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.regularTextStyle
                                    .copyWith(fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Dividend yield",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: dividendYieldController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter value",
                                  hintStyle: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.regularTextStyle
                                    .copyWith(fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      case 5:
        return Column(
          children: [
            titleBar(context, "Capital Gain"),
            Center(
              child: Container(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Bought price",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: boughtPriceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter value",
                                  hintStyle: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.regularTextStyle
                                    .copyWith(fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Current price",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: currentPriceController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter value",
                                  hintStyle: AppTextStyle.regularTextStyle
                                      .copyWith(color: AppColors.greyColor),
                                ),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.regularTextStyle
                                    .copyWith(fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Capital gains",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: capitalGainsController,
                                enabled: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "Capital gains yield",
                            style: AppTextStyle.regularTextStyle
                                .copyWith(fontSize: 18),
                          ),
                          Spacer(),
                          Expanded(
                            child: Container(
                              child: TextFieldView(
                                title: "",
                                controller: capitalGainsYieldController,
                                enabled: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
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
