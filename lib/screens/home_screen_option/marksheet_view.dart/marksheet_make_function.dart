// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_constructors, avoid_init_to_null, deprecated_member_use, prefer_const_literals_to_create_immutables

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

class MarksheetMake {
  static String collegeLogoImagePath = "";
  static String studentImagePath = "";
  static String principalSignatureImagePath = "";
  static String backgroundImagePath = "";

  static void generateMarksheet({
    required String collegeName,
    required String passignYear,
    required String passignMonth,
    required String studentName,
    required String course,
    required String seatNumber,
    required String classObtained,
    required List<Map<String, String>> subjects,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? collegeLogoImage;
    pw.MemoryImage? studentImage;
    pw.MemoryImage? principalSignatureImage;
    pw.MemoryImage? backgroundImage;

    if (collegeLogoImagePath.isNotEmpty) {
      if (kIsWeb) {
        try {
          final response = await http.get(Uri.parse(collegeLogoImagePath));
          Uint8List imageBytes = response.bodyBytes;
          collegeLogoImage = pw.MemoryImage(imageBytes);
        } catch (e) {
          collegeLogoImage = null;
        }
      } else {
        try {
          io.File imageFile = io.File(collegeLogoImagePath);
          Uint8List imageBytes = await imageFile.readAsBytes();
          collegeLogoImage = pw.MemoryImage(imageBytes);
        } catch (e) {
          collegeLogoImage = null;
        }
      }
    }

    if (studentImagePath.isNotEmpty) {
      if (kIsWeb) {
        try {
          final response = await http.get(Uri.parse(studentImagePath));
          Uint8List imageBytes = response.bodyBytes;
          studentImage = pw.MemoryImage(imageBytes);
        } catch (e) {
          studentImage = null;
        }
      } else {
        try {
          io.File imageFile = io.File(studentImagePath);
          Uint8List imageBytes = await imageFile.readAsBytes();
          studentImage = pw.MemoryImage(imageBytes);
        } catch (e) {
          studentImage = null;
        }
      }
    }

    if (principalSignatureImagePath.isNotEmpty) {
      if (kIsWeb) {
        try {
          final response =
              await http.get(Uri.parse(principalSignatureImagePath));
          Uint8List imageBytes = response.bodyBytes;
          principalSignatureImage = pw.MemoryImage(imageBytes);
        } catch (e) {
          principalSignatureImage = null;
        }
      } else {
        try {
          io.File imageFile = io.File(principalSignatureImagePath);
          Uint8List imageBytes = await imageFile.readAsBytes();
          principalSignatureImage = pw.MemoryImage(imageBytes);
        } catch (e) {
          principalSignatureImage = null;
        }
      }
    }

    if (backgroundImagePath.isNotEmpty) {
      if (kIsWeb) {
        try {
          final response = await http.get(Uri.parse(backgroundImagePath));
          Uint8List imageBytes = response.bodyBytes;
          backgroundImage = pw.MemoryImage(imageBytes);
        } catch (e) {
          backgroundImage = null;
        }
      } else {
        try {
          io.File imageFile = io.File(backgroundImagePath);
          Uint8List imageBytes = await imageFile.readAsBytes();
          backgroundImage = pw.MemoryImage(imageBytes);
        } catch (e) {
          backgroundImage = null;
        }
      }
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/marksheet_bg.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
      }
    }

    final now = DateTime.now();
    final formattedDate = DateFormat("dd MMMM, yyyy").format(now);

    // Marks and Grade Total
    int totalMarks = 0;
    int qualifyingMarks = 0;
    int obtainedMarks = 0;

    for (var subject in subjects) {
      totalMarks += int.tryParse(subject["totalMarks"] ?? "") ?? 0;
      qualifyingMarks += int.tryParse(subject["qualifyingMarks"] ?? "") ?? 0;
      obtainedMarks += int.tryParse(subject["obtainedMarks"] ?? "") ?? 0;
    }

    double percentage = (obtainedMarks / totalMarks) * 100;

    // Page size
    const double widthInInches = 11.5;
    const double heightInInches = 9;
    final customLandscapeFormat = PdfPageFormat(
      widthInInches * PdfPageFormat.inch,
      heightInInches * PdfPageFormat.inch,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: customLandscapeFormat,
        margin: pw.EdgeInsets.all(12),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(20),
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Padding(
              padding: pw.EdgeInsets.all(15),
              child: pw.Column(
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      if (collegeLogoImage != null)
                        pw.Image(
                          collegeLogoImage,
                          height: 70,
                          width: 70,
                          fit: pw.BoxFit.fill,
                        ),
                      pw.Spacer(),
                      pw.Container(
                        width: 500,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Text(
                              collegeName.toUpperCase(),
                              style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              textAlign: pw.TextAlign.center,
                              maxLines: 2,
                            ),
                            pw.SizedBox(
                              height: 13,
                            ),
                            pw.Text(
                              "STATEMENT OF MARKS",
                              style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      pw.Spacer(),
                    ],
                  ),

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text:
                                  "Certificate showing the number of marks obtained by Shri/Smt./Kumari ",
                              style: pw.TextStyle(
                                fontSize: 10.5,
                              ),
                            ),
                            pw.TextSpan(
                              text: "${studentName.toUpperCase()} \n",
                              style: pw.TextStyle(
                                fontSize: 10.5,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text: "of ",
                              style: pw.TextStyle(
                                fontSize: 10.5,
                              ),
                            ),
                            pw.TextSpan(
                              text: "${collegeName.toUpperCase()} \n",
                              style: pw.TextStyle(
                                fontSize: 10.5,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text: "in each head of passing at the ",
                              style: pw.TextStyle(
                                fontSize: 10.5,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${course.toUpperCase()} ${passignMonth.toUpperCase()}-${passignYear.toUpperCase()}",
                              style: pw.TextStyle(
                                fontSize: 10.5,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.Column(
                        children: [
                          if (studentImage != null)
                            pw.Image(
                              studentImage,
                              height: 65,
                              width: 60,
                              fit: pw.BoxFit.fill,
                            ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.RichText(
                            text: pw.TextSpan(
                              children: [
                                pw.TextSpan(
                                  text: "Seat No.: ",
                                  style: pw.TextStyle(
                                    fontSize: 10.5,
                                  ),
                                ),
                                pw.TextSpan(
                                  text: seatNumber.toUpperCase(),
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 13,
                  ),

                  // Subjects Row
                  pw.Table.fromTextArray(
                    headers: [
                      "Subject Name",
                      "Total Marks",
                      "Passing Marks",
                      "Marks Obtained",
                      "GR",
                    ],
                    data: List<List<String>>.generate(subjects.length, (index) {
                      final subject = subjects[index];
                      final subjectName = subject["subjectName"] ?? '';
                      final totalMarks =
                          int.tryParse(subject["totalMarks"] ?? '');
                      final qualifyingMarks =
                          int.tryParse(subject["qualifyingMarks"] ?? '');
                      final obtainedMarks =
                          int.tryParse(subject["obtainedMarks"] ?? '');
                      final grade = subject["grade"] ?? '';
                      return [
                        subjectName.toUpperCase(),
                        totalMarks.toString(),
                        qualifyingMarks.toString(),
                        obtainedMarks.toString(),
                        grade,
                      ];
                    }),
                    border: pw.TableBorder(
                      horizontalInside: pw.BorderSide.none,
                      verticalInside: pw.BorderSide(width: 1),
                      top: pw.BorderSide(width: 1),
                      bottom: pw.BorderSide(width: 1),
                      left: pw.BorderSide(width: 1),
                      right: pw.BorderSide(width: 1),
                    ),
                    cellAlignment: pw.Alignment.center,
                    cellAlignments: {0: pw.Alignment.centerLeft},
                    columnWidths: {
                      0: pw.FlexColumnWidth(2),
                      1: pw.FlexColumnWidth(1),
                      2: pw.FlexColumnWidth(1),
                      3: pw.FlexColumnWidth(1),
                      4: pw.FlexColumnWidth(0.5),
                    },
                    cellStyle: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    headerAlignments: {0: pw.Alignment.center},
                    headerPadding: pw.EdgeInsets.symmetric(vertical: 10),
                    headerStyle: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    ),
                    headerDecoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                    ),
                  ),

                  // Aggregate Row
                  pw.Table.fromTextArray(
                    data: [
                      [
                        "Aggregate Total",
                        totalMarks.toString(),
                        qualifyingMarks.toString(),
                        obtainedMarks.toString(),
                        "",
                      ],
                    ],
                    border: pw.TableBorder.all(),
                    cellAlignment: pw.Alignment.center,
                    cellAlignments: {0: pw.Alignment.centerLeft},
                    columnWidths: {
                      0: pw.FlexColumnWidth(2),
                      1: pw.FlexColumnWidth(1),
                      2: pw.FlexColumnWidth(1),
                      3: pw.FlexColumnWidth(1),
                      4: pw.FlexColumnWidth(0.5),
                    },
                    headerStyle: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),

                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Spacer(),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                        width: 430,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Issue Date: $formattedDate",
                              style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(
                              height: 8,
                            ),
                            pw.RichText(
                              text: pw.TextSpan(
                                children: [
                                  pw.TextSpan(
                                    text: "I certify that Shri/Smt./Kumari ",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: "${studentName.toUpperCase()}\n",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: "has appeard at ",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text:
                                        "${course.toUpperCase()} ${passignMonth.toUpperCase()}-${passignYear.toUpperCase()}\n",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: "Examintion held by the ",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: "${collegeName.toUpperCase()}.",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(),
                        ),
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(7),
                          child: pw.RichText(
                            text: pw.TextSpan(
                              children: [
                                pw.TextSpan(
                                  text: "Seat No.: ",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                pw.TextSpan(
                                  text: "${seatNumber.toUpperCase()}\n",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.TextSpan(
                                  text: "Month and Year of Examination: ",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                pw.TextSpan(
                                  text:
                                      "${passignMonth.toUpperCase()}-${passignYear.toUpperCase()}\n",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.TextSpan(
                                  text: "Percantage: ",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                pw.TextSpan(
                                  text: classObtained == "FAIL"
                                      ? "-\n"
                                      : "${percentage.toStringAsFixed(2)}%\n",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.TextSpan(
                                  text: "Class Obtained: ",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                pw.TextSpan(
                                  text: classObtained,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        width: 5,
                      ),
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          if (principalSignatureImage != null)
                            pw.Image(
                              principalSignatureImage,
                              height: 50,
                              width: 90,
                              fit: pw.BoxFit.fill,
                            ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.Text(
                            "REGISTRAR",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
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
        msg: "Marksheet download process is complete",
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

      showSnackbar("Marksheet", "Your marksheet download successfully !",
          "$dir/$name.pdf");

      Navigator.of(context).pop();
    }
  }
}
