// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import 'card_make_function.dart';

class CardCommonViewScreen extends StatefulWidget {
  const CardCommonViewScreen({super.key});

  @override
  State<CardCommonViewScreen> createState() => _CardCommonViewScreenState();
}

class _CardCommonViewScreenState extends State<CardCommonViewScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController profession = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  void initState() {
    CardMake.imagePath = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: "Card",
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
                      image: CardMake.imagePath.isEmpty
                          ? Image.asset(
                              AppImages.addImage,
                              color: AppColors.greyColor.shade300,
                              scale: 12,
                            ).image
                          : Image.file(
                              File(CardMake.imagePath),
                            ).image,
                      fit: CardMake.imagePath.isEmpty
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
                          "Some companies require card without photos, so check before adding one.",
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
                              CardMake.imagePath = xFile.path;
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
              title: "Name",
              controller: name,
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              hintText: "MK Consulting",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Profession",
              controller: profession,
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              hintText: "Insurance Advisor",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Email",
              controller: email,
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              hintText: "mkconsultancy@gmail.com",
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
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              hintText: "9876543210",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Address",
              controller: address,
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 4,
              vertical: 4,
              hintText: "119, Silver line, K.M. chock, Surat - 395006",
            ),
            SizedBox(
              height: 80,
            ),
            ButtonView(
              title: "Continue",
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
    );
  }
}
