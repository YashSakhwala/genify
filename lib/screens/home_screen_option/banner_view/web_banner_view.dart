// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:genify/config/app_colors.dart';
import "package:universal_html/html.dart" as html;
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import '../../../widgets/common_widgets/toast_view.dart';
import 'all_banner_view/web_all_banner_view.dart';
import 'banner_make_function.dart';

class WebBannerScreen extends StatefulWidget {
  const WebBannerScreen({super.key});

  @override
  State<WebBannerScreen> createState() => _WebBannerScreenState();
}

class _WebBannerScreenState extends State<WebBannerScreen> {
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
    BannerMake.imagePath = "";
    BannerMake.backgroundImagePath = "";

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
          title: Text("Pick a color"),
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
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
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
                              image: BannerMake.imagePath.isEmpty
                                  ? Image.asset(
                                      AppImages.addImage,
                                      color: AppColors.greyColor.shade300,
                                      scale: 12,
                                    ).image
                                  : Image.network(
                                      BannerMake.imagePath,
                                    ).image,
                              fit: BannerMake.imagePath.isEmpty
                                  ? BoxFit.scaleDown
                                  : BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Some companies require banner without logo, so check before adding one.",
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
                                  BannerMake.imagePath =
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
                              image: BannerMake.backgroundImagePath.isEmpty
                                  ? Image.asset(
                                      AppImages.addImage,
                                      color: AppColors.greyColor.shade300,
                                      scale: 12,
                                    ).image
                                  : Image.network(
                                      BannerMake.backgroundImagePath,
                                    ).image,
                              fit: BannerMake.backgroundImagePath.isEmpty
                                  ? BoxFit.scaleDown
                                  : BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Some companies require banner without background image, so check before adding one.",
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
                                  BannerMake.backgroundImagePath =
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
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: SingleChildScrollView(
                                  child: Text(
                                    "Upload Background Image",
                                    style:
                                        AppTextStyle.regularTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
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
                          title: "Phone Number",
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
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldView(
                                title: "Text Color",
                                controller: textColorController,
                                titleStyle:
                                    AppTextStyle.regularTextStyle.copyWith(
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
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 60,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                        SizedBox(
                          height: 144,
                        ),
                        Divider(
                          thickness: 1.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFieldView(
                                title: "Background Color",
                                controller: backgroundColorController,
                                titleStyle:
                                    AppTextStyle.regularTextStyle.copyWith(
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
                                      backgroundColorController.text = color
                                          .value
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
                          height: 120,
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
                                builder: (context) => WebAllBannerScreen(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
