// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../controller/transaction_controller.dart';
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
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 300,
        color: AppColors.greenColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Income",
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 18,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: 65,
                  ),
                  Text(
                    "How much?",
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 12,
                      color: AppColors.whiteColor.withOpacity(0.7),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "₹ ",
                        style: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 20,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Expanded(
                        child: TextFieldView(
                          title: "",
                          controller: amount,
                          keyboardType: TextInputType.number,
                          cursorHeight: 20,
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 20,
                            color: AppColors.whiteColor,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "0",
                            hintStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 20,
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
            Spacer(),
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            transactionController.webImageFile.value = file;
                            transactionController.imagePath.value =
                                reader.result as String;
                          });
                        });
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
                              image:
                                  transactionController.imagePath.value.isEmpty
                                      ? Image.asset(
                                          AppImages.addImage,
                                          color: AppColors.greyColor.shade300,
                                          scale: 15,
                                        ).image
                                      : Image.network(
                                          transactionController.imagePath.value,
                                        ).image,
                              fit: transactionController.imagePath.value.isEmpty
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
                      vertical: 8,
                      hintText: "Category",
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    TextFieldView(
                      title: "",
                      controller: subTitle,
                      vertical: 8,
                      hintText: "Description",
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      height: 47,
                      child: DropdownButtonFormField(
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
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            if (amount.text.isEmpty ||
                                title.text.isEmpty ||
                                subTitle.text.isEmpty) {
                              toastView(
                                msg: "Please enter details",
                                context: context,
                              );
                            } else {
                              transactionController.AllTransaction(
                                amount: amount.text,
                                title: title.text,
                                subTitle: subTitle.text,
                                payment: wallet,
                                context: context,
                                type: "income",
                              );
                            }
                          },
                          child: Text(
                            "Continue",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
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
