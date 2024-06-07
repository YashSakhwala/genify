// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/widgets/common_widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../config/app_style.dart';
import '../../../controller/transaction_controller.dart';

class ShowExpensesCommonViewScreen extends StatefulWidget {
  const ShowExpensesCommonViewScreen({super.key});

  @override
  State<ShowExpensesCommonViewScreen> createState() =>
      _ShowExpensesCommonViewScreenState();
}

class _ShowExpensesCommonViewScreenState
    extends State<ShowExpensesCommonViewScreen> {
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
      appBar: AppBarView(
        title: MediaQuery.of(context).size.width >= 900 ? "" : "Expenses",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: MediaQuery.of(context).size.width >= 900
            ? AppColors.backgroundColor
            : AppColors.primaryColor,
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width >= 900 ? false : true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Center(
        child: Container(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All expenses",
                      style: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.filter_list,
                      size: 27,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => transactionController.expensesList.isEmpty
                      ? Lottie.asset(
                          "assets/lottie/no_internet.json",
                          height: MediaQuery.of(context).size.height / 5,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: transactionController.expensesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          AppColors.backgroundColor,
                                      content: Container(
                                        height: MediaQuery.of(context)
                                                    .size
                                                    .width >=
                                                900
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.4
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                        width:
                                            MediaQuery.of(context).size.width >=
                                                    900
                                                ? 250
                                                : null,
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
                                                        BorderRadius.circular(
                                                            16),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .primaryColor),
                                                    image: DecorationImage(
                                                      image: Image.network(
                                                        transactionController
                                                                .expensesList[
                                                            index]["image"],
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
                                                            .expensesList[index]
                                                        ["title"],
                                                    style: AppTextStyle
                                                        .regularTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                            .expensesList[index]
                                                        ["subTitle"],
                                                    style: AppTextStyle
                                                        .regularTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                        "${transactionController.expensesList[index]["type"] == "income" ? "+" : "-"} ₹${transactionController.expensesList[index]["amount"]}",
                                                    style: AppTextStyle
                                                        .regularTextStyle
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: transactionController
                                                                      .expensesList[
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
                                                            .expensesList[index]
                                                        ["payment"],
                                                    style: AppTextStyle
                                                        .regularTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                            .expensesList[index]
                                                        ["date"],
                                                    style: AppTextStyle
                                                        .regularTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                            .expensesList[index]
                                                        ["time"],
                                                    style: AppTextStyle
                                                        .regularTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                  color:
                                      AppColors.primaryColor.withOpacity(0.06),
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
                                                  color:
                                                      AppColors.primaryColor),
                                              image: DecorationImage(
                                                image: Image.network(
                                                  transactionController
                                                          .expensesList[index]
                                                      ["image"],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transactionController
                                                .expensesList[index]["title"],
                                            style: AppTextStyle.regularTextStyle
                                                .copyWith(fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            transactionController
                                                    .expensesList[index]
                                                ["subTitle"],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "- ₹${transactionController.expensesList[index]["amount"]}",
                                            style: AppTextStyle.regularTextStyle
                                                .copyWith(
                                              color: AppColors.redColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            transactionController
                                                .expensesList[index]["time"],
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
