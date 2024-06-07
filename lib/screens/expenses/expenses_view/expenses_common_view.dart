// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:flutter_expandable_fab/flutter_expandable_fab.dart";
import "package:genify/config/app_image.dart";
import "package:genify/config/app_style.dart";
import "package:genify/screens/add_expenses/add_expenses_screen.dart";
import "package:genify/screens/add_income/add_income_screen.dart";
import "package:genify/screens/show_expenses/show_expenses_screen.dart";
import "package:genify/screens/show_income/show_income_screen.dart";
import "package:get/get.dart";
import "package:lottie/lottie.dart";
import "package:syncfusion_flutter_charts/sparkcharts.dart";
import "../../../config/app_colors.dart";
import "../../../controller/transaction_controller.dart";
import "../../all_transaction/all_transaction_screen.dart";

class ExpensesCommonViewScreen extends StatefulWidget {
  const ExpensesCommonViewScreen({super.key});

  @override
  State<ExpensesCommonViewScreen> createState() =>
      _ExpensesCommonViewScreenState();
}

class _ExpensesCommonViewScreenState extends State<ExpensesCommonViewScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());

  @override
  void initState() {
    transactionController.getTransactionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(13),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Accont Balance",
                style: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 13,
                  color: AppColors.greyColor,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "₹${transactionController.totalAmount.value.toString()}",
                style: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShowIncomeScreen(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(AppImages.income),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Income",
                                      style: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                    Text(
                                      "₹${transactionController.totalIncome.value.toString()}",
                                      style: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 22,
                                        color: AppColors.whiteColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
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
                  SizedBox(
                    width: 9,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShowExpensesScreen(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(AppImages.expenses),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expenses",
                                      style: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 13,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                    Text(
                                      "₹${transactionController.totalExpenses.value.toString()}",
                                      style: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 22,
                                        color: AppColors.whiteColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
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
                ],
              ),
              SizedBox(
                height: 23,
              ),
              Text(
                "Spend Frequency",
                style: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 13,
              ),
              SfSparkLineChart(
                color: AppColors.primaryColor,
                axisLineColor: AppColors.greyColor,
                axisLineDashArray: [1.5, 7],
                trackball: SparkChartTrackball(
                  activationMode: SparkChartActivationMode.tap,
                  color: AppColors.greyColor,
                ),
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                labelStyle: AppTextStyle.smallTextStyle.copyWith(fontSize: 10),
                marker: SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                data: transactionController.amountsList,
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Transaction",
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllTransactionScreen(),
                      ));

                      // transactionController.getTransactionData();
                    },
                    child: Container(
                      height: 30,
                      width: 78,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          "See All",
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 15,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              transactionController.combinedList.isEmpty
                  ? Lottie.asset(
                      "assets/lottie/empty.json",
                      height: MediaQuery.of(context).size.height / 5,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: transactionController.combinedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.backgroundColor,
                                  content: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                              strokeWidth: 2,
                                            ),
                                            Container(
                                              height: 200,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                    color:
                                                        AppColors.primaryColor),
                                                image: DecorationImage(
                                                  image: Image.network(
                                                    transactionController
                                                            .combinedList[index]
                                                        ["image"],
                                                  ).image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Category: ",
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(fontSize: 14),
                                              ),
                                              TextSpan(
                                                text: transactionController
                                                        .combinedList[index]
                                                    ["title"],
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Description: ",
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(fontSize: 14),
                                              ),
                                              TextSpan(
                                                text: transactionController
                                                        .combinedList[index]
                                                    ["subTitle"],
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Amount: ",
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(fontSize: 14),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${transactionController.combinedList[index]["type"] == "income" ? "+" : "-"} ₹${transactionController.combinedList[index]["amount"]}",
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: transactionController
                                                                  .combinedList[
                                                              index]["type"] ==
                                                          "income"
                                                      ? AppColors.greenColor
                                                      : AppColors.redColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Wallet: ",
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(fontSize: 14),
                                              ),
                                              TextSpan(
                                                text: transactionController
                                                        .combinedList[index]
                                                    ["payment"],
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Date: ",
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(fontSize: 14),
                                              ),
                                              TextSpan(
                                                text: transactionController
                                                        .combinedList[index]
                                                    ["date"],
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Time: ",
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(fontSize: 14),
                                              ),
                                              TextSpan(
                                                text: transactionController
                                                        .combinedList[index]
                                                    ["time"],
                                                style: AppTextStyle
                                                    .regularTextStyle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        "Ok",
                                        style: AppTextStyle.regularTextStyle
                                            .copyWith(
                                          fontSize: 18,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 89,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 14),
                              child: Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                        strokeWidth: 2,
                                      ),
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                              color: AppColors.primaryColor),
                                          image: DecorationImage(
                                            image: Image.network(
                                              transactionController
                                                  .combinedList[index]["image"],
                                            ).image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transactionController
                                            .combinedList[index]["title"],
                                        style: AppTextStyle.regularTextStyle
                                            .copyWith(fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        transactionController
                                            .combinedList[index]["subTitle"],
                                        style: AppTextStyle.regularTextStyle
                                            .copyWith(
                                          fontSize: 12,
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${transactionController.combinedList[index]["type"] == "income" ? "+" : "-"} ₹${transactionController.combinedList[index]["amount"]}",
                                        style: AppTextStyle.regularTextStyle
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: transactionController
                                                          .combinedList[index]
                                                      ["type"] ==
                                                  "income"
                                              ? AppColors.greenColor
                                              : AppColors.redColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        transactionController
                                            .combinedList[index]["time"],
                                        style: AppTextStyle.regularTextStyle
                                            .copyWith(
                                          fontSize: 13,
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                    ],
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
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: Icon(
            Icons.add,
            size: 37,
          ),
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
          shape: CircleBorder(),
        ),
        closeButtonBuilder: RotateFloatingActionButtonBuilder(
          child: Icon(
            Icons.add,
            size: 37,
          ),
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
          shape: CircleBorder(),
        ),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddExpensesScreen(),
              ));
            },
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.redColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Image.asset(
                  AppImages.expenses,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddIncomeScreen(),
              ));
            },
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greenColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Image.asset(
                  AppImages.income,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
