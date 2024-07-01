// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, unused_local_variable, avoid_web_libraries_in_flutter, unused_element, file_names, avoid_print, use_build_context_synchronously, sized_box_for_whitespace

import 'dart:async';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genify/widgets/common_widgets/snackbar_view.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import "package:universal_html/html.dart" as html;
import "dart:io" as io;
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_style.dart';
import '../../../widgets/common_widgets/appbar.dart';
import '../../../widgets/common_widgets/button_view.dart';
import '../../../widgets/common_widgets/text_field_view.dart';

class BarcodeCommonViewScreen extends StatefulWidget {
  const BarcodeCommonViewScreen({super.key});

  @override
  State<BarcodeCommonViewScreen> createState() =>
      _BarcodeCommonViewScreenState();
}

class _BarcodeCommonViewScreenState extends State<BarcodeCommonViewScreen> {
  late QrImage qrImage;
  final TextEditingController text = TextEditingController();
  GlobalKey qrKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    generateQrCode('');
  }

  void generateQrCode(String data) {
    try {
      final qrCode = QrCode(
        8,
        QrErrorCorrectLevel.H,
      )..addData(data);

      setState(() {
        qrImage = QrImage(qrCode);
      });
    } catch (e) {
      toastView(
        msg: "Enter valid input !",
        context: context,
      );
    }
  }

  Future<void> saveQrCode() async {
    ByteData? byteData = await qrImage.toImageAsBytes(size: 200);
    Uint8List uint8list = byteData!.buffer.asUint8List();

    if (kIsWeb) {
      final String name = "${DateTime.now().millisecondsSinceEpoch}.png";
      final html.Blob blob = html.Blob([uint8list], "application/png");
      final String url = html.Url.createObjectUrlFromBlob(blob);

      final html.AnchorElement anchor = html.AnchorElement(href: url)
        ..setAttribute("download", name)
        ..click();
      html.Url.revokeObjectUrl(url);

      toastView(
        msg: "Barcode download process is complete",
        context: context,
      );
    } else {
      final dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String name = DateTime.now().millisecondsSinceEpoch.toString();

      final String path = "$dir/$name.png";
      final io.File file = io.File(path);
      await file.writeAsBytes(uint8list);

      showSnackbar(
          "Barcode", "Your barcode download successfully !", "$dir/$name.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: kIsWeb
          ? AppBarView(
              title: "",
              automaticallyImplyLeading: false,
            )
          : AppBarView(
              title: "Barcode",
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
            TextFieldView(
              title: "Any Text / URL",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: text,
              maxLines: 4,
              vertical: 4,
              hintText: "Hello genify user !!!",
              onChanged: (value) {
                generateQrCode(value);
              },
            ),
            SizedBox(
              height: 70,
            ),
            text.text.isEmpty
                ? SizedBox()
                : Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      child: RepaintBoundary(
                        key: qrKey,
                        child: PrettyQrView(
                          qrImage: qrImage,
                          decoration: const PrettyQrDecoration(),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 70,
            ),
            kIsWeb
                ? Align(
                    alignment: Alignment.centerRight,
                    child: ButtonView(
                      height: 45,
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Download",
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
                        if (text.text.isEmpty) {
                          toastView(
                            msg: "Please enter any detail",
                            context: context,
                          );
                        } else {
                          saveQrCode();
                        }
                      },
                    ),
                  )
                : ButtonView(
                    onTap: () {
                      if (text.text.isEmpty) {
                        toastView(
                          msg: "Please enter any detail",
                          context: context,
                        );
                      } else {
                        saveQrCode();
                      }
                    },
                    title: "Download",
                  ),
          ],
        ),
      ),
    );
  }
}
