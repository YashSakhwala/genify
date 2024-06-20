// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_constructors, avoid_init_to_null, deprecated_member_use

import "dart:convert";
import "dart:io" as io;
import "package:external_path/external_path.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:genify/widgets/common_widgets/indicatior.dart";
import "package:genify/widgets/common_widgets/toast_view.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import "package:universal_html/html.dart" as html;
import "package:flutter/foundation.dart";

class CardMake {
  static String imagePath = "";
  static html.File? webImageFile = null;

  static void generateCard({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required BuildContext context,
  }) async {
    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    if (kIsWeb && webImageFile != null) {
      final file = webImageFile!;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);

      await reader.onLoad.first;
      final encoded = reader.result as String;
      final data = base64Decode(encoded.split(",").last);

      image = pw.MemoryImage(data);
    } else if (imagePath.isNotEmpty) {
      try {
        io.File imageFile = io.File(imagePath);
        Uint8List imageBytes = await imageFile.readAsBytes();
        image = pw.MemoryImage(imageBytes);
      } catch (e) {
        image = null;
      }
    }

    try {
      addressIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/black_location.png"))
            .buffer
            .asUint8List(),
      );
      phoneIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/black_phone.png"))
            .buffer
            .asUint8List(),
      );
      emailIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/black_email.png"))
            .buffer
            .asUint8List(),
      );
    } catch (e) {
      addressIcon = null;
      phoneIcon = null;
      emailIcon = null;
    }

    pdf.addPage(
      pw.Page(
        pageFormat:
            PdfPageFormat(3.5 * PdfPageFormat.inch, 2 * PdfPageFormat.inch),
        build: (pw.Context context) {
          return pw.Row(
            children: [
              pw.SizedBox(
                width: 10,
              ),
              pw.Container(
                height: 110,
                width: 100,
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(10),
                  image: pw.DecorationImage(
                    image: pw.Image(
                      image!,
                      height: 100,
                      width: 100,
                      fit: pw.BoxFit.fill,
                    ).image,
                  ),
                ),
              ),
              pw.SizedBox(
                width: 10,
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(vertical: 10),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      name,
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromHex("#03335e"),
                      ),
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Text(
                      profession,
                      style: pw.TextStyle(
                        fontSize: 6,
                      ),
                    ),
                    pw.SizedBox(
                      height: 30,
                    ),
                    pw.Row(
                      children: [
                        pw.Image(
                          phoneIcon!,
                          height: 5,
                          width: 5,
                        ),
                        pw.SizedBox(
                          width: 5,
                        ),
                        pw.Text(
                          "+91 $phoneNo",
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Row(
                      children: [
                        pw.Image(
                          emailIcon!,
                          height: 5,
                          width: 5,
                        ),
                        pw.SizedBox(
                          width: 5,
                        ),
                        pw.Text(
                          email,
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Row(
                      children: [
                        pw.Image(
                          addressIcon!,
                          height: 5,
                          width: 5,
                        ),
                        pw.SizedBox(
                          width: 5,
                        ),
                        pw.Text(
                          address,
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    Uint8List data = await pdf.save();

    await pdfSave(
      context: context,
      uint8list: data,
    );
  }

  static Future pdfSave({
    required BuildContext context,
    required Uint8List uint8list,
  }) async {
    showIndicator(context);

    if (kIsWeb) {
      final String name = "${DateTime.now().millisecondsSinceEpoch}.pdf";
      final html.Blob blob = html.Blob([uint8list], "application/pdf");
      final String url = html.Url.createObjectUrlFromBlob(blob);

      final html.AnchorElement anchor = html.AnchorElement(href: url)
        ..setAttribute("download", name)
        ..click();
      html.Url.revokeObjectUrl(url);

      toastView(
        msg: "Resume download process is complete",
        context: context,
      );

      Navigator.of(context).pop();
    } else {
      final dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String name = DateTime.now().millisecondsSinceEpoch.toString();

      final String path = "$dir/$name.pdf";
      final io.File file = io.File(path);
      await file.writeAsBytes(uint8list);

      toastView(
        msg: "Resume download process is complete",
        context: context,
      );

      Navigator.of(context).pop();
    }
  }
}
