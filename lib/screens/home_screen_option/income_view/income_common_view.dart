// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unnecessary_to_list_in_spreads, sized_box_for_whitespace, deprecated_member_use

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/widgets/common_widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../controller/income_controller.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';
import 'income_make_function.dart';

class IncomeCommonViewScreen extends StatefulWidget {
  const IncomeCommonViewScreen({super.key});

  @override
  State<IncomeCommonViewScreen> createState() => _IncomeCommonViewScreenState();
}

class _IncomeCommonViewScreenState extends State<IncomeCommonViewScreen> {
  IncomeController incomeController = Get.put(IncomeController());

  final TextEditingController companyName = TextEditingController();
  final TextEditingController gstNo = TextEditingController();
  final TextEditingController companyEmail = TextEditingController();
  final TextEditingController companyPhoneNo = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController tax = TextEditingController();

  final List<Map<String, TextEditingController>> revenues = [];
  final List<Map<String, TextEditingController>> cgs = []; //Cost of Goods Sold
  final List<Map<String, TextEditingController>> expenses = [];
  final List<Map<String, TextEditingController>> otherIncomes = [];
  final List<Map<String, TextEditingController>> otherExpenses = [];

  List dateValue = ["Month", "Year"];
  List taxValue = ["Tax Percentage", "Tax Amount"];

  final GlobalKey<FormState> _formKey = GlobalKey();

  List<String> revenuesList = [
    "Product Sales",
    "Service Income",
    "Interest Income",
    "Rental Income",
    "Consulting Fees",
    "Commission Income",
    "Dividend Income",
    "Advertising Revenue",
    "Royalties",
    "Subscription Revenue",
    "Licensing Income",
    "Franchise Fees",
    "Government Grants and Subsidies",
    "Sponsorship Income",
    "Affiliate or Referral Income",
    "Miscellaneous Income",
  ];

  List<String> cogsList = [
    "Raw Materials",
    "Direct Labor",
    "Manufacturing Overhead",
    "Freight Costs",
    "Packaging Costs",
    "Factory Supplies",
    "Equipment Maintenance",
    "Utilities for Production",
    "Inventory Adjustments",
    "Product-Specific Wastage",
    "Subcontracting Costs",
    "Quality Control Expenses",
  ];

  List<String> expensesList = [
    // Operational Expenses
    "Rent Expense",
    "Salaries and Wages",
    "Utilities",
    "Office Supplies",
    "Repairs and Maintenance",
    "Marketing and Advertising",
    "Software Subscriptions",
    "Travel Expenses",
    "Bank Charges",

    // Administrative Expenses
    "Legal and Professional Fees",
    "Accounting Fees",
    "Insurance",
    "Depreciation and Amortization",
    "Employee Benefits",

    // Selling Expenses
    "Sales Commissions",
    "Promotional Events",
    "Shipping Costs",

    // Financial Expenses
    "Loan Interest",
    "Credit Card Fees",
    "Bad Debt Expense",

    // Miscellaneous Expenses
    "Donations and Contributions",
    "Training and Development",
    "Entertainment Expenses",
    "Subscriptions to Industry Publications",
  ];

  List<String> otherIncomesList = [
    "Dividend Income",
    "Interest from Investments",
    "Gains on Sale of Assets",
    "Unrealized Gains on Investments",
    "Tax Refunds",
    "Recovery of Bad Debts",
    "Write-Back of Provisions",
    "Sale of Scrap Material",
    "Foreign Exchange Gain",
    "Sponsorship Revenue",
    "Affiliate or Referral Income",
    "Miscellaneous Income",
  ];

  List<String> otherExpensesList = [
    // Non-Recurring
    "Loss on Sale of Assets",
    "Fines and Penalties",
    "Legal Settlements",
    "Write-Offs of Bad Debts",
    "Obsolete Inventory Write-Off",

    // Investment-Related
    "Loss on Investments",
    "Unrealized Losses on Investments",
    "Brokerage and Commission Fees",

    // Foreign Exchange
    "Foreign Exchange Loss",
    "Currency Conversion Fees",

    // Miscellaneous
    "Donations and Charity",
    "Unplanned Repairs or Emergency Maintenance",
    "Bank Overdraft Fees",
    "Late Payment Charges",
  ];

