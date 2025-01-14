// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, sized_box_for_whitespace

import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../config/app_style.dart';
import '../../../controller/transaction_controller.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';
import "package:universal_html/html.dart" as html;

class EditDetailsCommonViewScreen extends StatefulWidget {
  final String type;
  final String amount;
  final String title;
  final String subtitle;
  final String wallet;
  final String date;
  final String time;
  final String image;
  final String uniqueNumber;
  final String timeType;

  const EditDetailsCommonViewScreen({
    super.key,
    required this.type,
    required this.amount,
    required this.title,
    required this.subtitle,
    required this.wallet,
    required this.image,
    required this.uniqueNumber,
    required this.date,
    required this.time,
    required this.timeType,
  });

  @override
  State<EditDetailsCommonViewScreen> createState() =>
      _EditDetailsCommonViewScreenState();
}

class _EditDetailsCommonViewScreenState
    extends State<EditDetailsCommonViewScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());

  final TextEditingController amount = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController subTitle = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  List timeValue = ["Old Real-Time", "New Real-Time", "Manually"];

  String wallet = "";
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

  List<String> expenseList = [
    "Fixed Expenses",
    "Rent/Mortgage",
    "Utilities",
    "Internet/Phone bills",
    "Insurance",
    "Loan Payments",
    "Subscription Services",
    "Taxes",
    "Variable Expenses",
    "Groceries",
    "Transportation",
    "Dining Out",
    "Entertainment",
    "Shopping",
    "Healthcare",
    "Education",
    "Childcare",
    "Personal Care",
    "Travel & Vacation",
    "Gifts & Donations",
    "Pet Expenses",
    "Miscellaneous Expenses",
    "Emergency Fund",
    "Miscellaneous"
  ];

  @override
  void initState() {
    amount.text = widget.amount;
    title.text = widget.title;
    subTitle.text = widget.subtitle;
    wallet = widget.wallet;
    dateController.text = widget.date;
    timeController.text = widget.time;

    widget.timeType == "RealTime"
        ? transactionController.timeValue.value = 1
        : transactionController.timeValue.value = 3;

    transactionController.imagePath.value = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.type == "Incomes" ? AppColors.greenColor : AppColors.redColor,
      appBar: AppBarView(
        title: widget.type,
        style: AppTextStyle.regularTextStyle.copyWith(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: widget.type == "Incomes"
            ? AppColors.greenColor
            : AppColors.redColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          fontSize: 50,
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
                          cursorHeight: 50,
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 50,
                            color: AppColors.whiteColor,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "0",
                            hintStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 50,
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
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: FlipInX(
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
                                transactionController.webImageFile.value = file;
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
                          () => Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: AppColors.primaryColor,
                                strokeWidth: 2,
                              ),
                              Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: AppColors.greyColor),
                                  image: DecorationImage(
                                    image: transactionController
                                            .imagePath.value.isNotEmpty
                                        ? kIsWeb
                                            ? Image.network(
                                                transactionController
                                                    .imagePath.value,
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.cover,
                                              ).image
                                            : Image.file(
                                                File(transactionController
                                                    .imagePath.value),
                                                height: 120,
                                                width: 120,
                                                fit: BoxFit.cover,
                                              ).image
                                        : Image.network(
                                            widget.image,
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ).image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFieldView(
                        title: "",
                        controller: title,
                        vertical: 18,
                        hintText: "Category",
                        isDropDownItem: true,
                        dropdownItems:
                            widget.type == "Incomes" ? incomeList : expenseList,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFieldView(
                        title: "",
                        controller: subTitle,
                        vertical: 18,
                        hintText: "Description",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      DropdownButtonFormField(
                        value: wallet,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.greyColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.greyColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.greyColor),
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
                        height: 16,
                      ),
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            transactionController.timeValue.value == 3
                                ? Row(
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
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        child: TextFieldView(
                                          title: "",
                                          controller: dateController,
                                          vertical: 15,
                                          readOnly: true,
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
                                          vertical: 15,
                                          readOnly: true,
                                          suffixIcon:
                                              Icon(Icons.access_time_rounded),
                                        ),
                                      ),
                                    ],
                                  ),

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
                                          transactionController
                                              .timeValue.value = index + 1;
                                        },
                                        child: Row(
                                          children: [
                                            Radio(
                                              fillColor: MaterialStateColor
                                                  .resolveWith(
                                                (states) =>
                                                    transactionController
                                                                .timeValue
                                                                .value ==
                                                            index + 1
                                                        ? AppColors.primaryColor
                                                        : AppColors.greyColor,
                                              ),
                                              value: index + 1,
                                              groupValue: transactionController
                                                  .timeValue.value,
                                              onChanged: (value) {
                                                transactionController
                                                    .timeValue.value = value!;
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
                      SizedBox(
                        height: 100,
                      ),
                      ButtonView(
                        height: 50,
                        title: "Save changes",
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          if (amount.text.isEmpty ||
                              title.text.isEmpty ||
                              subTitle.text.isEmpty) {
                            toastView(
                              msg: "Please enter details",
                              context: context,
                            );
                          } else {
                            DateTime now = DateTime.now();
                            String realDate =
                                DateFormat('dd-MM-yyyy').format(DateTime.now());
                            String realTime =
                                DateFormat("hh:mm:ss a").format(now);

                            String timeType =
                                transactionController.timeValue.value == 1
                                    ? "RealTime"
                                    : transactionController.timeValue.value == 2
                                        ? "RealTime"
                                        : "Manual";

                            // Real time issue----------------
                            if (transactionController.timeValue.value == 1) {
                              transactionController.updateTransactionData(
                                amount: amount.text,
                                title: title.text,
                                subTitle: subTitle.text,
                                payment: wallet,
                                image: widget.image,
                                uniqueNumber: widget.uniqueNumber,
                                date: dateController.text,
                                time: timeController.text,
                                timeType: timeType,
                                context: context,
                              );
                            } else if (transactionController.timeValue.value ==
                                2) {
                              transactionController.updateTransactionData(
                                amount: amount.text,
                                title: title.text,
                                subTitle: subTitle.text,
                                payment: wallet,
                                image: widget.image,
                                uniqueNumber: widget.uniqueNumber,
                                date: realDate,
                                time: realTime,
                                timeType: timeType,
                                context: context,
                              );
                            } else {
                              transactionController.updateTransactionData(
                                amount: amount.text,
                                title: title.text,
                                subTitle: subTitle.text,
                                payment: wallet,
                                image: widget.image,
                                uniqueNumber: widget.uniqueNumber,
                                date: dateController.text,
                                time: timeController.text,
                                timeType: timeType,
                                context: context,
                              );
                            }
                          }
                        },
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
