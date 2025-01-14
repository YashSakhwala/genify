// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, deprecated_member_use

import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../controller/transaction_controller.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';
import "package:universal_html/html.dart" as html;

class WebAddIncomeScreen extends StatefulWidget {
  const WebAddIncomeScreen({super.key});

  @override
  State<WebAddIncomeScreen> createState() => _WebAddIncomeScreenState();
}

class _WebAddIncomeScreenState extends State<WebAddIncomeScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());

  final TextEditingController amount = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController subTitle = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  List timeValue = ["Real-Time", "Manually"];

  String wallet = "Google pay";
  List walletList = [
    "Cash",
    "Google pay",
    "Phone pay",
    "Paytm",
    "BHIM",
    "Paypal",
    "Net banking",
    "Credit card",
    "Debit card",
  ];

  List<String> incomeList = [
    "Salary/Wages",
    "Monthly Salary",
    "Bonus",
    "Overtime Pay",
    "Commission",
    "Side Income",
    "Freelance Work",
    "Online Business",
    "Investments",
    "Rental Income",
    "Royalties",
    "Other Income",
    "Gifts",
    "Tax Refunds",
    "Scholarships/Grants",
    "Pensions/Retirement Benefits",
    "Stipends",
    "Government Assistance",
    "Sale of Assets",
    "Selling Property, Car, or Electronics",
    "Selling Personal Items",
    "Other Sources",
    "Crowdfunding",
    "Loans or Borrowing",
    "Windfalls"
  ];

  @override
  void initState() {
    transactionController.imagePath.value = "";

    transactionController.timeValue.value = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Incomes",
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 30,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: 85,
                  ),
                  Text(
                    "How Much?",
                    style: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "₹ ",
                        style: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 27,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Expanded(
                        child: TextFieldView(
                          title: "",
                          controller: amount,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9\.]')),
                          ],
                          cursorHeight: 27,
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 27,
                            color: AppColors.whiteColor,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "0",
                            hintStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 27,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 170, vertical: 30),
                child: FlipInX(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                if (kIsWeb) {
                                  html.FileUploadInputElement uploadInput =
                                      html.FileUploadInputElement();
                                  uploadInput.accept = 'image/*';
                                  uploadInput.click();

                                  uploadInput.onChange.listen((event) {
                                    final file = uploadInput.files!.first;
                                    final reader = html.FileReader();

                                    reader.readAsDataUrl(file);
                                    reader.onLoadEnd.listen((event) {
                                      transactionController.webImageFile.value =
                                          file;
                                      transactionController.imagePath.value =
                                          reader.result as String;
                                    });
                                  });
                                } else {
                                  ImagePicker imagePicker = ImagePicker();

                                  XFile? xFile = await imagePicker.pickImage(
                                      source: ImageSource.gallery);

                                  if (xFile != null && xFile.path.isNotEmpty) {
                                    transactionController.imagePath.value =
                                        xFile.path;
                                  }
                                }
                              },
                              child: Obx(
                                () => Container(
                                  height: 370,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: AppColors.greyColor),
                                    color: AppColors.greyColor.shade300,
                                    image: DecorationImage(
                                      image: transactionController
                                              .imagePath.value.isEmpty
                                          ? Image.asset(
                                              AppImages.addImage,
                                              color:
                                                  AppColors.greyColor.shade300,
                                              scale: 15,
                                            ).image
                                          : kIsWeb
                                              ? Image.network(
                                                  transactionController
                                                      .imagePath.value,
                                                ).image
                                              : Image.file(
                                                  File(transactionController
                                                      .imagePath.value),
                                                ).image,
                                      fit: transactionController
                                              .imagePath.value.isEmpty
                                          ? BoxFit.scaleDown
                                          : BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TextFieldView(
                              title: "",
                              controller: title,
                              vertical: 18,
                              hintText: "Category",
                              isDropDownItem: true,
                              dropdownItems: incomeList,
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            TextFieldView(
                              title: "",
                              controller: subTitle,
                              vertical: 18,
                              hintText: "Description",
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            DropdownButtonFormField(
                              value: wallet,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: AppColors.greyColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: AppColors.greyColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: AppColors.greyColor),
                                ),
                                filled: true,
                                fillColor: AppColors.whiteColor,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.greyColor,
                              ),
                              items: walletList.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  wallet = newValue!;
                                });
                              },
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (transactionController.timeValue.value ==
                                      2)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFieldView(
                                            title: "",
                                            controller: dateController,
                                            onTap: () async {
                                              final DateTime? selectedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime.now(),
                                              );

                                              dateController.text =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(selectedDate!);
                                            },
                                            vertical: 15,
                                            readOnly: true,
                                            hintText: "Select Date",
                                            suffixIcon:
                                                Icon(Icons.date_range_rounded),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: TextFieldView(
                                            title: "",
                                            controller: timeController,
                                            onTap: () async {
                                              TimeOfDay? timeOfDay =
                                                  await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now());

                                              if (timeOfDay != null) {
                                                timeController.text =
                                                    DateFormat('hh:mm:ss a')
                                                        .format(
                                                  DateTime(
                                                      0,
                                                      1,
                                                      1,
                                                      timeOfDay.hour,
                                                      timeOfDay.minute),
                                                );
                                              }
                                            },
                                            vertical: 15,
                                            readOnly: true,
                                            hintText: "Select Time",
                                            suffixIcon:
                                                Icon(Icons.access_time_rounded),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (transactionController.timeValue.value ==
                                      2)
                                    SizedBox(
                                      height: 10,
                                    ),

                                  // Time Selection
                                  Container(
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: timeValue.length,
                                        itemBuilder: (context, index) {
                                          return Obx(
                                            () => GestureDetector(
                                              onTap: () {
                                                transactionController.timeValue
                                                    .value = index + 1;

                                                if (timeValue[index] ==
                                                    "Manually") {
                                                  dateController.text = "";
                                                  timeController.text = "";
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  Radio(
                                                    fillColor:
                                                        MaterialStateColor
                                                            .resolveWith(
                                                      (states) =>
                                                          transactionController
                                                                      .timeValue
                                                                      .value ==
                                                                  index + 1
                                                              ? AppColors
                                                                  .primaryColor
                                                              : AppColors
                                                                  .greyColor,
                                                    ),
                                                    value: index + 1,
                                                    groupValue:
                                                        transactionController
                                                            .timeValue.value,
                                                    onChanged: (value) {
                                                      transactionController
                                                          .timeValue
                                                          .value = value!;
                                                    },
                                                  ),
                                                  Text(
                                                    timeValue[index],
                                                    style: AppTextStyle
                                                        .regularTextStyle
                                                        .copyWith(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                            ),
                            ButtonView(
                              height: 50,
                              title: "Continue",
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                if (amount.text.isEmpty ||
                                    title.text.isEmpty ||
                                    subTitle.text.isEmpty ||
                                    transactionController.timeValue.value ==
                                        0) {
                                  toastView(
                                    msg: "Please fill all details",
                                    context: context,
                                  );
                                } else {
                                  if (transactionController
                                      .imagePath.value.isEmpty) {
                                    transactionController.imagePath.value = "";
                                  }

                                  DateTime now = DateTime.now();
                                  String realDate = DateFormat('dd-MM-yyyy')
                                      .format(DateTime.now());
                                  String realTime =
                                      DateFormat("hh:mm:ss a").format(now);

                                  String timeType =
                                      transactionController.timeValue.value == 1
                                          ? "RealTime"
                                          : "Manual";

                                  if (transactionController.timeValue.value ==
                                      1) {
                                    transactionController.AllTransaction(
                                      amount: amount.text,
                                      title: title.text,
                                      subTitle: subTitle.text,
                                      payment: wallet,
                                      date: realDate,
                                      time: realTime,
                                      context: context,
                                      type: "Incomes",
                                      timeType: timeType,
                                    );
                                  } else {
                                    if (dateController.text.isEmpty ||
                                        timeController.text.isEmpty) {
                                      toastView(
                                        msg: "Please fill date/time",
                                        context: context,
                                      );
                                    } else {
                                      transactionController.AllTransaction(
                                        amount: amount.text,
                                        title: title.text,
                                        subTitle: subTitle.text,
                                        payment: wallet,
                                        date: dateController.text,
                                        time: timeController.text,
                                        context: context,
                                        type: "Incomes",
                                        timeType: timeType,
                                      );
                                    }
                                  }
                                }
                              },
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
      ),
    );
  }
}