  @override
  void initState() {
    IncomeMake.imagePath = "";
    IncomeMake.signatureImagePath = "";

    incomeController.dateValue.value = 0;
    incomeController.taxValue.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: "Income Statement",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: FlipInX(
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.greyColor.shade300,
                        image: DecorationImage(
                          image: IncomeMake.imagePath.isEmpty
                              ? Image.asset(
                                  AppImages.addImage,
                                  color: AppColors.greyColor.shade300,
                                  scale: 12,
                                ).image
                              : Image.file(
                                  File(IncomeMake.imagePath),
                                ).image,
                          fit: IncomeMake.imagePath.isEmpty
                              ? BoxFit.scaleDown
                              : BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Company Logo",
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Some companies require income statement without logo, so check before adding one.",
                              style: AppTextStyle.regularTextStyle
                                  .copyWith(fontSize: 9),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                ImagePicker imagePicker = ImagePicker();

                                XFile? xFile = await imagePicker.pickImage(
                                    source: ImageSource.gallery);

                                if (xFile != null && xFile.path.isNotEmpty) {
                                  IncomeMake.imagePath = xFile.path;
                                }

                                setState(() {});
                              },
                              child: Container(
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Upload Logo",
                                    style:
                                        AppTextStyle.regularTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
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
                SizedBox(
                  height: 40,
                ),
                TextFieldView(
                  title: "Company Name",
                  titleStyle: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: companyName,
                  hintText: "MD Pharma",
                  isCompulsory: true,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldView(
                  title: "GST Number",
                  titleStyle: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: gstNo,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Z]')),
                    LengthLimitingTextInputFormatter(15),
                  ],
                  hintText: "12ABCDE3456F",
                  isCompulsory: true,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldView(
                  title: "Email",
                  titleStyle: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: companyEmail,
                  keyboardType: TextInputType.emailAddress,
                  needValidator: true,
                  emailValidator: true,
                  hintText: "md.infotech@gmail.com",
                  isCompulsory: true,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldView(
                  title: "Phone Number",
                  titleStyle: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: companyPhoneNo,
                  keyboardType: TextInputType.phone,
                  needValidator: true,
                  phoneNoValidator: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  hintText: "9876543210",
                  isCompulsory: true,
                ),
                SizedBox(
                  height: 20,
                ),

                TextFieldView(
                  title: "Select Date",
                  titleStyle: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: dateController,
                  onTap: () async {
                    final DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );

                    dateController.text =
                        DateFormat('dd MMMM, yyyy').format(selectedDate!);
                  },
                  isCompulsory: true,
                  readOnly: true,
                  hintText: "31 December, 2024",
                  suffixIcon: Icon(Icons.date_range_rounded),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Select financial month/year end *",
                  style: AppTextStyle.regularTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: dateValue.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => GestureDetector(
                            onTap: () {
                              incomeController.dateValue.value = index + 1;
                            },
                            child: Row(
                              children: [
                                Radio(
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        incomeController.dateValue.value ==
                                                index + 1
                                            ? AppColors.primaryColor
                                            : AppColors.greyColor,
                                  ),
                                  value: index + 1,
                                  groupValue: incomeController.dateValue.value,
                                  onChanged: (value) {
                                    incomeController.dateValue.value = value!;
                                  },
                                ),
                                Text(
                                  dateValue[index],
                                  style: AppTextStyle.regularTextStyle.copyWith(
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
                SizedBox(
                  height: 30,
                ),

                // All Amounts

                // Revenue List
                ...revenues.asMap().entries.map((entry) {
                  int revenueIndex = entry.key;
                  Map<String, TextEditingController> revenue = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFieldView(
                            title: "Revenue Item Name",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: revenue["name"]!,
                            hintText: "Product A",
                            isCompulsory: true,
                            isDropDownItem: true,
                            dropdownItems: revenuesList,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFieldView(
                            title: "Price (₹)",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: revenue["price"]!,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9\.]')),
                            ],
                            hintText: "1,000",
                            isCompulsory: true,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              revenues.removeAt(revenueIndex);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(
                  height: 20,
                ),
                ButtonView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        size: 23,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add Revenues",
                        style: AppTextStyle.regularTextStyle
                            .copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  height: 50,
                  containerColor: AppColors.backgroundColor,
                  border: Border.all(color: AppColors.primaryColor),
                  onTap: () {
                    setState(() {
                      revenues.add({
                        "name": TextEditingController(),
                        "price": TextEditingController()
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),

                // COGS List
                ...cgs.asMap().entries.map((entry) {
                  int cogsIndex = entry.key;
                  Map<String, TextEditingController> cogs = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFieldView(
                            title: "COGS Item Name",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: cogs["name"]!,
                            hintText: "Product A",
                            isCompulsory: true,
                            isDropDownItem: true,
                            dropdownItems: cogsList,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFieldView(
                            title: "Price (₹)",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: cogs["price"]!,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9\.]')),
                            ],
                            hintText: "1,000",
                            isCompulsory: true,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              cgs.removeAt(cogsIndex);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(
                  height: 20,
                ),
                ButtonView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        size: 23,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add COGS",
                        style: AppTextStyle.regularTextStyle
                            .copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  height: 50,
                  containerColor: AppColors.backgroundColor,
                  border: Border.all(color: AppColors.primaryColor),
                  onTap: () {
                    setState(() {
                      cgs.add({
                        "name": TextEditingController(),
                        "price": TextEditingController()
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),

                // Expenes List
                ...expenses.asMap().entries.map((entry) {
                  int expensesIndex = entry.key;
                  Map<String, TextEditingController> expense = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFieldView(
                            title: "Expense Item Name",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: expense["name"]!,
                            hintText: "Product A",
                            isCompulsory: true,
                            isDropDownItem: true,
                            dropdownItems: expensesList,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFieldView(
                            title: "Price (₹)",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: expense["price"]!,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9\.]')),
                            ],
                            hintText: "1,000",
                            isCompulsory: true,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              expenses.removeAt(expensesIndex);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(
                  height: 20,
                ),
                ButtonView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        size: 23,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add Expenses",
                        style: AppTextStyle.regularTextStyle
                            .copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  height: 50,
                  containerColor: AppColors.backgroundColor,
                  border: Border.all(color: AppColors.primaryColor),
                  onTap: () {
                    setState(() {
                      expenses.add({
                        "name": TextEditingController(),
                        "price": TextEditingController()
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),

                // Other Incomes List
                ...otherIncomes.asMap().entries.map((entry) {
                  int otherIncomeIndex = entry.key;
                  Map<String, TextEditingController> otherIncome = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFieldView(
                            title: "Other Income Name",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: otherIncome["name"]!,
                            hintText: "Product A",
                            isDropDownItem: true,
                            dropdownItems: otherIncomesList,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFieldView(
                            title: "Price (₹)",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: otherIncome["price"]!,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9\.]')),
                            ],
                            hintText: "1,000",
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              otherIncomes.removeAt(otherIncomeIndex);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(
                  height: 20,
                ),
                ButtonView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        size: 23,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add Other Incomes",
                        style: AppTextStyle.regularTextStyle
                            .copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  height: 50,
                  containerColor: AppColors.backgroundColor,
                  border: Border.all(color: AppColors.primaryColor),
                  onTap: () {
                    setState(() {
                      otherIncomes.add({
                        "name": TextEditingController(),
                        "price": TextEditingController()
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),

                // Other Expenses List
                ...otherExpenses.asMap().entries.map((entry) {
                  int otherExpenseIndex = entry.key;
                  Map<String, TextEditingController> otherExpense = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFieldView(
                            title: "Other Expense Name",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: otherExpense["name"]!,
                            hintText: "Product A",
                            isDropDownItem: true,
                            dropdownItems: otherExpensesList,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFieldView(
                            title: "Price (₹)",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: otherExpense["price"]!,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9\.]')),
                            ],
                            hintText: "1,000",
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              otherExpenses.removeAt(otherExpenseIndex);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
                SizedBox(
                  height: 20,
                ),
                ButtonView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        size: 23,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add Other Expenses",
                        style: AppTextStyle.regularTextStyle
                            .copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  height: 50,
                  containerColor: AppColors.backgroundColor,
                  border: Border.all(color: AppColors.primaryColor),
                  onTap: () {
                    setState(() {
                      otherExpenses.add({
                        "name": TextEditingController(),
                        "price": TextEditingController()
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),

                Obx(
                  () => Column(
                    children: [
                      if (incomeController.taxValue.value == 1)
                        TextFieldView(
                          title: "Tax Percentage",
                          titleStyle: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: tax,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9\.]')),
                          ],
                          hintText: "18 %",
                          isCompulsory: true,
                        ),
                      if (incomeController.taxValue.value == 2)
                        TextFieldView(
                          title: "Tax Amount",
                          titleStyle: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: tax,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9\.]')),
                          ],
                          hintText: "2,000",
                          isCompulsory: true,
                        ),
                      if (incomeController.taxValue.value == 1 ||
                          incomeController.taxValue.value == 2)
                        SizedBox(
                          height: 20,
                        ),
                      Container(
                        height: 30,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: taxValue.length,
                            itemBuilder: (context, index) {
                              return Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    incomeController.taxValue.value = index + 1;
                                  },
                                  child: Row(
                                    children: [
                                      Radio(
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                          (states) =>
                                              incomeController.taxValue.value ==
                                                      index + 1
                                                  ? AppColors.primaryColor
                                                  : AppColors.greyColor,
                                        ),
                                        value: index + 1,
                                        groupValue:
                                            incomeController.taxValue.value,
                                        onChanged: (value) {
                                          incomeController.taxValue.value =
                                              value!;
                                        },
                                      ),
                                      Text(
                                        taxValue[index],
                                        style: AppTextStyle.regularTextStyle
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
                  height: 40,
                ),

                // Signature Image
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.greyColor.shade300,
                        image: DecorationImage(
                          image: IncomeMake.signatureImagePath.isEmpty
                              ? Image.asset(
                                  AppImages.addImage,
                                  color: AppColors.greyColor.shade300,
                                  scale: 12,
                                ).image
                              : Image.file(
                                  File(IncomeMake.signatureImagePath),
                                ).image,
                          fit: IncomeMake.signatureImagePath.isEmpty
                              ? BoxFit.scaleDown
                              : BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Signature",
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Some companies require income statement without signature, so check before adding one.",
                              style: AppTextStyle.regularTextStyle
                                  .copyWith(fontSize: 9),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () async {
                                ImagePicker imagePicker = ImagePicker();

                                XFile? xFile = await imagePicker.pickImage(
                                    source: ImageSource.gallery);

                                if (xFile != null && xFile.path.isNotEmpty) {
                                  IncomeMake.signatureImagePath = xFile.path;
                                }

                                setState(() {});
                              },
                              child: Container(
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Upload Signature",
                                    style:
                                        AppTextStyle.regularTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
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

                SizedBox(
                  height: 80,
                ),
                ButtonView(
                  title: "Continue",
                  onTap: () {
                    List revenuesList = [
                      {"name": "Revenue:", "price": ""},
                      ...revenues.map((revenue) {
                        return {
                          "name": revenue["name"]!.text,
                          "price": revenue["price"]!.text
                        };
                      }).toList(),
                    ];

                    List cgsList = [
                      {"name": "Cost of Goods Sale:", "price": ""},
                      ...cgs.map((cogs) {
                        return {
                          "name": cogs["name"]!.text,
                          "price": cogs["price"]!.text
                        };
                      }).toList(),
                    ];

                    List expensesList = [
                      {"name": "Expense:", "price": ""},
                      ...expenses.map((expense) {
                        return {
                          "name": expense["name"]!.text,
                          "price": expense["price"]!.text
                        };
                      }).toList(),
                    ];

                    List otherIncomesList = [
                      {"name": "Other Income:", "price": ""},
                      ...otherIncomes.map((otherIncome) {
                        return {
                          "name": otherIncome["name"]!.text,
                          "price": otherIncome["price"]!.text
                        };
                      }).toList(),
                    ];

                    List otherExpensesList = [
                      {"name": "Other Expense:", "price": ""},
                      ...otherExpenses.map((otherExpense) {
                        return {
                          "name": otherExpense["name"]!.text,
                          "price": otherExpense["price"]!.text
                        };
                      }).toList(),
                    ];

                    if (companyName.text.isEmpty ||
                        gstNo.text.isEmpty ||
                        companyEmail.text.isEmpty ||
                        companyPhoneNo.text.isEmpty ||
                        dateController.text.isEmpty) {
                      toastView(
                        msg: "Please fill all details",
                        context: context,
                      );
                    } else if (gstNo.text.length < 15) {
                      toastView(
                        msg: "GST number must be 15 character",
                        context: context,
                      );
                    } else if (revenues.isEmpty) {
                      toastView(
                        msg: "Please add revenues",
                        context: context,
                      );
                    } else if (revenues.any((revenue) =>
                        revenue["name"]!.text.isEmpty ||
                        revenue["price"]!.text.isEmpty)) {
                      toastView(
                        msg: "Please fill all revenue fields",
                        context: context,
                      );
                    } else if (cgs.isEmpty) {
                      toastView(
                        msg: "Please add COGS",
                        context: context,
                      );
                    } else if (cgs.any((cogs) =>
                        cogs["name"]!.text.isEmpty ||
                        cogs["price"]!.text.isEmpty)) {
                      toastView(
                        msg: "Please fill all COGS fields",
                        context: context,
                      );
                    } else if (expenses.isEmpty) {
                      toastView(
                        msg: "Please add expenses",
                        context: context,
                      );
                    } else if (expenses.any((expense) =>
                        expense["name"]!.text.isEmpty ||
                        expense["price"]!.text.isEmpty)) {
                      toastView(
                        msg: "Please fill all expense fields",
                        context: context,
                      );
                    } else if (otherIncomes.any((income) =>
                        income["name"]!.text.isEmpty ||
                        income["price"]!.text.isEmpty)) {
                      toastView(
                        msg: "Please fill all fields for Other Incomes",
                        context: context,
                      );
                    } else if (otherExpenses.any((expense) =>
                        expense["name"]!.text.isEmpty ||
                        expense["price"]!.text.isEmpty)) {
                      toastView(
                        msg: "Please fill all fields for Other Expenses",
                        context: context,
                      );
                    } else if (incomeController.taxValue.value == 0) {
                      toastView(
                        msg: "Please select tax type",
                        context: context,
                      );
                    } else if (incomeController.dateValue.value == 0) {
                      toastView(
                        msg: "Please select month/year",
                        context: context,
                      );
                    } else {
                      if (tax.text.isEmpty) {
                        toastView(
                          msg: "Please fill tax percentage/amount",
                          context: context,
                        );
                      } else {
                        if (_formKey.currentState!.validate()) {
                          IncomeMake.generateIncome(
                            companyName: companyName.text,
                            gstNumber: gstNo.text,
                            companyEmail: companyEmail.text,
                            companyPhoneNo: companyPhoneNo.text,
                            taxType: incomeController.taxValue.value == 1
                                ? "taxPercentage"
                                : "taxAmount",
                            tax: tax.text,
                            dateType: incomeController.dateValue.value == 1
                                ? "month"
                                : "year",
                            date: dateController.text,
                            revenues: revenuesList,
                            cgs: cgsList,
                            expenses: expensesList,
                            otherIncomes: otherIncomesList,
                            otherExpenses: otherExpensesList,
                            context: context,
                          );
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
