// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously

import "dart:io" as io;
import "package:external_path/external_path.dart";
import "package:flutter/material.dart";
import "package:genify/widgets/common_widgets/indicatior.dart";
import "package:genify/widgets/common_widgets/toast_view.dart";
import "package:intl/intl.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import "package:universal_html/html.dart" as html;
import 'package:http/http.dart' as http;
import "package:flutter/foundation.dart";
import "../../../widgets/common_widgets/snackbar_view.dart";

class SalaryMake {
  static String signatureImagePath = "";

  static void generateSalarySlip({
    required String companyName,
    required String employeeName,
    required String employeeID,
    required String department,
    required String designation,
    required String salary,
    required String mealAllowance,
    required String transportationAllowance,
    required String medicalAllowance,
    required String retirementInsurance,
    required String tax,
    required String paymentMethod,
    String? bankName,
    String? bankAccountNumber,
    String? upiID,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? signatureImage;

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

    final now = DateTime.now();
    final formattedDate = DateFormat("MMMM dd, yyyy").format(now);
    final formattedMonth = DateFormat("MMMM yyyy").format(now);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Column(
              children: [
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text(
                  companyName,
                  style: pw.TextStyle(
                    fontSize: 25,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex("#03335e"),
                  ),
                ),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Text(
                  formattedMonth,
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(),
                        ),
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text("Name:  $employeeName"),
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Text("Employee ID:  $employeeID"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border(
                            top: pw.BorderSide(),
                          ),
                        ),
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text("Department:  $department"),
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Text("Designation:  $designation"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: double.infinity,
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex("#03335e"),
                            ),
                            child: pw.Padding(
                              padding: pw.EdgeInsets.all(5),
                              child: pw.Text(
                                "Description",
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#ffffff"),
                                ),
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(left: 15),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "Basic Salary",
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Text(
                                  "Meal Allowance",
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Text(
                                  "Transportaion Allowance",
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Text(
                                  "Medical Allowance",
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Text(
                                  "Retirement Insurance",
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Text(
                                  "Tax",
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(
                            height: 100,
                          ),
                          pw.Container(
                            width: double.infinity,
                            decoration: pw.BoxDecoration(
                              border: pw.Border(
                                top: pw.BorderSide(),
                              ),
                            ),
                            child: pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: pw.Text("Total"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      height: 292,
                      width: 1,
                      color: PdfColor.fromHex("#000000"),
                    ),
                    pw.Expanded(
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Container(
                                  width: double.infinity,
                                  decoration: pw.BoxDecoration(
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text(
                                      "Earnings",
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromHex("#ffffff"),
                                      ),
                                      textAlign: pw.TextAlign.center,
                                    ),
                                  ),
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(right: 15),
                                  child: pw.Column(
                                    children: [
                                      pw.Text(
                                        salary,
                                      ),
                                      pw.SizedBox(
                                        height: 10,
                                      ),
                                      pw.Text(
                                        mealAllowance,
                                      ),
                                      pw.SizedBox(
                                        height: 10,
                                      ),
                                      pw.Text(
                                        transportationAllowance,
                                      ),
                                      pw.SizedBox(
                                        height: 10,
                                      ),
                                      pw.Text(
                                        medicalAllowance,
                                      ),
                                    ],
                                  ),
                                ),
                                pw.SizedBox(
                                  height: 148,
                                ),
                                pw.Container(
                                  width: double.infinity,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                      top: pw.BorderSide(),
                                    ),
                                  ),
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: pw.Text(
                                      (double.parse(salary) +
                                              double.parse(mealAllowance) +
                                              double.parse(
                                                  transportationAllowance) +
                                              double.parse(medicalAllowance))
                                          .toStringAsFixed(2),
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                      textAlign: pw.TextAlign.end,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            height: 292,
                            width: 1,
                            color: PdfColor.fromHex("#000000"),
                          ),
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Container(
                                  width: double.infinity,
                                  decoration: pw.BoxDecoration(
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.all(5),
                                    child: pw.Text(
                                      "Deductions",
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromHex("#ffffff"),
                                      ),
                                      textAlign: pw.TextAlign.center,
                                    ),
                                  ),
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(right: 15),
                                  child: pw.Column(
                                    children: [
                                      pw.SizedBox(
                                        height: 100,
                                      ),
                                      pw.Text(
                                        retirementInsurance,
                                      ),
                                      pw.SizedBox(
                                        height: 10,
                                      ),
                                      pw.Text(
                                        tax,
                                      ),
                                    ],
                                  ),
                                ),
                                pw.SizedBox(
                                  height: 96,
                                ),
                                pw.Container(
                                  width: double.infinity,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border(
                                      top: pw.BorderSide(),
                                    ),
                                  ),
                                  child: pw.Padding(
                                    padding: pw.EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: pw.Text(
                                      (double.parse(retirementInsurance) +
                                              double.parse(tax))
                                          .toStringAsFixed(2),
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                      textAlign: pw.TextAlign.end,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Container(
                        height: 130.6,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(),
                        ),
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Payment Date:  $formattedDate",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Text(
                                "Payment Method:  $paymentMethod",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              paymentMethod == "Bank Transfer"
                                  ? pw.Text(
                                      "Bank Name:  $bankName",
                                      style: pw.TextStyle(fontSize: 10),
                                    )
                                  : paymentMethod == "UPI Payment"
                                      ? pw.Text(
                                          "UPI ID:  $upiID",
                                          style: pw.TextStyle(fontSize: 10),
                                        )
                                      : pw.Text(
                                          "Borrower name:  $employeeName",
                                          style: pw.TextStyle(fontSize: 10),
                                        ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              paymentMethod == "Bank Transfer"
                                  ? pw.Row(
                                      children: [
                                        pw.Text(
                                          "Bank Account Name:  ",
                                          style: pw.TextStyle(fontSize: 10),
                                        ),
                                        pw.Expanded(
                                          child: pw.Text(
                                            employeeName,
                                            style: pw.TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    )
                                  : pw.SizedBox(),
                              pw.SizedBox(
                                height: 7,
                              ),
                              paymentMethod == "Bank Transfer"
                                  ? pw.Text(
                                      "Bank Account Number:  $bankAccountNumber",
                                      style: pw.TextStyle(fontSize: 10),
                                    )
                                  : pw.SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        height: 130.6,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: double.infinity,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(),
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              child: pw.Padding(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: pw.Text(
                                  "NET PAY",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromHex("#ffffff"),
                                  ),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                            ),
                            pw.Container(
                              width: double.infinity,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(),
                              ),
                              child: pw.Padding(
                                padding: pw.EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: pw.Text(
                                  (double.parse(salary) +
                                          double.parse(mealAllowance) +
                                          double.parse(
                                              transportationAllowance) +
                                          double.parse(medicalAllowance) -
                                          (double.parse(retirementInsurance) +
                                              double.parse(tax)))
                                      .toStringAsFixed(2),
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                            ),
                            pw.SizedBox(
                              height: signatureImage != null ? 10 : 55,
                            ),
                            if (signatureImage != null)
                              pw.Container(
                                height: 47,
                                width: 120,
                                decoration: pw.BoxDecoration(
                                  color: PdfColor.fromHex("#FFFF00"),
                                  image: pw.DecorationImage(
                                    image: pw.Image(
                                      signatureImage,
                                      height: 47,
                                      width: 120,
                                      fit: pw.BoxFit.cover,
                                    ).image,
                                  ),
                                ),
                              ),
                            pw.SizedBox(
                              height: 7,
                            ),
                            pw.Container(
                              height: 1.5,
                              width: 140,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                            pw.Text(
                              "Authorised Signature",
                              style: pw.TextStyle(
                                fontSize: 9,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
    if (kIsWeb) {
      final String name = "${DateTime.now().millisecondsSinceEpoch}.pdf";
      final html.Blob blob = html.Blob([uint8list], "application/pdf");
      final String url = html.Url.createObjectUrlFromBlob(blob);

      final html.AnchorElement anchor = html.AnchorElement(href: url)
        ..setAttribute("download", name)
        ..click();
      html.Url.revokeObjectUrl(url);

      toastView(
        msg: "Salary slip download process is complete",
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

      showSnackbar(
        "Salary Slip",
        "Your salary slip download successfully !",
        "$dir/$name.pdf",
      );

      Navigator.of(context).pop();
    }
  }
}
