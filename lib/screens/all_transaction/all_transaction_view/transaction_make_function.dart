// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_constructors, avoid_init_to_null, deprecated_member_use

import "dart:io" as io;
import "package:external_path/external_path.dart";
import "package:flutter/material.dart";
import "package:genify/widgets/common_widgets/indicatior.dart";
import "package:genify/widgets/common_widgets/toast_view.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import "package:universal_html/html.dart" as html;
import "package:flutter/foundation.dart";
import "../../../widgets/common_widgets/snackbar_view.dart";

class TransactionMake {
  static void generateStatement({
    required String name,
    required List allData,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();

    String profit = "";
    String loss = "";

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Text(name),
          pw.SizedBox(
            height: 20,
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
                    item["type"] == "Incomes"
                        ? "+ ${item["amount"]}"
                        : "- ${item["amount"]}",
                    "CREDIT",
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
                // pw.Row(
                //   mainAxisAlignment: pw.MainAxisAlignment.end,
                //   children: [
                //     pw.Image(
                //       rupeeIcon!,
                //       height: 14,
                //       width: 14,
                //     ),
                //     pw.Text(
                //       allData
                //           .map((item) {
                //             final itemQuantity =
                //                 int.tryParse(item["quantity"] ?? '') ?? 0;
                //             final itemPrice =
                //                 double.tryParse(item["price"] ?? '') ?? 0.0;
                //             return itemQuantity * itemPrice;
                //           })
                //           .reduce((a, b) => a + b)
                //           .toStringAsFixed(2),
                //       style: pw.TextStyle(
                //         fontSize: 16,
                //         fontWeight: pw.FontWeight.bold,
                //         color: PdfColor.fromHex("#03335e"),
                //       ),
                //     ),
                //   ],
                // ),
                // pw.SizedBox(
                //   height: 5,
                // ),
                // pw.Container(
                //   height: 1.5,
                //   width: 80,
                //   color: PdfColor.fromHex("#03335e"),
                // ),
              ],
            ),
          ),
          pw.SizedBox(
            height: 40,
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
