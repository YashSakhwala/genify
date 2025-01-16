// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_constructors, avoid_init_to_null, deprecated_member_use

import "dart:io" as io;
import "package:external_path/external_path.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:genify/widgets/common_widgets/indicatior.dart";
import "package:genify/widgets/common_widgets/toast_view.dart";
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
    required String taxType,
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

    if (otherIncomes!.length == 1) {
      otherIncomes = [];
    }

    if (otherExpenses!.length == 1) {
      otherExpenses = [];
    }

    String totalRevenue = revenues
        .fold(0.0,
            (sum, item) => sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
        .toStringAsFixed(2);

    String totalCgs = cgs
        .fold(0.0,
            (sum, item) => sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
        .toStringAsFixed(2);

    String totalExpense = expenses
        .fold(0.0,
            (sum, item) => sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
        .toStringAsFixed(2);

    String totalOtherIncome = otherIncomes
        .fold(0.0,
            (sum, item) => sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
        .toStringAsFixed(2);

    String totalOtherExpense = otherExpenses
        .fold(0.0,
            (sum, item) => sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
        .toStringAsFixed(2);

    var beforeTax = (double.tryParse(totalRevenue))! -
        (double.tryParse(totalCgs))! -
        (double.tryParse(totalExpense))! +
        (double.tryParse(totalOtherIncome))! -
        (double.tryParse(totalOtherExpense))!;

    double finalTax = taxType == "taxPercentage"
        ? (beforeTax * double.tryParse(tax)!) / 100
        : double.tryParse(tax)!;

    double finalTotal = beforeTax - finalTax;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        build: (pw.Context context) => [
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
            ),
            child: pw.Column(
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    if (image != null)
                      pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Image(
                          image,
                          height: 60,
                          width: 60,
                          fit: pw.BoxFit.fill,
                        ),
                      ),
                    pw.Spacer(),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(10),
                      child: pw.Text(
                        companyName,
                        style: pw.TextStyle(
                          fontSize: 30,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex("#03335e"),
                        ),
                      ),
                    ),
                    pw.Spacer(),
                    if (image != null)
                      pw.SizedBox(
                        width: 70,
                      ),
                  ],
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
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Row(
                                children: [
                                  pw.Text(
                                    "Date",
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
                                    "For the Year Ended December 31, 2024",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                              pw.Row(
                                children: [
                                  pw.Image(
                                    emailIcon!,
                                    height: 10,
                                    width: 10,
                                  ),
                                  pw.SizedBox(
                                    width: 8,
                                  ),
                                  pw.Text(
                                    companyEmail,
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
                                    phoneIcon!,
                                    height: 10,
                                    width: 10,
                                  ),
                                  pw.SizedBox(
                                    width: 8,
                                  ),
                                  pw.Text(
                                    "+91 $companyPhoneNo",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(
                  height: 15,
                ),

                // Revenues
                pw.Table.fromTextArray(
                  headers: ["Items", "Amount"],
                  data: [
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
                  ],
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

                // Total Revenue
                pw.Table.fromTextArray(
                  data: [
                    [
                      "       Total Revenue",
                      totalRevenue,
                    ],
                  ],
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(1),
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft
                  },
                  border: pw.TableBorder.all(
                    width: 1.7,
                  ),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F8F7F4"),
                  ),
                  headerStyle: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                // COGS
                pw.Table.fromTextArray(
                  data: [
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
                  ],
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(1),
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft
                  },
                ),

                // Total COGS
                pw.Table.fromTextArray(
                  data: [
                    [
                      "       Total COGS",
                      totalCgs,
                    ],
                  ],
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(1),
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft
                  },
                  border: pw.TableBorder.all(
                    width: 1.7,
                  ),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F8F7F4"),
                  ),
                  headerStyle: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                // Expenses
                pw.Table.fromTextArray(
                  data: [
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
                  ],
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(1),
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft
                  },
                ),

                // Total Expenses
                pw.Table.fromTextArray(
                  data: [
                    [
                      "       Total Expenses",
                      totalExpense,
                    ],
                  ],
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(1),
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft
                  },
                  border: pw.TableBorder.all(
                    width: 1.7,
                  ),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F8F7F4"),
                  ),
                  headerStyle: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                // Other Incomes
                pw.Table.fromTextArray(
                  data: [
                    ...List.generate(otherIncomes!.length, (index) {
                      final otherIncome = otherIncomes![index];
                      final incomeName = otherIncome["name"] ?? '';
                      final itemPrice =
                          double.tryParse(otherIncome["price"] ?? '') ?? 0.0;

                      return [
                        index == 0 ? "$incomeName" : "   $incomeName",
                        index == 0 ? "" : itemPrice.toStringAsFixed(2),
                      ];
                    }),
                  ],
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(1),
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft
                  },
                ),

                // Total Other Incomes
                if (otherIncomes.isNotEmpty)
                  pw.Table.fromTextArray(
                    data: [
                      [
                        "       Total Other Income",
                        totalOtherIncome,
                      ],
                    ],
                    columnWidths: {
                      0: pw.FlexColumnWidth(2),
                      1: pw.FlexColumnWidth(1),
                    },
                    cellAlignments: {
                      0: pw.Alignment.centerLeft,
                      1: pw.Alignment.centerLeft
                    },
                    border: pw.TableBorder.all(
                      width: 1.7,
                    ),
                    headerDecoration: pw.BoxDecoration(
                      color: PdfColor.fromHex("#F8F7F4"),
                    ),
                    headerStyle: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),

                // Other Expenses
                pw.Table.fromTextArray(
                  data: [
                    ...List.generate(otherExpenses!.length, (index) {
                      final otherExpense = otherExpenses![index];
                      final expenseName = otherExpense["name"] ?? '';
                      final itemPrice =
                          double.tryParse(otherExpense["price"] ?? '') ?? 0.0;

                      return [
                        index == 0 ? "$expenseName" : "   $expenseName",
                        index == 0 ? "" : itemPrice.toStringAsFixed(2),
                      ];
                    }),
                  ],
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(1),
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft
                  },
                ),

                // Total Other Expenses
                if (otherExpenses.isNotEmpty)
                  pw.Table.fromTextArray(
                    data: [
                      [
                        "       Total Other Expenses",
                        totalOtherExpense,
                      ],
                    ],
                    columnWidths: {
                      0: pw.FlexColumnWidth(2),
                      1: pw.FlexColumnWidth(1),
                    },
                    cellAlignments: {
                      0: pw.Alignment.centerLeft,
                      1: pw.Alignment.centerLeft
                    },
                    border: pw.TableBorder.all(
                      width: 1.7,
                    ),
                    headerDecoration: pw.BoxDecoration(
                      color: PdfColor.fromHex("#F8F7F4"),
                    ),
                    headerStyle: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),

                // Tax, Profit/loss
                pw.Table.fromTextArray(
                  data: [
                    [
                      "Tax ${taxType == "taxPercentage" ? "($tax%)" : ""}",
                      finalTax.toStringAsFixed(2),
                    ],
                    [
                      finalTotal < 0 ? "Net Loss" : "Net Profit",
                      finalTotal.toStringAsFixed(2),
                    ]
                  ],
                  columnWidths: {
                    0: pw.FlexColumnWidth(2),
                    1: pw.FlexColumnWidth(1),
                  },
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerLeft
                  },
                  border: pw.TableBorder.all(
                    width: 1.7,
                  ),
                  rowDecoration: pw.BoxDecoration(
                    color: PdfColor.fromHex("#F8F7F4"),
                  ),
                  cellStyle: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(
                  height: 40,
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(10),
                  child: pw.Align(
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



// pw.Table.fromTextArray(
//             headers: ["Items", "Amount (₹)"],
//             data: [
//               // Revenues
//               ...List.generate(revenues.length, (index) {
//                 final revenue = revenues[index];
//                 final revenueName = revenue["name"] ?? '';
//                 final itemPrice =
//                     double.tryParse(revenue["price"] ?? '') ?? 0.0;

//                 return [
//                   index == 0 ? "$revenueName" : "   $revenueName",
//                   index == 0 ? "" : itemPrice.toStringAsFixed(2),
//                 ];
//               }),

//               // COGS
              // ...List.generate(cgs.length, (index) {
              //   final cogsItem = cgs[index];
              //   final cogsName = cogsItem["name"] ?? '';
              //   final itemPrice =
              //       double.tryParse(cogsItem["price"] ?? '') ?? 0.0;

              //   return [
              //     index == 0 ? "$cogsName" : "   $cogsName",
              //     index == 0 ? "" : itemPrice.toStringAsFixed(2),
              //   ];
              // }),

//               // Expenses
              // ...List.generate(expenses.length, (index) {
              //   final expense = expenses[index];
              //   final expenseName = expense["name"] ?? '';
              //   final itemPrice =
              //       double.tryParse(expense["price"] ?? '') ?? 0.0;

              //   return [
              //     index == 0 ? "$expenseName" : "   $expenseName",
              //     index == 0 ? "" : itemPrice.toStringAsFixed(2),
              //   ];
              // }),

//               // Other Incomes
              // ...List.generate(otherIncomes!.length, (index) {
              //   final otherIncome = otherIncomes[index];
              //   final incomeName = otherIncome["name"] ?? '';
              //   final itemPrice =
              //       double.tryParse(otherIncome["price"] ?? '') ?? 0.0;

              //   return [
              //     index == 0 ? "$incomeName" : "   $incomeName",
              //     index == 0 ? "" : itemPrice.toStringAsFixed(2),
              //   ];
              // }),
//               [
                // "     Total Other Income",
                // otherIncomes
                //     .fold(
                //         0.0,
                //         (sum, item) =>
                //             sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
                //     .toStringAsFixed(2)
//               ],

//               // Other Expenses
              // ...List.generate(otherExpenses!.length, (index) {
              //   final otherExpense = otherExpenses[index];
              //   final expenseName = otherExpense["name"] ?? '';
              //   final itemPrice =
              //       double.tryParse(otherExpense["price"] ?? '') ?? 0.0;

              //   return [
              //     index == 0 ? "$expenseName" : "   $expenseName",
              //     index == 0 ? "" : itemPrice.toStringAsFixed(2),
              //   ];
              // }),
//               [
                // "     Total Other Expenses",
                // otherExpenses
                //     .fold(
                //         0.0,
                //         (sum, item) =>
                //             sum + (double.tryParse(item["price"] ?? '') ?? 0.0))
                //     .toStringAsFixed(2)
//               ],

              // ["Tax", double.tryParse(tax)!.toStringAsFixed(2)],
              // [
              //   "Profit/Loss",
              //   (revenues.fold(
              //               0.0,
              //               (sum, item) =>
              //                   sum +
              //                   (double.tryParse(item["price"] ?? '') ?? 0.0)) -
              //           cgs.fold(
              //               0.0,
              //               (sum, item) =>
              //                   sum +
              //                   (double.tryParse(item["price"] ?? '') ?? 0.0)) -
              //           expenses.fold(
              //               0.0,
              //               (sum, item) =>
              //                   sum +
              //                   (double.tryParse(item["price"] ?? '') ?? 0.0)) +
              //           otherIncomes.fold(
              //               0.0,
              //               (sum, item) =>
              //                   sum +
              //                   (double.tryParse(item["price"] ?? '') ?? 0.0)) -
              //           otherExpenses.fold(
              //               0.0,
              //               (sum, item) =>
              //                   sum +
              //                   (double.tryParse(item["price"] ?? '') ?? 0.0)) -
              //           double.tryParse(tax)!)
              //       .toStringAsFixed(2)
              // ]
//             ],
//             oddRowDecoration: pw.BoxDecoration(
//               color: PdfColor.fromHex("#F8F7F4"),
//             ),
//             columnWidths: {
//               0: pw.FlexColumnWidth(2),
//               1: pw.FlexColumnWidth(1),
//             },
//             headerStyle: pw.TextStyle(
//               fontWeight: pw.FontWeight.bold,
//               color: PdfColor.fromHex("#ffffff"),
//             ),
//             headerDecoration: pw.BoxDecoration(
//               color: PdfColor.fromHex("#03335e"),
//             ),
//             cellStyle: pw.TextStyle(
//               fontSize: 12,
//             ),
//           ),




//  cellDecoration: (index, data, rowNum) {
//               return index == 0
//                   ? pw.BoxDecoration(
//                       color: PdfColor.fromHex("#03335e"),
//                       border: pw.Border.all(
//                         color: PdfColor.fromInt(0xFF000000),
//                         width: 2,
//                       ),
//                     )
//                   : pw.BoxDecoration(
//                       color: PdfColor.fromInt(0xFFEEEEEE),
//                       border: pw.Border.all(
//                         color: PdfColor.fromInt(0xFF000000),
//                         width: 0.5,
//                       ),
//                     );
//             },