// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import "dart:io";
import "package:animate_do/animate_do.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_colorpicker/flutter_colorpicker.dart";
import "package:image_picker/image_picker.dart";
import "../../../config/app_colors.dart";
import "../../../config/app_image.dart";
import "../../../config/app_style.dart";
import "../../../widgets/common_widgets/appbar.dart";
import "../../../widgets/common_widgets/button_view.dart";
import "../../../widgets/common_widgets/text_field_view.dart";
import "../../../widgets/common_widgets/toast_view.dart";
import "all_card_view/all_card_common_view.dart";
import "card_make_function.dart";

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
  final TextEditingController textColorController = TextEditingController();
  final TextEditingController backgroundColorController =
      TextEditingController();

  Color textColor = AppColors.blackColor;
  Color backgroundColor = AppColors.whiteColor;

  @override
  void initState() {
    super.initState();
    CardMake.imagePath = "";
    CardMake.backgroundImagePath = "";

    textColorController.text =
        textColor.value.toRadixString(16).substring(2).toUpperCase();
    backgroundColorController.text =
        backgroundColor.value.toRadixString(16).substring(2).toUpperCase();

    textColorController.addListener(() {
      applyColorCode(textColorController, (color) {
        setState(() {
          textColor = color;
        });
      });
    });

    backgroundColorController.addListener(() {
      applyColorCode(backgroundColorController, (color) {
        setState(() {
          backgroundColor = color;
        });
      });
    });
  }

  void applyColorCode(
      TextEditingController controller, Function(Color) onColorPicked) {
    try {
      String colorCode = controller.text;
      if (colorCode.startsWith("#")) {
        colorCode = colorCode.substring(1);
      }
      if (colorCode.length == 6) {
        int colorValue = int.parse(colorCode, radix: 16);
        Color color = Color(0xFF000000 + colorValue);
        onColorPicked(color);
      }
    } catch (e) {
      print("Invalid color code");
    }
  }

  void pickColor(Color currentColor, Function(Color) onColorPicked) async {
    Color pickedColor = currentColor;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick a Color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                pickedColor = color;
              },
            ),
          ),
          actions: [
            ButtonView(
              title: "Select",
              onTap: () {
                onColorPicked(pickedColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        child: FlipInX(
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
                            "Add Company Logo",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Some companies require card without logo, so check before adding one.",
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
                title: "Phone Number",
                controller: phoneNo,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldView(
                      title: "Text Color",
                      controller: textColorController,
                      titleStyle: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: InkWell(
                      onTap: () {
                        pickColor(textColor, (color) {
                          setState(() {
                            textColor = color;
                            textColorController.text = color.value
                                .toRadixString(16)
                                .substring(2)
                                .toUpperCase();
                          });
                        });
                      },
                      child: Container(
                        height: 47,
                        width: 50,
                        decoration: BoxDecoration(
                          color: textColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldView(
                      title: "Background Color",
                      controller: backgroundColorController,
                      titleStyle: AppTextStyle.regularTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: InkWell(
                      onTap: () {
                        pickColor(backgroundColor, (color) {
                          setState(() {
                            backgroundColor = color;
                            backgroundColorController.text = color.value
                                .toRadixString(16)
                                .substring(2)
                                .toUpperCase();
                          });
                        });
                      },
                      child: Container(
                        height: 47,
                        width: 50,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.greyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                        image: CardMake.backgroundImagePath.isEmpty
                            ? Image.asset(
                                AppImages.addImage,
                                color: AppColors.greyColor.shade300,
                                scale: 12,
                              ).image
                            : Image.file(
                                File(CardMake.backgroundImagePath),
                              ).image,
                        fit: CardMake.backgroundImagePath.isEmpty
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
                            "Add Background Image",
                            style: AppTextStyle.regularTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Some companies require card without background image, so check before adding one.",
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
                                CardMake.backgroundImagePath = xFile.path;
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
                                  "Upload Background Image",
                                  style: AppTextStyle.regularTextStyle.copyWith(
                                    fontSize: 12,
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
                  if (name.text.isEmpty ||
                      profession.text.isEmpty ||
                      email.text.isEmpty ||
                      phoneNo.text.isEmpty ||
                      address.text.isEmpty) {
                    toastView(
                      msg: "Please fill all details",
                      context: context,
                    );
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllCardCommonScreen(
                        name: name.text,
                        profession: profession.text,
                        email: email.text,
                        phoneNo: phoneNo.text,
                        address: address.text,
                        textColor: textColor,
                        backgroundColor: backgroundColor,
                      ),
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
