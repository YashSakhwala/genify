// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_local_variable

import "dart:developer";
import "dart:io";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:genify/screens/home_screen_option/invoice_view/invoice_make_function.dart";
import "package:genify/widgets/common_widgets/text_field_view.dart";
import "package:image_picker/image_picker.dart";
import "../../../../config/app_colors.dart";
import "../../../../config/app_image.dart";
import "../../../../config/app_style.dart";
import "../../../../widgets/common_widgets/appbar.dart";
import "../../../../widgets/common_widgets/button_view.dart";
import "../../../widgets/common_widgets/toast_view.dart";

class InvoiceCommonViewScreen extends StatefulWidget {
  const InvoiceCommonViewScreen({super.key});

  @override
  State<InvoiceCommonViewScreen> createState() =>
      _InvoiceCommonViewScreenState();
}

class _InvoiceCommonViewScreenState extends State<InvoiceCommonViewScreen> {
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
      appBar: AppBarView(
        title: "Invoice",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
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
                      image: InvoiceMake.imagePath.isEmpty
                          ? Image.asset(
                              AppImages.addImage,
                              color: AppColors.greyColor.shade300,
                              scale: 12,
                            ).image
                          : Image.file(
                              File(InvoiceMake.imagePath),
                            ).image,
                      fit: InvoiceMake.imagePath.isEmpty
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
                          "Add a photo",
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Some companies require invoice without photos, so check before adding one.",
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
                              InvoiceMake.imagePath = xFile.path;
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
                                "Upload photo",
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
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            TextFieldView(
              title: "Company name",
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
              title: "GST number",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: gstNo,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              hintText: "123456789012345",
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
              title: "Phone number",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: companyPhoneNo,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              hintText: "9876543210",
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
              hintText: "105-A, Ambar society, Neharu chock, surat.",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Client name",
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
              title: "Client email",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: clientEmail,
              hintText: "mishra.varun@email.com",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Client phone number",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: clientPhoneNo,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              hintText: "0123456789",
            ),
            SizedBox(
              height: 20,
            ),

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
                        titleStyle: AppTextStyle.regularTextStyle.copyWith(
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
                        titleStyle: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: item["quantity"]!,
                        keyboardType: TextInputType.number,
                        hintText: "0",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFieldView(
                        title: "Price",
                        titleStyle: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: item["price"]!,
                        keyboardType: TextInputType.number,
                        hintText: "0",
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
            SizedBox(
              height: 40,
            ),
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
                      image: InvoiceMake.signatureImagePath.isEmpty
                          ? Image.asset(
                              AppImages.addImage,
                              color: AppColors.greyColor.shade300,
                              scale: 12,
                            ).image
                          : Image.file(
                              File(InvoiceMake.signatureImagePath),
                            ).image,
                      fit: InvoiceMake.signatureImagePath.isEmpty
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
                          "Add a signature",
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Some companies require invoice without signature, so check before adding one.",
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
                              InvoiceMake.signatureImagePath = xFile.path;
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
                                "Upload signature",
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
                ),
              ],
            ),

            SizedBox(
              height: 80,
            ),
            ButtonView(
              title: "Continue",
              onTap: () {
                log("Company name-----> ${companyName.text}");
                log("GST number-----> ${gstNo.text}");
                log("Company email-----> ${companyEmail.text}");
                log("Company phoneNo-----> ${companyPhoneNo.text}");
                log("Address-----> ${address.text}");
                log("Client email-----> ${clientEmail.text}");
                log("Client phoneNo-----> ${clientPhoneNo.text}");
                log("Items-----> ${items.map((item) => "Name: ${item["name"]!.text}, Quantity: ${item["quantity"]!.text}, Price: ${item["price"]!.text}").toList()}");

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

                // InvoiceMake.generateInvoice(
                //   companyName: "MD Pharma",
                //   gstNumber: "123456789012345",
                //   companyEmail: "md.pharma@gmail.com",
                //   companyPhoneNo: "8795674356",
                //   address: "46, Jolly arcade, P.M. road, Surat - 39145",
                //   clientName: "Yash Sakhwala",
                //   clientEmail: "yashsakhwala@gmail.com",
                //   clientPhoneNo: "9723831969",
                //   items: [
                //     {
                //       "name": "Paracetamol",
                //       "quantity": "10",
                //       "price": "5",
                //     },
                //     {
                //       "name": "Ibuprofen",
                //       "quantity": "5",
                //       "price": "10",
                //     },
                //   ],
                //   context: context,
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
