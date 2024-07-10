// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_style.dart';
import '../../../controller/transaction_controller.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';

class EditDetailsCommonViewScreen extends StatefulWidget {
  final String type;
  final String amount;
  final String title;
  final String subtitle;
  final String wallet;
  final String image;
  final String uniqueTime;

  const EditDetailsCommonViewScreen({
    super.key,
    required this.type,
    required this.amount,
    required this.title,
    required this.subtitle,
    required this.wallet,
    required this.image,
    required this.uniqueTime,
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

  @override
  void initState() {
    amount.text = widget.amount;
    title.text = widget.title;
    subTitle.text = widget.subtitle;
    wallet = widget.wallet;
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
                      color: AppColors.whiteColor.withOpacity(0.7),
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
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        ImagePicker imagePicker = ImagePicker();

                        XFile? xFile = await imagePicker.pickImage(
                            source: ImageSource.gallery);

                        if (xFile != null && xFile.path.isNotEmpty) {
                          transactionController.imagePath.value = xFile.path;
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
                                border: Border.all(color: AppColors.greyColor),
                                image: DecorationImage(
                                  image: transactionController
                                          .imagePath.value.isNotEmpty
                                      ? Image.file(
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
                      height: 130,
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
                          transactionController.updateTransactionData(
                            amount: amount.text,
                            title: title.text,
                            subTitle: subTitle.text,
                            payment: wallet,
                            context: context,
                            image: widget.image,
                            uniqueTime: widget.uniqueTime,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
