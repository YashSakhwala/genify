// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_constructors, avoid_init_to_null, deprecated_member_use

import "dart:convert";
import "dart:io" as io;
import "package:external_path/external_path.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:genify/widgets/common_widgets/indicatior.dart";
import "package:genify/widgets/common_widgets/toast_view.dart";
import "package:intl/intl.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import "package:universal_html/html.dart" as html;
import "package:flutter/foundation.dart";

class InvoiceMake {
  static String imagePath = "";
  static html.File? webImageFile = null;

  static String signatureImagePath = "";
  static html.File? signatureWebImageFile = null;

  static void generateInvoice({
    required String companyName,
    required String gstNumber,
    required String companyEmail,
    required String companyPhoneNo,
    required String address,
    required String clientName,
    required String clientEmail,
    required String clientPhoneNo,
    required List<Map<String, String>> items,
    required BuildContext context,
  }) async {
    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? signatureImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;
    pw.MemoryImage? dateIcon;
    pw.MemoryImage? timeIcon;

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

    if (kIsWeb && signatureWebImageFile != null) {
      final file = signatureWebImageFile!;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);

      await reader.onLoad.first;
      final encoded = reader.result as String;
      final data = base64Decode(encoded.split(",").last);

      signatureImage = pw.MemoryImage(data);
    } else if (signatureImagePath.isNotEmpty) {
      try {
        io.File signatureFile = io.File(signatureImagePath);
        Uint8List signatureBytes = await signatureFile.readAsBytes();
        signatureImage = pw.MemoryImage(signatureBytes);
      } catch (e) {
        signatureImage = null;
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
      dateIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/black_date.png"))
            .buffer
            .asUint8List(),
      );
      timeIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/black_time.png"))
            .buffer
            .asUint8List(),
      );
    } catch (e) {
      addressIcon = null;
      phoneIcon = null;
      emailIcon = null;
      dateIcon = null;
      timeIcon = null;
    }

    final now = DateTime.now();
    final formattedDate = DateFormat("dd-MM-yyyy").format(now);
    final formattedTime = DateFormat("hh:mm a").format(now);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              if (image != null)
                pw.Image(
                  image,
                  height: 120,
                  width: 120,
                ),
              pw.Spacer(),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    companyName,
                    style: pw.TextStyle(
                      fontSize: 30,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex("#03335e"),
                    ),
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        gstNumber,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      pw.SizedBox(
                        width: 8,
                      ),
                      pw.Text(
                        "GST",
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex("#03335e"),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 7,
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        companyEmail,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      pw.SizedBox(
                        width: 8,
                      ),
                      pw.Image(
                        emailIcon!,
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 7,
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        "+91 $companyPhoneNo",
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      pw.SizedBox(
                        width: 8,
                      ),
                      pw.Image(
                        phoneIcon!,
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 7,
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        address,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      pw.SizedBox(
                        width: 8,
                      ),
                      pw.Image(
                        addressIcon!,
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(
            height: 20,
          ),
          pw.Container(
            height: 1.5,
            width: double.infinity,
            color: PdfColor.fromHex("#03335e"),
          ),
          pw.SizedBox(
            height: 20,
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "To: ",
                    style: pw.TextStyle(
                      fontSize: 15,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex("#03335e"),
                    ),
                  ),
                  pw.SizedBox(
                    width: 10,
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        clientName,
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex("#03335e"),
                        ),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        children: [
                          pw.Image(
                            emailIcon,
                            height: 10,
                            width: 10,
                          ),
                          pw.SizedBox(
                            width: 8,
                          ),
                          pw.Text(
                            clientEmail,
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 7,
                      ),
                      pw.Row(
                        children: [
                          pw.Image(
                            phoneIcon,
                            height: 10,
                            width: 10,
                          ),
                          pw.SizedBox(
                            width: 8,
                          ),
                          pw.Text(
                            "+91 $clientPhoneNo",
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Row(
                    children: [
                      pw.Text(
                        formattedDate,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      pw.SizedBox(
                        width: 8,
                      ),
                      pw.Image(
                        dateIcon!,
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 7,
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        formattedTime,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      pw.SizedBox(
                        width: 8,
                      ),
                      pw.Image(
                        timeIcon!,
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(
            height: 40,
          ),
          pw.Table.fromTextArray(
            headers: ["Item No", "Item Name", "Quantity", "Price", "Total"],
            data: List<List<String>>.generate(items.length, (index) {
              final item = items[index];
              final itemNo = (index + 1).toString();
              final itemName = item["name"] ?? '';
              final itemQuantity = int.tryParse(item["quantity"] ?? '') ?? 0;
              final itemPrice = double.tryParse(item["price"] ?? '') ?? 0.0;
              final total = itemQuantity * itemPrice;
              return [
                itemNo,
                itemName,
                itemQuantity.toString(),
                itemPrice.toStringAsFixed(2),
                total.toStringAsFixed(2)
              ];
            }),
            border: pw.TableBorder.all(),
            cellAlignment: pw.Alignment.center,
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex("#ffffff"),
            ),
            headerDecoration: pw.BoxDecoration(
              color: PdfColor.fromHex("#03335e"),
            ),
            cellStyle: pw.TextStyle(
              fontSize: 12,
            ),
          ),
          pw.SizedBox(
            height: 20,
          ),
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  "Total",
                  style: pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Text(
                  "₹${items.map((item) {
                        final itemQuantity =
                            int.tryParse(item["quantity"] ?? '') ?? 0;
                        final itemPrice =
                            double.tryParse(item["price"] ?? '') ?? 0.0;
                        return itemQuantity * itemPrice;
                      }).reduce((a, b) => a + b).toStringAsFixed(2)}",
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex("#03335e"),
                  ),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Container(
                  height: 1.5,
                  width: 80,
                  color: PdfColor.fromHex("#03335e"),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            height: 50,
          ),
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Column(
              children: [
                pw.RichText(
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        text: 'For, ',
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.TextSpan(
                        text: companyName,
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex("#03335e"),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  height: 10,
                ),
                if (signatureImage != null)
                  pw.Image(
                    signatureImage,
                    height: 70,
                    width: 120,
                  ),
                pw.SizedBox(
                  height: 7,
                ),
                pw.Container(
                  height: 1.5,
                  width: 120,
                  color: PdfColor.fromHex("#03335e"),
                ),
                pw.Text(
                  "Authorised Signature",
                  style: pw.TextStyle(
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
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
