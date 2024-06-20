// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import "package:universal_html/html.dart" as html;
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import 'card_make_function.dart';

class WebCardScreen extends StatefulWidget {
  const WebCardScreen({super.key});

  @override
  State<WebCardScreen> createState() => _WebCardScreenState();
}

class _WebCardScreenState extends State<WebCardScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController profession = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  void initState() {
    CardMake.webImageFile = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
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
                              image: CardMake.imagePath.isEmpty
                                  ? Image.asset(
                                      AppImages.addImage,
                                      color: AppColors.greyColor.shade300,
                                      scale: 12,
                                    ).image
                                  : Image.network(
                                      CardMake.imagePath,
                                    ).image,
                              fit: CardMake.imagePath.isEmpty
                                  ? BoxFit.scaleDown
                                  : BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Some companies require card without photos, so check before adding one.",
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 40,
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
                                  CardMake.webImageFile = file;
                                  CardMake.imagePath = reader.result as String;
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 60,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextFieldView(
                          title: "Name",
                          titleStyle: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: name,
                          hintText: "Varun Mishra",
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
                          controller: phoneNo,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                          hintText:
                              "105-A, Ambar society, Neharu chock, surat.",
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
                          title: "Profession",
                          titleStyle: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          controller: profession,
                          hintText: "Software Engineer",
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
                          controller: email,
                          hintText: "mishra.varun@email.com",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 130,
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
                  log("Name-----> ${name.text}");
                  log("Profession-----> ${profession.text}");
                  log("Email-----> ${email.text}");
                  log("PhoneNo-----> ${phoneNo.text}");
                  log("Address-----> ${address.text}");

                  CardMake.generateCard(
                    name: name.text,
                    profession: profession.text,
                    email: email.text,
                    phoneNo: phoneNo.text,
                    address: address.text,
                    context: context,
                  );

                  // CardMake.generateCard(
                  //   name: "Yash sakhwala",
                  //   profession: "Insurance Advisor",
                  //   email: "mkconsulting@gmail.com",
                  //   phoneNo: "90998 42858",
                  //   address: "119, Silver line, K.M. chock, Surat - 395006",
                  //   context: context,
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
