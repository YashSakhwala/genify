// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import "package:universal_html/html.dart" as html;
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/button_view.dart';
import "package:genify/screens/home_screen_option/invoice_view/invoice_make_function.dart";
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';

class WebInvoiceScreen extends StatefulWidget {
  const WebInvoiceScreen({super.key});

  @override
  State<WebInvoiceScreen> createState() => _WebInvoiceScreenState();
}

class _WebInvoiceScreenState extends State<WebInvoiceScreen> {
  final TextEditingController companyName = TextEditingController();
  final TextEditingController gstNo = TextEditingController();
  final TextEditingController companyEmail = TextEditingController();
  final TextEditingController companyPhoneNo = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController clientName = TextEditingController();
  final TextEditingController clientEmail = TextEditingController();
  final TextEditingController clientPhoneNo = TextEditingController();
  final List<Map<String, TextEditingController>> items = [];

  @override
  void initState() {
    InvoiceMake.imagePath = "";
    InvoiceMake.signatureImagePath = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: FlipInX(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 7,
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.greyColor.shade300,
                              image: DecorationImage(
                                image: InvoiceMake.imagePath.isEmpty
                                    ? Image.asset(
                                        AppImages.addImage,
                                        color: AppColors.greyColor.shade300,
                                        scale: 12,
                                      ).image
                                    : Image.network(
                                        InvoiceMake.imagePath,
                                      ).image,
                                fit: InvoiceMake.imagePath.isEmpty
                                    ? BoxFit.scaleDown
                                    : BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Some companies require invoice without logo, so check before adding one.",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 25,
                          ),
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
                                  setState(() {
                                    InvoiceMake.imagePath =
                                        reader.result as String;
                                  });
                                });
                              });
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
                                  style: AppTextStyle.regularTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.greyColor.shade300,
                              image: DecorationImage(
                                image: InvoiceMake.signatureImagePath.isEmpty
                                    ? Image.asset(
                                        AppImages.addImage,
                                        color: AppColors.greyColor.shade300,
                                        scale: 12,
                                      ).image
                                    : Image.network(
                                        InvoiceMake.signatureImagePath,
                                      ).image,
                                fit: InvoiceMake.signatureImagePath.isEmpty
                                    ? BoxFit.scaleDown
                                    : BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Some companies require invoice without signature, so check before adding one.",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 25,
                          ),
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
                                  setState(() {
                                    InvoiceMake.signatureImagePath =
                                        reader.result as String;
                                  });
                                });
                              });
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
                                  style: AppTextStyle.regularTextStyle.copyWith(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 60,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFieldView(
                            title: "Company Name",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: companyName,
                            hintText: "MD Pharma",
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
                            hintText: "md.infotech@gmail.com",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldView(
                            title: "Address",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: address,
                            maxLines: 4,
                            vertical: 4,
                            hintText:
                                "105-A, Ambar society, Neharu chock, surat.",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFieldView(
                            title: "Client Name",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: clientName,
                            hintText: "Varun Mishra",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldView(
                            title: "Client Phone Number",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: clientPhoneNo,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            hintText: "0123456789",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 60,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFieldView(
                            title: "GST Number",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: gstNo,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9A-Z]')),
                              LengthLimitingTextInputFormatter(15),
                            ],
                            hintText: "12ABCDE3456F",
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
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            hintText: "9876543210",
                          ),
                          SizedBox(
                            height: 144,
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFieldView(
                            title: "Client Email",
                            titleStyle: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: clientEmail,
                            hintText: "mishra.varun@email.com",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 7,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 60,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          // Item List
                          ...items.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, TextEditingController> item = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFieldView(
                                      title: "Item Name",
                                      titleStyle:
                                          AppTextStyle.regularTextStyle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: item["name"]!,
                                      hintText: "Paracetamol",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFieldView(
                                      title: "Quantity",
                                      titleStyle:
                                          AppTextStyle.regularTextStyle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: item["quantity"]!,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      hintText: "0",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFieldView(
                                      title: "Price",
                                      titleStyle:
                                          AppTextStyle.regularTextStyle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      controller: item["price"]!,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9\.]')),
                                      ],
                                      hintText: "0.0",
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        items.removeAt(index);
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
                                  "Add Items",
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
                                items.add({
                                  "name": TextEditingController(),
                                  "quantity": TextEditingController(),
                                  "price": TextEditingController()
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                ButtonView(
                  height: 45,
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue",
                        style: AppTextStyle.smallTextStyle.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.whiteColor,
                        size: 15,
                      ),
                    ],
                  ),
                  onTap: () {
                    List<Map<String, String>> itemList = items.map((item) {
                      return {
                        "name": item["name"]!.text,
                        "quantity": item["quantity"]!.text,
                        "price": item["price"]!.text
                      };
                    }).toList();
            
                    if (companyName.text.isEmpty ||
                        gstNo.text.isEmpty ||
                        companyEmail.text.isEmpty ||
                        companyPhoneNo.text.isEmpty ||
                        address.text.isEmpty ||
                        clientName.text.isEmpty ||
                        clientEmail.text.isEmpty ||
                        clientPhoneNo.text.isEmpty) {
                      toastView(
                        msg: "Please fill all details",
                        context: context,
                      );
                    } else if (items.isEmpty) {
                      toastView(
                        msg: "Please fill item details",
                        context: context,
                      );
                    } else if (items.any((item) => item["name"]!.text.isEmpty)) {
                      toastView(
                        msg: "Please fill item name",
                        context: context,
                      );
                    } else {
                      InvoiceMake.generateInvoice(
                        companyName: companyName.text,
                        gstNumber: gstNo.text,
                        companyEmail: companyEmail.text,
                        companyPhoneNo: companyPhoneNo.text,
                        address: address.text,
                        clientName: clientName.text,
                        clientEmail: clientEmail.text,
                        clientPhoneNo: clientPhoneNo.text,
                        items: itemList,
                        context: context,
                      );
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
