// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../controller/transaction_controller.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../../widgets/common_widgets/empty_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../edit_details/edit_details_screen.dart';

class WebShowIncomeScreen extends StatefulWidget {
  const WebShowIncomeScreen({super.key});

  @override
  State<WebShowIncomeScreen> createState() => _WebShowIncomeScreenState();
}

class _WebShowIncomeScreenState extends State<WebShowIncomeScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());

  String? hoveredIndex;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    transactionController.filteredData.value = [];

    transactionController.filteredData.value =
        List.from(transactionController.incomeEntries);
    transactionController.isSearching.value = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(
        title: "",
        automaticallyImplyLeading: false,
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
                                  : Container(
                                      height: 170,
                                      child: SfSparkLineChart(
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
                                                SparkChartMarkerDisplayMode
                                                    .all),
                                        data: transactionController
                                            .incomeAmountsList,
                                      ),
                                    ),
                              SizedBox(
                                height: transactionController
                                        .todayIncomeList.isEmpty
                                    ? 0
                                    : 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (!transactionController.isSearching.value)
                                    Text(
                                      "All Incomes",
                                      style: AppTextStyle.regularTextStyle
                                          .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  if (transactionController.isSearching.value)
                                    Expanded(
                                      child: TextFieldView(
                                        title: "",
                                        controller: searchController,
                                        autofocus: true,
                                        hintText: 'Search Incomes',
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            transactionController
                                                    .filteredData.value =
                                                List.from(transactionController
                                                    .incomeEntries);
                                          } else {
                                            transactionController
                                                    .filteredData.value =
                                                transactionController
                                                    .incomeEntries
                                                    .map((entry) {
                                                      final filteredValues =
                                                          entry.value
                                                              .where((map) {
                                                        return map['title'].toString().toLowerCase().startsWith(value.toLowerCase()) ||
                                                            map['subTitle']
                                                                .toString()
                                                                .toLowerCase()
                                                                .startsWith(value
                                                                    .toLowerCase()) ||
                                                            map['payment']
                                                                .toString()
                                                                .toLowerCase()
                                                                .startsWith(value
                                                                    .toLowerCase()) ||
                                                            map['amount']
                                                                .toString()
                                                                .toLowerCase()
                                                                .startsWith(value
                                                                    .toLowerCase());
                                                      }).toList();

                                                      return filteredValues
                                                              .isNotEmpty
                                                          ? MapEntry(
                                                              entry.key
                                                                  .toString(),
                                                              filteredValues)
                                                          : null;
                                                    })
                                                    .where((entry) =>
                                                        entry != null)
                                                    .cast()
                                                    .toList();
                                          }
                                        },
                                      ),
                                    ),
                                  IconButton(
                                    icon: Icon(
                                        transactionController.isSearching.value
                                            ? Icons.close
                                            : Icons.search),
                                    onPressed: () {
                                      transactionController.isSearching.value =
                                          !transactionController
                                              .isSearching.value;
                                      if (!transactionController
                                          .isSearching.value) {
                                        searchController.clear();
                                        transactionController
                                                .filteredData.value =
                                            List.from(transactionController
                                                .incomeEntries);
                                      }
                                    },
                                  ),
                                  if (!transactionController.isSearching.value)
                                    PopupMenuButton(
                                      color: AppColors.dropDownColor,
                                      icon: Icon(Icons.filter_alt),
                                      onSelected: (filter) {
                                        List originalData = List.from(
                                            transactionController
                                                .incomeEntries);

                                        transactionController.filteredData
                                            .value = originalData.map((entry) {
                                          List sortedValues;
                                          switch (filter) {
                                            case 'A to Z':
                                              sortedValues = List.from(
                                                  entry.value)
                                                ..sort((a, b) => a['title']
                                                    .toString()
                                                    .compareTo(
                                                        b['title'].toString()));
                                              break;
                                            case 'Z to A':
                                              sortedValues = List.from(
                                                  entry.value)
                                                ..sort((a, b) => b['title']
                                                    .toString()
                                                    .compareTo(
                                                        a['title'].toString()));
                                              break;
                                            case '0 to 9':
                                              sortedValues = List.from(
                                                  entry.value)
                                                ..sort((a, b) => a['amount']
                                                    .compareTo(b['amount']));
                                              break;
                                            case '9 to 0':
                                              sortedValues = List.from(
                                                  entry.value)
                                                ..sort((a, b) => b['amount']
                                                    .compareTo(a['amount']));
                                              break;
                                            default:
                                              sortedValues =
                                                  List.from(entry.value);
                                              break;
                                          }
                                          return MapEntry(
                                              entry.key, sortedValues);
                                        }).toList();
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                            value: 'A to Z',
                                            child: Text('A to Z')),
                                        PopupMenuItem(
                                            value: 'Z to A',
                                            child: Text('Z to A')),
                                        PopupMenuItem(
                                            value: '0 to 9',
                                            child: Text('0 to 9')),
                                        PopupMenuItem(
                                            value: '9 to 0',
                                            child: Text('9 to 0')),
                                      ],
                                    )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    transactionController.filteredData.length,
                                itemBuilder: (context, index) {
                                  List allData = transactionController
                                      .filteredData[index].value;

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
                                      GridView.builder(
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
                                                hoveredIndex =
                                                    allData[allDataIndex]
                                                            ["uniqueNumber"]
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
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              AppColors
                                                                  .backgroundColor,
                                                          content: Container(
                                                            width: 250,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16),
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
                                                                        height:
                                                                            200,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(16),
                                                                          border:
                                                                              Border.all(color: AppColors.primaryColor),
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                Image.network(
                                                                              allData[allDataIndex]["image"] == ""
                                                                                  ? allData[allDataIndex]["type"] == "Incomes"
                                                                                      ? AppImages.incomeImage
                                                                                      : AppImages.expensesImage
                                                                                  : allData[allDataIndex]["image"],
                                                                            ).image,
                                                                            fit:
                                                                                BoxFit.cover,
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
                                                                            .copyWith(fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          allData[allDataIndex]
                                                                              [
                                                                              "title"],
                                                                          style: AppTextStyle
                                                                              .regularTextStyle
                                                                              .copyWith(fontSize: 14),
                                                                          textAlign:
                                                                              TextAlign.end,
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
                                                                            .copyWith(fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          allData[allDataIndex]
                                                                              [
                                                                              "subTitle"],
                                                                          style: AppTextStyle
                                                                              .regularTextStyle
                                                                              .copyWith(fontSize: 14),
                                                                          textAlign:
                                                                              TextAlign.end,
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
                                                                            .copyWith(fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          "${allData[allDataIndex]["type"] == "Incomes" ? "+" : "-"} ₹${allData[allDataIndex]["amount"]}",
                                                                          style: AppTextStyle
                                                                              .regularTextStyle
                                                                              .copyWith(
                                                                            fontSize:
                                                                                14,
                                                                            color: allData[allDataIndex]["type"] == "Incomes"
                                                                                ? AppColors.greenColor
                                                                                : AppColors.redColor,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.end,
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
                                                                            .copyWith(fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          allData[allDataIndex]
                                                                              [
                                                                              "payment"],
                                                                          style: AppTextStyle
                                                                              .regularTextStyle
                                                                              .copyWith(fontSize: 14),
                                                                          textAlign:
                                                                              TextAlign.end,
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
                                                                            .copyWith(fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          allData[allDataIndex]
                                                                              [
                                                                              "date"],
                                                                          style: AppTextStyle
                                                                              .regularTextStyle
                                                                              .copyWith(fontSize: 14),
                                                                          textAlign:
                                                                              TextAlign.end,
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
                                                                            .copyWith(fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          allData[allDataIndex]
                                                                              [
                                                                              "time"],
                                                                          style: AppTextStyle
                                                                              .regularTextStyle
                                                                              .copyWith(fontSize: 14),
                                                                          textAlign:
                                                                              TextAlign.end,
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
                                                  child: FlipInX(
                                                    child: Container(
                                                      margin: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryColor
                                                            .withOpacity(0.06),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 17,
                                                                vertical: 14),
                                                        child: Row(
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
                                                                  height: 60,
                                                                  width: 60,
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
                                                                        [
                                                                        "title"],
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
                                                                        "subTitle"],
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
                                                                    "${allData[allDataIndex]["type"] == "Incomes" ? "+" : "-"} ₹${allData[allDataIndex]["amount"]}",
                                                                    style: AppTextStyle
                                                                        .regularTextStyle
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: allData[allDataIndex]["type"] ==
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
                                                                        [
                                                                        "time"],
                                                                    style: AppTextStyle
                                                                        .regularTextStyle
                                                                        .copyWith(
                                                                      fontSize:
                                                                          13,
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
                                                ),
                                                if (hoveredIndex ==
                                                    allData[allDataIndex]
                                                            ["uniqueNumber"]
                                                        .toString())
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      width: 50,
                                                      margin: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                      MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditDetailsScreen(
                                                                  type: allData[
                                                                          allDataIndex]
                                                                      ["type"],
                                                                  amount: allData[
                                                                          allDataIndex]
                                                                      [
                                                                      "amount"],
                                                                  title: allData[
                                                                          allDataIndex]
                                                                      ["title"],
                                                                  subtitle: allData[
                                                                          allDataIndex]
                                                                      [
                                                                      "subTitle"],
                                                                  wallet: allData[
                                                                          allDataIndex]
                                                                      [
                                                                      "payment"],
                                                                  image: allData[allDataIndex]
                                                                              [
                                                                              "image"] ==
                                                                          ""
                                                                      ? allData[allDataIndex]["type"] ==
                                                                              "Incomes"
                                                                          ? AppImages
                                                                              .incomeImage
                                                                          : AppImages
                                                                              .expensesImage
                                                                      : allData[
                                                                              allDataIndex]
                                                                          [
                                                                          "image"],
                                                                  uniqueNumber:
                                                                      allData[allDataIndex]
                                                                          [
                                                                          "uniqueNumber"],
                                                                  date: allData[
                                                                          allDataIndex]
                                                                      ["date"],
                                                                  time: allData[
                                                                          allDataIndex]
                                                                      ["time"],
                                                                  timeType: allData[
                                                                          allDataIndex]
                                                                      [
                                                                      "timeType"],
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
                                                              margin: EdgeInsets
                                                                  .all(3),
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
                                                                uniqueNumber: allData[
                                                                        allDataIndex]
                                                                    [
                                                                    "uniqueNumber"],
                                                                context:
                                                                    context,
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
                                                              margin: EdgeInsets
                                                                  .all(3),
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
