// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_constructors, avoid_init_to_null, deprecated_member_use

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
import 'package:http/http.dart' as http;
import "package:flutter/foundation.dart";
import "../../../widgets/common_widgets/snackbar_view.dart";

class IncomeMake {
  static String imagePath = "";
  static String signatureImagePath = "";

  static void generateIncome({
    required String companyName,
    required String gstNumber,
    required String companyEmail,
    required String companyPhoneNo,
    required String tax,
    required List revenues,
    required List cgs,
    required List expenses,
    List? otherIncomes,
    List? otherExpenses,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? signatureImage;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;
    pw.MemoryImage? dateIcon;
    pw.MemoryImage? timeIcon;
    pw.MemoryImage? rupeeIcon;

    if (imagePath.isNotEmpty) {
      if (kIsWeb) {
        try {
          final response = await http.get(Uri.parse(imagePath));
          Uint8List imageBytes = response.bodyBytes;
          image = pw.MemoryImage(imageBytes);
        } catch (e) {
          image = null;
        }
      } else {
        try {
          io.File imageFile = io.File(imagePath);
          Uint8List imageBytes = await imageFile.readAsBytes();
          image = pw.MemoryImage(imageBytes);
        } catch (e) {
          image = null;
        }
      }
    }

    if (signatureImagePath.isNotEmpty) {
      if (kIsWeb) {
        try {
          final response = await http.get(Uri.parse(signatureImagePath));
          Uint8List imageBytes = response.bodyBytes;
          signatureImage = pw.MemoryImage(imageBytes);
        } catch (e) {
          signatureImage = null;
        }
      } else {
        try {
          io.File imageFile = io.File(signatureImagePath);
          Uint8List imageBytes = await imageFile.readAsBytes();
          signatureImage = pw.MemoryImage(imageBytes);
        } catch (e) {
          signatureImage = null;
        }
      }
    }

    try {
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
      rupeeIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/rupee.png")).buffer.asUint8List(),
      );
    } catch (e) {
      phoneIcon = null;
      emailIcon = null;
      dateIcon = null;
      timeIcon = null;
      rupeeIcon = null;
    }

    final now = DateTime.now();
    final formattedDate = DateFormat("dd-MM-yyyy").format(now);
    // final formattedTime = DateFormat("hh:mm a").format(now);

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
                  height: 60,
                  width: 60,
                  fit: pw.BoxFit.fill,
                ),
              pw.Spacer(),
              pw.Text(
                companyName,
                style: pw.TextStyle(
                  fontSize: 30,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex("#03335e"),
                ),
              ),
              pw.Spacer(),
            ],
          ),
          pw.SizedBox(
            height: 10,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  pw.Text(
                    "GST",
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex("#03335e"),
                    ),
                  ),
                  pw.SizedBox(
                    width: 8,
                  ),
                  pw.Text(
                    gstNumber,
                    style: pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              pw.Text(
                "For the Year Ended December 31, 2024",
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Column(
                children: [
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
          pw.Table.fromTextArray(
            headers: ["Items", "Amount (₹)"],
            data: [
              // Revenues
              ...List.generate(revenues.length, (index) {
                final revenue = revenues[index];
                final revenueName = revenue["name"] ?? '';
                final itemPrice =
                    double.tryParse(revenue["price"] ?? '') ?? 0.0;

                return [
                  index == 0 ? "$revenueName" : "   $revenueName",
                  index == 0 ? "" : itemPrice.toStringAsFixed(2),
                ];
              }),
              [
                "     Total Revenue",
                revenues
                    .fold(
                        0.0,
                        (sum, item) =>
                            sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
                    .toStringAsFixed(2)
              ],

              // COGS
              ...List.generate(cgs.length, (index) {
                final cogsItem = cgs[index];
                final cogsName = cogsItem["name"] ?? '';
                final itemPrice =
                    double.tryParse(cogsItem["price"] ?? '') ?? 0.0;

                return [
                  index == 0 ? "$cogsName" : "   $cogsName",
                  index == 0 ? "" : itemPrice.toStringAsFixed(2),
                ];
              }),
              [
                "     Total COGS",
                cgs
                    .fold(
                        0.0,
                        (sum, item) =>
                            sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
                    .toStringAsFixed(2)
              ],

              // Expenses
              ...List.generate(expenses.length, (index) {
                final expense = expenses[index];
                final expenseName = expense["name"] ?? '';
                final itemPrice =
                    double.tryParse(expense["price"] ?? '') ?? 0.0;

                return [
                  index == 0 ? "$expenseName" : "   $expenseName",
                  index == 0 ? "" : itemPrice.toStringAsFixed(2),
                ];
              }),
              [
                "     Total Expenses",
                expenses
                    .fold(
                        0.0,
                        (sum, item) =>
                            sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
                    .toStringAsFixed(2)
              ],

              // Other Incomes
              ...List.generate(otherIncomes!.length, (index) {
                final otherIncome = otherIncomes[index];
                final incomeName = otherIncome["name"] ?? '';
                final itemPrice =
                    double.tryParse(otherIncome["price"] ?? '') ?? 0.0;

                return [
                  index == 0 ? "$incomeName" : "   $incomeName",
                  index == 0 ? "" : itemPrice.toStringAsFixed(2),
                ];
              }),
              [
                "     Total Other Income",
                otherIncomes
                    .fold(
                        0.0,
                        (sum, item) =>
                            sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
                    .toStringAsFixed(2)
              ],

              // Other Expenses
              ...List.generate(otherExpenses!.length, (index) {
                final otherExpense = otherExpenses[index];
                final expenseName = otherExpense["name"] ?? '';
                final itemPrice =
                    double.tryParse(otherExpense["price"] ?? '') ?? 0.0;

                return [
                  index == 0 ? "$expenseName" : "   $expenseName",
                  index == 0 ? "" : itemPrice.toStringAsFixed(2),
                ];
              }),
              [
                "     Total Other Expenses",
                otherExpenses
                    .fold(
                        0.0,
                        (sum, item) =>
                            sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
                    .toStringAsFixed(2)
              ],

              // Totals and Summary

              ["Tax", double.tryParse(tax)!.toStringAsFixed(2)],
              [
                "Profit/Loss",
                (revenues.fold(
                            0.0,
                            (sum, item) =>
                                sum +
                                (double.tryParse(item["price"] ?? '') ?? 0.0)) -
                        cgs.fold(
                            0.0,
                            (sum, item) =>
                                sum +
                                (double.tryParse(item["price"] ?? '') ?? 0.0)) -
                        expenses.fold(
                            0.0,
                            (sum, item) =>
                                sum +
                                (double.tryParse(item["price"] ?? '') ?? 0.0)) +
                        otherIncomes.fold(
                            0.0,
                            (sum, item) =>
                                sum +
                                (double.tryParse(item["price"] ?? '') ?? 0.0)) -
                        otherExpenses.fold(
                            0.0,
                            (sum, item) =>
                                sum +
                                (double.tryParse(item["price"] ?? '') ?? 0.0)) -
                        double.tryParse(tax)!)
                    .toStringAsFixed(2)
              ]
            ],
            // border: pw.TableBorder.all(),
            oddRowDecoration: pw.BoxDecoration(
              color: PdfColor.fromHex("#F7F1D9"),
            ),
            columnWidths: {
              0: pw.FlexColumnWidth(2),
              1: pw.FlexColumnWidth(1),
            },
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
            height: 40,
          ),
          pw.Align(
            alignment: pw.Alignment.topRight,
            child: pw.Column(
              children: [
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
    if (kIsWeb) {
      final String name = "${DateTime.now().millisecondsSinceEpoch}.pdf";
      final html.Blob blob = html.Blob([uint8list], "application/pdf");
      final String url = html.Url.createObjectUrlFromBlob(blob);

      final html.AnchorElement anchor = html.AnchorElement(href: url)
        ..setAttribute("download", name)
        ..click();
      html.Url.revokeObjectUrl(url);

      toastView(
        msg: "Income statement download process is complete",
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

      showSnackbar("Income statement",
          "Your income statement download successfully !", "$dir/$name.pdf");

      Navigator.of(context).pop();
    }
  }
}
