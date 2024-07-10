// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/controller/transaction_controller.dart';
import 'package:genify/widgets/common_widgets/appbar.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import 'package:genify/widgets/common_widgets/text_field_view.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_image.dart';
import "package:universal_html/html.dart" as html;

class AddExpensesCommonViewScreen extends StatefulWidget {
  const AddExpensesCommonViewScreen({super.key});

  @override
  State<AddExpensesCommonViewScreen> createState() =>
      _AddExpensesCommonViewScreenState();
}

class _AddExpensesCommonViewScreenState
    extends State<AddExpensesCommonViewScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());

  final TextEditingController amount = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController subTitle = TextEditingController();

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

  @override
  void initState() {
    transactionController.imagePath.value = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.redColor,
      appBar: AppBarView(
        title: "Expenses",
        style: AppTextStyle.regularTextStyle.copyWith(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.redColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 85, left: 30),
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
                          () => Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.greyColor),
                              color: AppColors.greyColor.shade300,
                              image: DecorationImage(
                                image: transactionController
                                        .imagePath.value.isEmpty
                                    ? Image.asset(
                                        AppImages.addImage,
                                        color: AppColors.greyColor.shade300,
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
                        title: "Continue",
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
                            if (transactionController.imagePath.value.isEmpty) {
                              transactionController.imagePath.value = "";
                            }

                            transactionController.AllTransaction(
                              amount: amount.text,
                              title: title.text,
                              subTitle: subTitle.text,
                              payment: wallet,
                              context: context,
                              type: "Expenses",
                            );
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
