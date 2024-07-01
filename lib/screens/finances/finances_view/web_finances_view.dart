// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:genify/config/app_colors.dart';
import 'package:get/get.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../controller/transaction_controller.dart';
import '../../../widgets/common_widgets/empty_view.dart';
import '../../add_expenses/add_expenses_screen.dart';
import '../../add_income/add_income_screen.dart';
import '../../all_transaction/all_transaction_screen.dart';
import '../../edit_details/edit_details_screen.dart';
import '../../show_expenses/show_expenses_screen.dart';
import '../../show_income/show_income_screen.dart';

class WebFinancesScreen extends StatefulWidget {
  const WebFinancesScreen({super.key});

  @override
  State<WebFinancesScreen> createState() => _WebFinancesScreenState();
}

class _WebFinancesScreenState extends State<WebFinancesScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());

  String? hoveredIndex;

  @override
  void initState() {
    Future.microtask(() => transactionController.getTransactionData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Obx(
        () => transactionController.isLoader.value == true
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Account Balance",
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
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShowIncomeScreen(),
                                ));
                              },
                              child: Container(
                                width: 250,
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
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Incomes",
                                              style: AppTextStyle
                                                  .regularTextStyle
                                                  .copyWith(
                                                fontSize: 13,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                            Text(
                                              "₹${transactionController.totalIncome.value.toString()}",
                                              style: AppTextStyle
                                                  .regularTextStyle
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
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShowExpensesScreen(),
                                ));
                              },
                              child: Container(
                                width: 250,
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child:
                                              Image.asset(AppImages.expenses),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Expenses",
                                              style: AppTextStyle
                                                  .regularTextStyle
                                                  .copyWith(
                                                fontSize: 13,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                            Text(
                                              "₹${transactionController.totalExpenses.value.toString()}",
                                              style: AppTextStyle
                                                  .regularTextStyle
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
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Transactions",
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
                                    style:
                                        AppTextStyle.regularTextStyle.copyWith(
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
                          height: 20,
                        ),
                        transactionController.todayTransactions.isEmpty
                            ? Center(child: EmptyView())
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  List allData = transactionController
                                      .dataEntries[index].value;

                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: 100,
                                    ),
                                    itemCount: allData.length,
                                    itemBuilder: (context, allDataIndex) {
                                      return MouseRegion(
                                        onEnter: (_) {
                                          setState(() {
                                            hoveredIndex = allData[allDataIndex]
                                                    ["uniqueTime"]
                                                .toString();
                                          });
                                        },
                                        onExit: (_) {
                                          setState(() {
                                            hoveredIndex = null;
                                          });
                                        },
                                        child: Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor: AppColors
                                                          .backgroundColor,
                                                      content: Container(
                                                        width: 250,
                                                        padding:
                                                            EdgeInsets.all(16),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  CircularProgressIndicator(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    strokeWidth:
                                                                        2,
                                                                  ),
                                                                  Container(
                                                                    height: 200,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                      border: Border.all(
                                                                          color:
                                                                              AppColors.primaryColor),
                                                                      image:
                                                                          DecorationImage(
                                                                        image: Image
                                                                            .network(
                                                                          allData[allDataIndex]
                                                                              [
                                                                              "image"],
                                                                        ).image,
                                                                        fit: BoxFit
                                                                            .cover,
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
                                                                    "Category : ",
                                                                    style: AppTextStyle
                                                                        .regularTextStyle
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      allData[allDataIndex]
                                                                          [
                                                                          "title"],
                                                                      style: AppTextStyle
                                                                          .regularTextStyle
                                                                          .copyWith(
                                                                              fontSize: 14),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Description : ",
                                                                    style: AppTextStyle
                                                                        .regularTextStyle
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      allData[allDataIndex]
                                                                          [
                                                                          "subTitle"],
                                                                      style: AppTextStyle
                                                                          .regularTextStyle
                                                                          .copyWith(
                                                                              fontSize: 14),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Amount : ",
                                                                    style: AppTextStyle
                                                                        .regularTextStyle
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${allData[allDataIndex]["type"] == "Incomes" ? "+" : "-"} ₹${allData[allDataIndex]["amount"]}",
                                                                      style: AppTextStyle
                                                                          .regularTextStyle
                                                                          .copyWith(
                                                                        fontSize:
                                                                            14,
                                                                        color: allData[allDataIndex]["type"] ==
                                                                                "Incomes"
                                                                            ? AppColors.greenColor
                                                                            : AppColors.redColor,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Wallet : ",
                                                                    style: AppTextStyle
                                                                        .regularTextStyle
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      allData[allDataIndex]
                                                                          [
                                                                          "payment"],
                                                                      style: AppTextStyle
                                                                          .regularTextStyle
                                                                          .copyWith(
                                                                              fontSize: 14),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Date : ",
                                                                    style: AppTextStyle
                                                                        .regularTextStyle
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      allData[allDataIndex]
                                                                          [
                                                                          "date"],
                                                                      style: AppTextStyle
                                                                          .regularTextStyle
                                                                          .copyWith(
                                                                              fontSize: 14),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Time : ",
                                                                    style: AppTextStyle
                                                                        .regularTextStyle
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      allData[allDataIndex]
                                                                          [
                                                                          "time"],
                                                                      style: AppTextStyle
                                                                          .regularTextStyle
                                                                          .copyWith(
                                                                              fontSize: 14),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          child: Text(
                                                            "Ok",
                                                            style: AppTextStyle
                                                                .regularTextStyle
                                                                .copyWith(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor
                                                      .withOpacity(0.06),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 17,
                                                      vertical: 14),
                                                  child: Row(
                                                    children: [
                                                      Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          CircularProgressIndicator(
                                                            color: AppColors
                                                                .primaryColor,
                                                            strokeWidth: 2,
                                                          ),
                                                          Container(
                                                            height: 60,
                                                            width: 60,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .primaryColor),
                                                              image:
                                                                  DecorationImage(
                                                                image: Image
                                                                    .network(
                                                                  allData[allDataIndex]
                                                                      ["image"],
                                                                ).image,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 9,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              allData[allDataIndex]
                                                                  ["title"],
                                                              style: AppTextStyle
                                                                  .regularTextStyle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          17),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(
                                                              height: 7,
                                                            ),
                                                            Text(
                                                              allData[allDataIndex]
                                                                  ["subTitle"],
                                                              style: AppTextStyle
                                                                  .regularTextStyle
                                                                  .copyWith(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .greyColor,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "${allData[allDataIndex]["type"] == "Incomes" ? "+" : "-"} ₹${allData[allDataIndex]["amount"]}",
                                                              style: AppTextStyle
                                                                  .regularTextStyle
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: allData[allDataIndex]
                                                                            [
                                                                            "type"] ==
                                                                        "Incomes"
                                                                    ? AppColors
                                                                        .greenColor
                                                                    : AppColors
                                                                        .redColor,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(
                                                              height: 7,
                                                            ),
                                                            Text(
                                                              allData[allDataIndex]
                                                                  ["time"],
                                                              style: AppTextStyle
                                                                  .regularTextStyle
                                                                  .copyWith(
                                                                fontSize: 13,
                                                                color: AppColors
                                                                    .greyColor,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (hoveredIndex ==
                                                allData[allDataIndex]
                                                        ["uniqueTime"]
                                                    .toString())
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  width: 50,
                                                  margin: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditDetailsScreen(
                                                              type: allData[
                                                                      allDataIndex]
                                                                  ["type"],
                                                              amount: allData[
                                                                      allDataIndex]
                                                                  ["amount"],
                                                              title: allData[
                                                                      allDataIndex]
                                                                  ["title"],
                                                              subtitle: allData[
                                                                      allDataIndex]
                                                                  ["subTitle"],
                                                              wallet: allData[
                                                                      allDataIndex]
                                                                  ["payment"],
                                                              image: allData[
                                                                      allDataIndex]
                                                                  ["image"],
                                                              uniqueTime: allData[
                                                                      allDataIndex]
                                                                  [
                                                                  "uniqueTime"],
                                                            ),
                                                          ));
                                                        },
                                                        child: Container(
                                                          height: 36,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .greenColor
                                                                .shade500,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          margin:
                                                              EdgeInsets.all(3),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.edit,
                                                              size: 20,
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          transactionController
                                                              .removeTransactionData(
                                                            uniqueTime: allData[
                                                                    allDataIndex]
                                                                ["uniqueTime"],
                                                            context: context,
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 36,
                                                          width: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .redColor
                                                                .shade400,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          margin:
                                                              EdgeInsets.all(3),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.delete,
                                                              size: 20,
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
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
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AddIncomeScreen(),
              );
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
