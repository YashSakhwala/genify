// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../controller/transaction_controller.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../../widgets/common_widgets/empty_view.dart';
import '../../edit_details/edit_details_screen.dart';

class ShowIncomeCommonViewScreen extends StatefulWidget {
  const ShowIncomeCommonViewScreen({super.key});

  @override
  State<ShowIncomeCommonViewScreen> createState() =>
      _ShowIncomeCommonViewScreenState();
}

class _ShowIncomeCommonViewScreenState
    extends State<ShowIncomeCommonViewScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: "Incomes",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Obx(
        () => transactionController.isLoader.value == true
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(13),
                child: transactionController.combinedList.isEmpty
                    ? Center(child: EmptyView())
                    : transactionController.incomeEntries.isEmpty
                        ? Center(child: EmptyView())
                        : ListView(
                            children: [
                              Text(
                                transactionController.todayIncomeList.isEmpty
                                    ? ""
                                    : "Spend Frequency",
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: transactionController
                                        .todayIncomeList.isEmpty
                                    ? 0
                                    : 13,
                              ),
                              transactionController.todayIncomeList.isEmpty
                                  ? Container()
                                  : SfSparkLineChart(
                                      color: AppColors.primaryColor,
                                      axisLineColor: AppColors.greyColor,
                                      axisLineDashArray: [1.5, 7],
                                      trackball: SparkChartTrackball(
                                        activationMode:
                                            SparkChartActivationMode.tap,
                                        color: AppColors.greyColor,
                                      ),
                                      labelDisplayMode:
                                          SparkChartLabelDisplayMode.all,
                                      labelStyle: AppTextStyle.smallTextStyle
                                          .copyWith(fontSize: 10),
                                      marker: SparkChartMarker(
                                          displayMode:
                                              SparkChartMarkerDisplayMode.all),
                                      data: transactionController
                                          .incomeAmountsList,
                                    ),
                              SizedBox(
                                height: transactionController
                                        .todayIncomeList.isEmpty
                                    ? 0
                                    : 20,
                              ),
                              Text(
                                "All Incomes",
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    transactionController.incomeEntries.length,
                                itemBuilder: (context, index) {
                                  List allData = transactionController
                                      .incomeEntries[index].value;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          transactionController
                                              .incomeEntries[index].key,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: allData.length,
                                        itemBuilder: (context, allDataIndex) {
                                          return InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor: AppColors
                                                        .backgroundColor,
                                                    content: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              2,
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
                                                                        color: AppColors
                                                                            .primaryColor),
                                                                    image:
                                                                        DecorationImage(
                                                                      image: Image
                                                                          .network(
                                                                        allData[allDataIndex]["image"] ==
                                                                                ""
                                                                            ? allData[allDataIndex]["type"] == "Incomes"
                                                                                ? AppImages.incomeImage
                                                                                : AppImages.expensesImage
                                                                            : allData[allDataIndex]["image"],
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
                                                                            fontSize:
                                                                                14),
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
                                                                            fontSize:
                                                                                14),
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
                                                                          ? AppColors
                                                                              .greenColor
                                                                          : AppColors
                                                                              .redColor,
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
                                                                            fontSize:
                                                                                14),
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
                                                                            fontSize:
                                                                                14),
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
                                                                            fontSize:
                                                                                14),
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
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15),
                                              child: Slidable(
                                                endActionPane: ActionPane(
                                                  motion: ScrollMotion(),
                                                  children: [
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    CustomSlidableAction(
                                                      backgroundColor:
                                                          AppColors.greenColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                      foregroundColor:
                                                          AppColors.whiteColor,
                                                      onPressed:
                                                          (BuildContext con) {
                                                        Navigator.of(context)
                                                            .pushReplacement(
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
                                                            image: allData[allDataIndex]
                                                                        [
                                                                        "image"] ==
                                                                    ""
                                                                ? allData[allDataIndex]
                                                                            [
                                                                            "type"] ==
                                                                        "Incomes"
                                                                    ? AppImages
                                                                        .incomeImage
                                                                    : AppImages
                                                                        .expensesImage
                                                                : allData[
                                                                        allDataIndex]
                                                                    ["image"],
                                                            uniqueTime: allData[
                                                                    allDataIndex]
                                                                ["uniqueTime"],
                                                          ),
                                                        ));
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.edit,
                                                            size: 27,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "Edit",
                                                            style: AppTextStyle
                                                                .smallTextStyle
                                                                .copyWith(
                                                              fontSize: 9,
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    CustomSlidableAction(
                                                      backgroundColor: AppColors
                                                          .redColor.shade400,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                      foregroundColor:
                                                          AppColors.whiteColor,
                                                      onPressed:
                                                          (BuildContext con) {
                                                        transactionController
                                                            .removeTransactionData(
                                                          uniqueTime: allData[
                                                                  allDataIndex]
                                                              ["uniqueTime"],
                                                          context: context,
                                                        );
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.delete,
                                                            size: 27,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "Delete",
                                                            style: AppTextStyle
                                                                .smallTextStyle
                                                                .copyWith(
                                                              fontSize: 9,
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                  ],
                                                ),
                                                child: FlipInX(
                                                  child: Container(
                                                    height: 89,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .primaryColor
                                                          .withOpacity(0.06),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 17,
                                                          vertical: 14),
                                                      child: Row(
                                                        children: [
                                                          Stack(
                                                            alignment: Alignment
                                                                .center,
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
                                                                      allData[allDataIndex]["image"] ==
                                                                              ""
                                                                          ? allData[allDataIndex]["type"] == "Incomes"
                                                                              ? AppImages.incomeImage
                                                                              : AppImages.expensesImage
                                                                          : allData[allDataIndex]["image"],
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
                                                                      ['title'],
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
                                                                      [
                                                                      'subTitle'],
                                                                  style: AppTextStyle
                                                                      .regularTextStyle
                                                                      .copyWith(
                                                                    fontSize:
                                                                        12,
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
                                                                  "${allData[allDataIndex]['type'] == 'Incomes' ? '+' : '-'} ₹${allData[allDataIndex]['amount']}",
                                                                  style: AppTextStyle
                                                                      .regularTextStyle
                                                                      .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: allData[allDataIndex]['type'] ==
                                                                            'Incomes'
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
                                                                      ['time'],
                                                                  style: AppTextStyle
                                                                      .regularTextStyle
                                                                      .copyWith(
                                                                    fontSize:
                                                                        13,
                                                                    color: AppColors
                                                                        .greyColor,
                                                                  ),
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
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
              ),
      ),
    );
  }
}
