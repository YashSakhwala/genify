// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_style.dart';
import '../../../controller/transaction_controller.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import "package:universal_html/html.dart" as html;
import '../../../widgets/common_widgets/toast_view.dart';

class WebEditDetailsScreen extends StatefulWidget {
  final String type;
  final String amount;
  final String title;
  final String subtitle;
  final String wallet;
  final String image;
  final String uniqueTime;
  const WebEditDetailsScreen({
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
  State<WebEditDetailsScreen> createState() => _WebEditDetailsScreenState();
}

class _WebEditDetailsScreenState extends State<WebEditDetailsScreen> {
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
      backgroundColor: AppColors.whiteColor,
      body: Container(
        color: widget.type == "Incomes"
            ? AppColors.greenColor
            : AppColors.redColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.type == "Incomes" ? "Incomes" : "Expenses",
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
                        fontSize: 15,
                        color: AppColors.whiteColor.withOpacity(0.7),
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
                                  RegExp(r'[0-9\.]'))
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
                                        transactionController
                                            .webImageFile.value = file;
                                        transactionController.imagePath.value =
                                            reader.result as String;
                                      });
                                    });
                                  } else {
                                    ImagePicker imagePicker = ImagePicker();

                                    XFile? xFile = await imagePicker.pickImage(
                                        source: ImageSource.gallery);

                                    if (xFile != null &&
                                        xFile.path.isNotEmpty) {
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
                                        height: 370,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: AppColors.greyColor),
                                          color: AppColors.greyColor.shade300,
                                          image: DecorationImage(
                                            image: transactionController
                                                    .imagePath.value.isNotEmpty
                                                ? kIsWeb
                                                    ? Image.network(
                                                        transactionController
                                                            .imagePath.value,
                                                        height: 160,
                                                        width: 160,
                                                        fit: BoxFit.cover,
                                                      ).image
                                                    : Image.file(
                                                        File(
                                                            transactionController
                                                                .imagePath
                                                                .value),
                                                        height: 160,
                                                        width: 160,
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
                              Container(
                                height: 140,
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
                                      uniqueTime: widget.uniqueTime,
                                      image: widget.image,
                                      context: context,
                                    );
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
      ),
    );
  }
}
