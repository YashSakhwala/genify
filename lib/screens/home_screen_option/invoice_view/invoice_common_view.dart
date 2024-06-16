// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "dart:developer";
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:genify/widgets/common_widgets/text_field_view.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "../../../../config/app_colors.dart";
import "../../../../config/app_image.dart";
import "../../../../config/app_style.dart";
import "../../../../controller/transaction_controller.dart";
import "../../../../widgets/common_widgets/appbar.dart";
import "../../../../widgets/common_widgets/button_view.dart";

class InvoiceCommonViewScreen extends StatefulWidget {
  const InvoiceCommonViewScreen({super.key});

  @override
  State<InvoiceCommonViewScreen> createState() =>
      _InvoiceCommonViewScreenState();
}

class _InvoiceCommonViewScreenState extends State<InvoiceCommonViewScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());

  final TextEditingController companyName = TextEditingController();
  final TextEditingController gstNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController address = TextEditingController();
  final List items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: "Invoice",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView(
          children: [
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();

                  XFile? xFile =
                      await imagePicker.pickImage(source: ImageSource.gallery);

                  if (xFile != null && xFile.path.isNotEmpty) {
                    transactionController.imagePath.value = xFile.path;
                  }
                },
                child: Stack(
                  children: [
                    Obx(
                      () => Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: AppColors.greyColor.shade300,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: transactionController.imagePath.value.isEmpty
                                ? Image.asset(
                                    AppImages.addImage,
                                    color: AppColors.greyColor.shade300,
                                    scale: 12,
                                  ).image
                                : Image.file(
                                    File(transactionController.imagePath.value),
                                  ).image,
                            fit: transactionController.imagePath.value.isEmpty
                                ? BoxFit.scaleDown
                                : BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 18,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Company name",
              controller: companyName,
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "GST number",
              controller: gstNo,
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Email",
              controller: email,
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Phone number",
              controller: phoneNo,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Address",
              controller: address,
            ),
            SizedBox(
              height: 20,
            ),

            // Item List
            ...items.asMap().entries.map((entry) {
              int index = entry.key;
              Map item = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldView(
                        title: "Item Name",
                        controller: item["name"],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFieldView(
                        title: "Quantity",
                        controller: item["quantity"],
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFieldView(
                        title: "Price",
                        controller: item["price"],
                        keyboardType: TextInputType.number,
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
              title: "Add Item",
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

            SizedBox(
              height: 80,
            ),
            ButtonView(
              title: "Continue",
              onTap: () {
                log("Name-----> ${companyName.text}");
                log("GST number-----> ${gstNo.text}");
                log("Email-----> ${email.text}");
                log("PhoneNo-----> ${phoneNo.text}");
                log("Address-----> ${address.text}");
                log("Items-----> ${items.map((item) => "Name: ${item["name"].text}, Quantity: ${item["quantity"].text}, Price: ${item["price"].text}").toList()}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
