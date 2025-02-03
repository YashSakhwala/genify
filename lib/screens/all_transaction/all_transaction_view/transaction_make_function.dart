// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_constructors, avoid_init_to_null, deprecated_member_use

import "dart:io" as io;
import "package:external_path/external_path.dart";
import "package:flutter/material.dart";
import "package:genify/widgets/common_widgets/indicatior.dart";
import "package:genify/widgets/common_widgets/toast_view.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import "package:universal_html/html.dart" as html;
import "package:flutter/foundation.dart";
import "../../../controller/auth_controller.dart";
import "../../../widgets/common_widgets/snackbar_view.dart";

class TransactionMake {
  static void generateStatement({
    required List allData,
    required String statementType,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();

    // String profit = "";
    // String loss = "";

    AuthController authController = Get.put(AuthController());

    final now = DateTime.now();
    final formattedDate = DateFormat("dd MMM, yyyy").format(now);
    double totalDebit = 0;
    double totalCredit = 0;

    for (var entry in allData) {
      for (var item in entry.value) {
        double amount = double.tryParse(item["amount"].toString()) ?? 0;

        if (item["type"] == "Expenses") {
          totalDebit += amount;
        } else if (item["type"] == "Incomes") {
          totalCredit += amount;
        }
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Align(
            alignment: pw.Alignment.center,
            child: pw.Text(
              "$statementType Statement",
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex("#03335e"),
              ),
            ),
          ),
          pw.SizedBox(
            height: 40,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Name",
                    style: pw.TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                    "Email",
                    style: pw.TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                    "Phone Number",
                    style: pw.TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                    "Date",
                    style: pw.TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                width: 30,
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    authController.userData["name"],
                    style: pw.TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                    authController.userData["email"],
                    style: pw.TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                    authController.userData["phoneNo"],
                    style: pw.TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                    formattedDate,
                    style: pw.TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(
            height: 30,
          ),
          pw.Table.fromTextArray(
            headers: ["Date", "Title", "Method", "Debit", "Credit"],
            data: [
              for (var entry in allData) ...[
                for (var item in entry.value)
                  [
                    item["date"],
                    item["type"] == "Incomes"
                        ? "Transfer From ${item["title"]}"
                        : "Transfer To ${item["title"]}",
                    item["payment"],
                    item["type"] == "Expenses" ? "- ${item["amount"]}" : "",
                    item["type"] == "Incomes" ? "+ ${item["amount"]}" : "",
                  ]
              ]
            ],
            border: pw.TableBorder.all(),
            cellAlignment: pw.Alignment.centerLeft,
            cellAlignments: {
              3: pw.Alignment.center,
              4: pw.Alignment.center,
            },
            columnWidths: {
              0: pw.FlexColumnWidth(1),
              1: pw.FlexColumnWidth(2),
              2: pw.FlexColumnWidth(1),
              3: pw.FlexColumnWidth(1),
              4: pw.FlexColumnWidth(1),
            },
            cellPadding: pw.EdgeInsets.all(7),
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

          // Total Row
          pw.Table.fromTextArray(
            data: [
              [
                "",
                "Total Debit/Credit",
                "",
                totalDebit.toStringAsFixed(2),
                totalCredit.toStringAsFixed(2),
              ],
            ],
            border: pw.TableBorder.all(),
            cellAlignments: {
              1: pw.Alignment.centerLeft,
              3: pw.Alignment.center,
              4: pw.Alignment.center,
            },
            columnWidths: {
              0: pw.FlexColumnWidth(1),
              1: pw.FlexColumnWidth(2),
              2: pw.FlexColumnWidth(1),
              3: pw.FlexColumnWidth(1),
              4: pw.FlexColumnWidth(1),
            },
            headerPadding: pw.EdgeInsets.all(7),
            headerStyle: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
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
        msg: "Statement download process is complete",
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

      showSnackbar("Statement", "Your statement download successfully !",
          "$dir/$name.pdf");

      Navigator.of(context).pop();
    }
  }
}
