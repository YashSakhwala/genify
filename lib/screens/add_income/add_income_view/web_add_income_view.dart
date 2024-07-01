// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
      backgroundColor: AppColors.whiteColor,
      body: Container(
        color: AppColors.greenColor,
        child: SingleChildScrollView(
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
                                  RegExp(r'[0-9]'))
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
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
                                          : Image.network(
                                              transactionController
                                                  .imagePath.value,
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
                                } else if (transactionController
                                    .imagePath.value.isEmpty) {
                                  toastView(
                                    msg: "Please select image",
                                    context: context,
                                  );
                                } else {
                                  transactionController.AllTransaction(
                                    amount: amount.text,
                                    title: title.text,
                                    subTitle: subTitle.text,
                                    payment: wallet,
                                    context: context,
                                    type: "Incomes",
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
            ],
          ),
        ),
      ),
    );
  }
}
