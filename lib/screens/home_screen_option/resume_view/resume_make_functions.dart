// ignore_for_file: avoid_init_to_null, use_build_context_synchronously, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

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
import 'package:http/http.dart' as http;
import "../../../widgets/common_widgets/snackbar_view.dart";

class ResumeMake {
  static String imagePath = "";

  static void function1({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required String aboutMe,
    List? experience,
    List? achivement,
    List? language,
    List? education,
    List? skill,
    List? project,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

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

    try {
      addressIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_location.png"))
            .buffer
            .asUint8List(),
      );
      phoneIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_phone.png"))
            .buffer
            .asUint8List(),
      );
      emailIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_email.png"))
            .buffer
            .asUint8List(),
      );
    } catch (e) {
      addressIcon = null;
      phoneIcon = null;
      emailIcon = null;
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Container(
            color: PdfColor.fromHex("#03335e"),
            child: pw.Padding(
              padding: pw.EdgeInsets.all(15),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          name,
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex("#ffffff"),
                          ),
                        ),
                        pw.SizedBox(
                          height: 8,
                        ),
                        pw.Text(
                          profession,
                          style: pw.TextStyle(
                            fontSize: 16,
                            color: PdfColor.fromHex("#ffffff"),
                          ),
                        ),
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              addressIcon!,
                              width: 10,
                              height: 10,
                            ),
                            pw.SizedBox(
                              width: 8,
                            ),
                            pw.Expanded(
                              child: pw.Text(
                                address,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColor.fromHex("#ffffff"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              phoneIcon!,
                              width: 10,
                              height: 10,
                            ),
                            pw.SizedBox(
                              width: 8,
                            ),
                            pw.Text(
                              "+91 $phoneNo",
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColor.fromHex("#ffffff"),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              emailIcon!,
                              width: 10,
                              height: 10,
                            ),
                            pw.SizedBox(
                              width: 8,
                            ),
                            pw.Text(
                              email,
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColor.fromHex("#ffffff"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (imagePath.isNotEmpty)
                    pw.Container(
                      child: pw.Image(
                        image!,
                        width: 120,
                        height: 120,
                      ),
                    ),
                ],
              ),
            ),
          ),
          pw.SizedBox(
            height: 15,
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Summary",
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromHex("#03335e"),
                      ),
                    ),
                    pw.SizedBox(
                      height: 8,
                    ),
                    pw.Text(
                      aboutMe,
                      style: pw.TextStyle(
                        fontSize: 10,
                      ),
                      textAlign: pw.TextAlign.justify,
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Container(
                      height: 1,
                      color: PdfColor.fromHex("#03335e"),
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    if (experience != null && experience.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Experience",
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          ...experience.map((exp) {
                            final parts = exp.split("\n");
                            return pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 8),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    parts[0],
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  if (parts.length > 1)
                                    pw.Text(
                                      parts[1],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  if (parts.length > 2)
                                    pw.Text(
                                      parts[2],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    pw.SizedBox(
                      height: 2,
                    ),
                    if (experience != null && experience.isNotEmpty)
                      pw.Container(
                        height: 1,
                        color: PdfColor.fromHex("#03335e"),
                      ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    if (achivement != null && achivement.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Achivement",
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          ...achivement
                              .map((ach) => pw.Padding(
                                    padding:
                                        const pw.EdgeInsets.only(bottom: 6),
                                    child: pw.Text(
                                      ach,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    pw.SizedBox(
                      height: 14,
                    ),
                    if (achivement != null && achivement.isNotEmpty)
                      pw.Container(
                        height: 1,
                        color: PdfColor.fromHex("#03335e"),
                      ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    if (language != null && language.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Languages",
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.Wrap(
                            spacing: 20,
                            children: language
                                .map((lang) => pw.Container(
                                      padding:
                                          const pw.EdgeInsets.only(bottom: 6),
                                      child: pw.Text(
                                        lang,
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              pw.SizedBox(
                width: 10,
              ),
              pw.Container(
                height: 630,
                width: 1.5,
                color: PdfColor.fromHex("#03335e"),
              ),
              pw.SizedBox(
                width: 10,
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (skill != null && skill.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Skills",
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.Wrap(
                            spacing: 20,
                            children: skill
                                .map((sk) => pw.Container(
                                      padding:
                                          const pw.EdgeInsets.only(bottom: 6),
                                      child: pw.Text(
                                        sk,
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    pw.SizedBox(
                      height: 14,
                    ),
                    if (skill != null && skill.isNotEmpty)
                      pw.Container(
                        height: 1,
                        color: PdfColor.fromHex("#03335e"),
                      ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    if (education != null && education.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Education",
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          ...education.map((edu) {
                            final parts = edu.split("\n");
                            return pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 8),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    parts[0],
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  if (parts.length > 1)
                                    pw.Text(
                                      parts[1],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  if (parts.length > 2)
                                    pw.Text(
                                      parts[2],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    pw.SizedBox(
                      height: 2,
                    ),
                    if (education != null && education.isNotEmpty)
                      pw.Container(
                        height: 1,
                        color: PdfColor.fromHex("#03335e"),
                      ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    if (project != null && project.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Projects",
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          ...project.map((proj) {
                            final parts = proj.split("\n");
                            return pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 8),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    parts[0],
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  if (parts.length > 1)
                                    pw.Text(
                                      parts[1],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  if (parts.length > 2)
                                    pw.Text(
                                      parts[2],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                  ],
                ),
              ),
            ],
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

  static void function2({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required String aboutMe,
    List? experience,
    List? achivement,
    List? language,
    List? education,
    List? skill,
    List? project,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

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
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Row(
            children: [
              pw.Container(
                width: 200,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (image != null)
                      pw.Center(
                        child: pw.ClipOval(
                          child: pw.Container(
                            width: 120,
                            height: 120,
                            child: pw.Image(
                              image,
                              fit: pw.BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Row(
                      children: [
                        pw.ClipOval(
                          child: pw.Container(
                            height: 7,
                            width: 7,
                            color: PdfColor.fromHex("#03335e"),
                          ),
                        ),
                        pw.SizedBox(
                          width: 12,
                        ),
                        pw.Text(
                          "Contact",
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex("#03335e"),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        pw.SizedBox(
                          width: 10,
                        ),
                        pw.Image(
                          emailIcon!,
                          width: 10,
                          height: 10,
                        ),
                        pw.SizedBox(
                          width: 8,
                        ),
                        pw.Text(
                          email,
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 4,
                    ),
                    pw.Row(
                      children: [
                        pw.SizedBox(
                          width: 10,
                        ),
                        pw.Image(
                          phoneIcon!,
                          width: 10,
                          height: 10,
                        ),
                        pw.SizedBox(
                          width: 8,
                        ),
                        pw.Text(
                          "+91 $phoneNo",
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 4,
                    ),
                    pw.Row(
                      children: [
                        pw.SizedBox(
                          width: 10,
                        ),
                        pw.Image(
                          addressIcon!,
                          width: 10,
                          height: 10,
                        ),
                        pw.SizedBox(
                          width: 8,
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            address,
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (skill != null && skill.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 20,
                          ),
                          pw.Row(
                            children: [
                              pw.ClipOval(
                                child: pw.Container(
                                  height: 7,
                                  width: 7,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                width: 12,
                              ),
                              pw.Text(
                                "Skills",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          ...skill.map((sk) => pw.Padding(
                                padding: const pw.EdgeInsets.only(
                                    left: 10, bottom: 6),
                                child: pw.Text(
                                  sk,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    if (achivement != null && achivement.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 14,
                          ),
                          pw.Row(
                            children: [
                              pw.ClipOval(
                                child: pw.Container(
                                  height: 7,
                                  width: 7,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                width: 12,
                              ),
                              pw.Text(
                                "Achievements",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          ...achivement.map((ach) => pw.Padding(
                                padding: const pw.EdgeInsets.only(
                                    left: 10, bottom: 6),
                                child: pw.Text(
                                  ach,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    if (language != null && language.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 14,
                          ),
                          pw.Row(
                            children: [
                              pw.ClipOval(
                                child: pw.Container(
                                  height: 7,
                                  width: 7,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                width: 12,
                              ),
                              pw.Text(
                                "Languages",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          ...language.map((lang) => pw.Padding(
                                padding: const pw.EdgeInsets.only(
                                    left: 10, bottom: 6),
                                child: pw.Text(
                                  lang,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              )),
                        ],
                      ),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        name,
                        style: pw.TextStyle(
                          fontSize: 35,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(
                        height: 8,
                      ),
                      pw.Text(
                        profession,
                        style: pw.TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      pw.SizedBox(
                        height: 30,
                      ),
                      pw.Text(
                        aboutMe,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                        textAlign: pw.TextAlign.justify,
                      ),
                      if (experience != null && experience.isNotEmpty)
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(
                              height: 20,
                            ),
                            pw.Row(
                              children: [
                                pw.ClipOval(
                                  child: pw.Container(
                                    height: 7,
                                    width: 7,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 12,
                                ),
                                pw.Text(
                                  "Professional Experience",
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            ...experience.map((exp) {
                              final parts = exp.split("\n");
                              return pw.Padding(
                                padding: const pw.EdgeInsets.only(
                                    left: 10, bottom: 8),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      parts[0],
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    if (parts.length > 1)
                                      pw.Text(
                                        parts[1],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    if (parts.length > 2)
                                      pw.Text(
                                        parts[2],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      if (education != null && education.isNotEmpty)
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(
                              height: 12,
                            ),
                            pw.Row(
                              children: [
                                pw.ClipOval(
                                  child: pw.Container(
                                    height: 7,
                                    width: 7,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 12,
                                ),
                                pw.Text(
                                  "Education",
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            ...education.map((edu) {
                              final parts = edu.split("\n");
                              return pw.Padding(
                                padding: const pw.EdgeInsets.only(
                                    left: 10, bottom: 8),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      parts[0],
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    if (parts.length > 1)
                                      pw.Text(
                                        parts[1],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    if (parts.length > 2)
                                      pw.Text(
                                        parts[2],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      if (project != null && project.isNotEmpty)
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(
                              height: 12,
                            ),
                            pw.Row(
                              children: [
                                pw.ClipOval(
                                  child: pw.Container(
                                    height: 7,
                                    width: 7,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 12,
                                ),
                                pw.Text(
                                  "Projects",
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            ...project.map((proj) {
                              final parts = proj.split("\n");
                              return pw.Padding(
                                padding: const pw.EdgeInsets.only(
                                    left: 10, bottom: 8),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      parts[0],
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    if (parts.length > 1)
                                      pw.Text(
                                        parts[1],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    if (parts.length > 2)
                                      pw.Text(
                                        parts[2],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
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

    Uint8List data = await pdf.save();

    await pdfSave(
      context: context,
      uint8list: data,
    );
  }

  static void function3({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required String aboutMe,
    List? experience,
    List? achivement,
    List? language,
    List? education,
    List? skill,
    List? project,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

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
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Column(
            children: [
              pw.Stack(
                children: [
                  pw.Container(
                    height: 140,
                    width: 170,
                  ),
                  pw.Container(
                    height: 110,
                    width: double.infinity,
                    color: PdfColor.fromHex("#03335e"),
                    child: pw.Padding(
                      padding: pw.EdgeInsets.only(left: 185),
                      child: pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              name,
                              style: pw.TextStyle(
                                fontSize: 30,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex("#ffffff"),
                              ),
                            ),
                            pw.SizedBox(
                              height: 5,
                            ),
                            pw.Text(
                              profession,
                              style: pw.TextStyle(
                                fontSize: 15,
                                color: PdfColor.fromHex("#ffffff"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (image != null)
                    pw.Positioned(
                      top: 20,
                      left: 40,
                      child: pw.ClipOval(
                        child: pw.Container(
                          height: 120,
                          width: 120,
                          child: pw.Image(
                            image,
                            fit: pw.BoxFit.cover,
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
                        pw.Text(
                          "Contact",
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex("#03335e"),
                          ),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Container(
                          height: 1.5,
                          width: 70,
                          color: PdfColor.fromHex("#03335e"),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              emailIcon!,
                              width: 10,
                              height: 10,
                            ),
                            pw.SizedBox(
                              width: 8,
                            ),
                            pw.Text(
                              email,
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              phoneIcon!,
                              width: 10,
                              height: 10,
                            ),
                            pw.SizedBox(
                              width: 8,
                            ),
                            pw.Text(
                              "+91 $phoneNo",
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 4,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              addressIcon!,
                              width: 10,
                              height: 10,
                            ),
                            pw.SizedBox(
                              width: 8,
                            ),
                            pw.Expanded(
                              child: pw.Text(
                                address,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (skill != null && skill.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 20,
                              ),
                              pw.Text(
                                "Skills",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Container(
                                height: 1.5,
                                width: 70,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              ...skill
                                  .map((sk) => pw.Padding(
                                        padding:
                                            const pw.EdgeInsets.only(bottom: 6),
                                        child: pw.Row(
                                          children: [
                                            pw.ClipOval(
                                              child: pw.Container(
                                                height: 4,
                                                width: 4,
                                                color:
                                                    PdfColor.fromHex("#03335e"),
                                              ),
                                            ),
                                            pw.SizedBox(
                                              width: 8,
                                            ),
                                            pw.Text(
                                              sk,
                                              style: pw.TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        if (language != null && language.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 14,
                              ),
                              pw.Text(
                                "Languages",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Container(
                                height: 1.5,
                                width: 70,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              ...language
                                  .map((lang) => pw.Padding(
                                        padding:
                                            const pw.EdgeInsets.only(bottom: 6),
                                        child: pw.Row(
                                          children: [
                                            pw.ClipOval(
                                              child: pw.Container(
                                                height: 4,
                                                width: 4,
                                                color:
                                                    PdfColor.fromHex("#03335e"),
                                              ),
                                            ),
                                            pw.SizedBox(
                                              width: 8,
                                            ),
                                            pw.Text(
                                              lang,
                                              style: pw.TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        if (education != null && education.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 14,
                              ),
                              pw.Text(
                                "Education",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Container(
                                height: 1.5,
                                width: 70,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              ...education.map((edu) {
                                final parts = edu.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 8),
                                  child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(top: 5),
                                        child: pw.ClipOval(
                                          child: pw.Container(
                                            height: 4,
                                            width: 4,
                                            color: PdfColor.fromHex("#03335e"),
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(
                                        width: 8,
                                      ),
                                      pw.Expanded(
                                        child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                              parts[0],
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                            if (parts.length > 1)
                                              pw.Text(
                                                parts[1],
                                                style: pw.TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            if (parts.length > 2)
                                              pw.Text(
                                                parts[2],
                                                style: pw.TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                  pw.SizedBox(
                    width: 10,
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Summary",
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex("#03335e"),
                          ),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Container(
                          height: 1.5,
                          width: 70,
                          color: PdfColor.fromHex("#03335e"),
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Text(
                          aboutMe,
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                          textAlign: pw.TextAlign.justify,
                        ),
                        if (experience != null && experience.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 20,
                              ),
                              pw.Text(
                                "Experience",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Container(
                                height: 1.5,
                                width: 70,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              ...experience.map((exp) {
                                final parts = exp.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 8),
                                  child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(top: 5),
                                        child: pw.ClipOval(
                                          child: pw.Container(
                                            height: 4,
                                            width: 4,
                                            color: PdfColor.fromHex("#03335e"),
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(
                                        width: 8,
                                      ),
                                      pw.Expanded(
                                        child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                              parts[0],
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                            if (parts.length > 1)
                                              pw.Text(
                                                parts[1],
                                                style: pw.TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            if (parts.length > 2)
                                              pw.Text(
                                                parts[2],
                                                style: pw.TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        if (achivement != null && achivement.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 12,
                              ),
                              pw.Text(
                                "Achievements",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Container(
                                height: 1.5,
                                width: 70,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              ...achivement
                                  .map((ach) => pw.Padding(
                                        padding:
                                            const pw.EdgeInsets.only(bottom: 6),
                                        child: pw.Row(
                                          children: [
                                            pw.ClipOval(
                                              child: pw.Container(
                                                height: 4,
                                                width: 4,
                                                color:
                                                    PdfColor.fromHex("#03335e"),
                                              ),
                                            ),
                                            pw.SizedBox(
                                              width: 8,
                                            ),
                                            pw.Expanded(
                                              child: pw.Text(
                                                ach,
                                                style: pw.TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        if (project != null && project.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 14,
                              ),
                              pw.Text(
                                "Projects",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Container(
                                height: 1.5,
                                width: 70,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              ...project.map((proj) {
                                final parts = proj.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 8),
                                  child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Padding(
                                        padding: pw.EdgeInsets.only(top: 5),
                                        child: pw.ClipOval(
                                          child: pw.Container(
                                            height: 4,
                                            width: 4,
                                            color: PdfColor.fromHex("#03335e"),
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(
                                        width: 8,
                                      ),
                                      pw.Expanded(
                                        child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                              parts[0],
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                            if (parts.length > 1)
                                              pw.Text(
                                                parts[1],
                                                style: pw.TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            if (parts.length > 2)
                                              pw.Text(
                                                parts[2],
                                                style: pw.TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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

  static void function4({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required String aboutMe,
    List? experience,
    List? achivement,
    List? language,
    List? education,
    List? skill,
    List? project,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

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

    try {
      addressIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_location.png"))
            .buffer
            .asUint8List(),
      );
      phoneIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_phone.png"))
            .buffer
            .asUint8List(),
      );
      emailIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_email.png"))
            .buffer
            .asUint8List(),
      );
    } catch (e) {
      addressIcon = null;
      phoneIcon = null;
      emailIcon = null;
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Column(
            children: [
              pw.Container(
                color: PdfColor.fromHex("#03335e"),
                child: pw.Padding(
                  padding:
                      pw.EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: pw.Row(
                    children: [
                      if (image != null)
                        pw.Container(
                          child: pw.Image(
                            image,
                            height: 120,
                            width: 120,
                          ),
                        ),
                      pw.SizedBox(
                        width: 40,
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            name,
                            style: pw.TextStyle(
                              fontSize: 28,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#ffffff"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 8,
                          ),
                          pw.Text(
                            profession,
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#ffffff"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 13,
                          ),
                          pw.Row(
                            children: [
                              pw.Image(
                                emailIcon!,
                                width: 10,
                                height: 10,
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                email,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColor.fromHex("#ffffff"),
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
                                phoneIcon!,
                                width: 10,
                                height: 10,
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                "+91 $phoneNo",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColor.fromHex("#ffffff"),
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
                                width: 10,
                                height: 10,
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                address,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColor.fromHex("#ffffff"),
                                ),
                                textAlign: pw.TextAlign.justify,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Summary",
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex("#03335e"),
                          ),
                        ),
                        pw.SizedBox(
                          height: 9,
                        ),
                        pw.Container(
                          height: 1.5,
                          color: PdfColor.fromHex("#03335e"),
                        ),
                        pw.SizedBox(
                          height: 9,
                        ),
                        pw.Text(
                          aboutMe,
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                          textAlign: pw.TextAlign.justify,
                        ),
                        if (education != null && education.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 20,
                              ),
                              pw.Text(
                                "Education",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              pw.Container(
                                height: 1.5,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              ...education.map((edu) {
                                final parts = edu.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 8),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        parts[0],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      if (parts.length > 1)
                                        pw.Text(
                                          parts[1],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      if (parts.length > 2)
                                        pw.Text(
                                          parts[2],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        if (experience != null && experience.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 12,
                              ),
                              pw.Text(
                                "Work Experience",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              pw.Container(
                                height: 1.5,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              ...experience.map((exp) {
                                final parts = exp.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 8),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        parts[0],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      if (parts.length > 1)
                                        pw.Text(
                                          parts[1],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      if (parts.length > 2)
                                        pw.Text(
                                          parts[2],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                  pw.SizedBox(
                    width: 10,
                  ),
                  pw.Container(
                    height: 630,
                    width: 1.5,
                    color: PdfColor.fromHex("#03335e"),
                  ),
                  pw.SizedBox(
                    width: 10,
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (language != null && language.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Languages",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              pw.Container(
                                height: 1.5,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              pw.Wrap(
                                spacing: 20,
                                children: language
                                    .map((lang) => pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              bottom: 6),
                                          child: pw.Text(
                                            lang,
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        if (skill != null && skill.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 14,
                              ),
                              pw.Text(
                                "Skills",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              pw.Container(
                                height: 1.5,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              pw.Wrap(
                                spacing: 20,
                                runSpacing: 10,
                                children: skill
                                    .map((sk) => pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              bottom: 6),
                                          child: pw.Text(
                                            sk,
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        if (achivement != null && achivement.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 14,
                              ),
                              pw.Text(
                                "Achievements",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              pw.Container(
                                height: 1.5,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              ...achivement
                                  .map((ach) => pw.Padding(
                                        padding:
                                            const pw.EdgeInsets.only(bottom: 6),
                                        child: pw.Text(
                                          ach,
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        if (project != null && project.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 14,
                              ),
                              pw.Text(
                                "Projects",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              pw.Container(
                                height: 1.5,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                              pw.SizedBox(
                                height: 9,
                              ),
                              ...project.map((proj) {
                                final parts = proj.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 8),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        parts[0],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      if (parts.length > 1)
                                        pw.Text(
                                          parts[1],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      if (parts.length > 2)
                                        pw.Text(
                                          parts[2],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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

  static void function5({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required String aboutMe,
    List? experience,
    List? achivement,
    List? language,
    List? education,
    List? skill,
    List? project,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

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
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Padding(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(15),
                          color: PdfColor.fromHex("#03335e"),
                        ),
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(15),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                name,
                                style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#ffffff"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 8,
                              ),
                              pw.Text(
                                profession,
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromHex("#ffffff"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                aboutMe,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColor.fromHex("#ffffff"),
                                ),
                                textAlign: pw.TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (education != null && education.isNotEmpty)
                        pw.Column(
                          children: [
                            pw.SizedBox(
                              height: 20,
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  height: 15,
                                  width: 15,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(5),
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 10,
                                ),
                                pw.Text(
                                  "Education",
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            ...education.map((edu) {
                              final parts = edu.split("\n");
                              return pw.Padding(
                                padding: const pw.EdgeInsets.only(bottom: 8),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      parts[0],
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    if (parts.length > 1)
                                      pw.Text(
                                        parts[1],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    if (parts.length > 2)
                                      pw.Text(
                                        parts[2],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      if (experience != null && experience.isNotEmpty)
                        pw.Column(
                          children: [
                            pw.SizedBox(
                              height: 12,
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  height: 15,
                                  width: 15,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(5),
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 10,
                                ),
                                pw.Text(
                                  "Work Experience",
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            ...experience.map((exp) {
                              final parts = exp.split("\n");
                              return pw.Padding(
                                padding: const pw.EdgeInsets.only(bottom: 8),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      parts[0],
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    if (parts.length > 1)
                                      pw.Text(
                                        parts[1],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    if (parts.length > 2)
                                      pw.Text(
                                        parts[2],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Padding(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      if (image != null)
                        pw.Container(
                          height: 120,
                          width: 120,
                          decoration: pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.circular(10),
                            image: pw.DecorationImage(
                              image: pw.Image(
                                image,
                                height: 120,
                                width: 120,
                                fit: pw.BoxFit.cover,
                              ).image,
                            ),
                          ),
                        ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        children: [
                          pw.Container(
                            height: 15,
                            width: 15,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(5),
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            width: 10,
                          ),
                          pw.Text(
                            "Contact",
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Row(
                        children: [
                          pw.Image(
                            emailIcon!,
                            width: 10,
                            height: 10,
                          ),
                          pw.SizedBox(
                            width: 7,
                          ),
                          pw.Text(
                            email,
                            style: pw.TextStyle(
                              fontSize: 10,
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
                            phoneIcon!,
                            width: 10,
                            height: 10,
                          ),
                          pw.SizedBox(
                            width: 7,
                          ),
                          pw.Text(
                            "+91 $phoneNo",
                            style: pw.TextStyle(
                              fontSize: 10,
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
                            width: 10,
                            height: 10,
                          ),
                          pw.SizedBox(
                            width: 7,
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              address,
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                              textAlign: pw.TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      if (skill != null && skill.isNotEmpty)
                        pw.Column(
                          children: [
                            pw.SizedBox(
                              height: 20,
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  height: 15,
                                  width: 15,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(5),
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 10,
                                ),
                                pw.Text(
                                  "Skills",
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            pw.Wrap(
                              spacing: 20,
                              runSpacing: 10,
                              children: skill
                                  .map((sk) => pw.Container(
                                        padding:
                                            const pw.EdgeInsets.only(bottom: 6),
                                        child: pw.Text(
                                          sk,
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      if (project != null && project.isNotEmpty)
                        pw.Column(
                          children: [
                            pw.SizedBox(
                              height: 14,
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  height: 15,
                                  width: 15,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(5),
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 10,
                                ),
                                pw.Text(
                                  "Projects",
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            ...project.map((proj) {
                              final parts = proj.split("\n");
                              return pw.Padding(
                                padding: const pw.EdgeInsets.only(bottom: 8),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      parts[0],
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    if (parts.length > 1)
                                      pw.Text(
                                        parts[1],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    if (parts.length > 2)
                                      pw.Text(
                                        parts[2],
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      if (achivement != null && achivement.isNotEmpty)
                        pw.Column(
                          children: [
                            pw.SizedBox(
                              height: 12,
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  height: 15,
                                  width: 15,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(5),
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 10,
                                ),
                                pw.Text(
                                  "Achievements",
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            ...achivement
                                .map((ach) => pw.Padding(
                                      padding:
                                          const pw.EdgeInsets.only(bottom: 6),
                                      child: pw.Text(
                                        ach,
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      if (language != null && language.isNotEmpty)
                        pw.Column(
                          children: [
                            pw.SizedBox(
                              height: 14,
                            ),
                            pw.Row(
                              children: [
                                pw.Container(
                                  height: 15,
                                  width: 15,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(5),
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 10,
                                ),
                                pw.Text(
                                  "Languages",
                                  style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            pw.Wrap(
                              spacing: 20,
                              runSpacing: 10,
                              children: language
                                  .map((lang) => pw.Container(
                                        padding:
                                            const pw.EdgeInsets.only(bottom: 6),
                                        child: pw.Text(
                                          lang,
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
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

    Uint8List data = await pdf.save();

    await pdfSave(
      context: context,
      uint8list: data,
    );
  }

  static void function6({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required String aboutMe,
    List? experience,
    List? achivement,
    List? language,
    List? education,
    List? skill,
    List? project,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

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
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Row(
            children: [
              if (image != null)
                pw.Container(
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  child: pw.ClipRRect(
                    horizontalRadius: 10,
                    verticalRadius: 10,
                    child: pw.Image(
                      image,
                      height: 100,
                      width: 100,
                      fit: pw.BoxFit.cover,
                    ),
                  ),
                ),
              pw.SizedBox(
                width: 30,
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      name,
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromHex("#03335e"),
                      ),
                    ),
                    pw.SizedBox(
                      height: 7,
                    ),
                    pw.Text(
                      profession,
                      style: pw.TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Container(
                      height: 1.5,
                      width: double.infinity,
                      color: PdfColor.fromHex("#03335e"),
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                      children: [
                        pw.Image(
                          emailIcon!,
                          width: 10,
                          height: 10,
                        ),
                        pw.SizedBox(
                          width: 7,
                        ),
                        pw.Text(
                          email,
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        pw.SizedBox(
                          width: 13,
                        ),
                        pw.Image(
                          phoneIcon!,
                          width: 10,
                          height: 10,
                        ),
                        pw.SizedBox(
                          width: 7,
                        ),
                        pw.Text(
                          "+91 $phoneNo",
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
                          addressIcon!,
                          width: 10,
                          height: 10,
                        ),
                        pw.SizedBox(
                          width: 7,
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            address,
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(
            height: 20,
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Container(
                          height: 15,
                          width: 15,
                          decoration: pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.circular(5),
                            color: PdfColor.fromHex("#03335e"),
                          ),
                        ),
                        pw.SizedBox(
                          width: 7,
                        ),
                        pw.Text(
                          "Summary",
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex("#03335e"),
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 7,
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.only(left: 10),
                      child: pw.Text(
                        aboutMe,
                        style: pw.TextStyle(
                          fontSize: 10,
                        ),
                        textAlign: pw.TextAlign.justify,
                      ),
                    ),
                    if (experience != null && experience.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 20,
                          ),
                          pw.Row(
                            children: [
                              pw.Container(
                                height: 15,
                                width: 15,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(5),
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                "Experience",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 7,
                          ),
                          ...experience.map((exp) {
                            final parts = exp.split("\n");
                            return pw.Padding(
                              padding:
                                  const pw.EdgeInsets.only(left: 10, bottom: 8),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    parts[0],
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  if (parts.length > 1)
                                    pw.Text(
                                      parts[1],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  if (parts.length > 2)
                                    pw.Text(
                                      parts[2],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    if (project != null && project.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 12,
                          ),
                          pw.Row(
                            children: [
                              pw.Container(
                                height: 15,
                                width: 15,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(5),
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                "Projects",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 7,
                          ),
                          ...project.map((proj) {
                            final parts = proj.split("\n");
                            return pw.Padding(
                              padding:
                                  const pw.EdgeInsets.only(left: 10, bottom: 8),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    parts[0],
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  if (parts.length > 1)
                                    pw.Text(
                                      parts[1],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  if (parts.length > 2)
                                    pw.Text(
                                      parts[2],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                  ],
                ),
              ),
              pw.SizedBox(
                width: 20,
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (skill != null && skill.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                            children: [
                              pw.Container(
                                height: 15,
                                width: 15,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(5),
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                "Skills",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 7,
                          ),
                          ...skill
                              .map((sk) => pw.Padding(
                                    padding: const pw.EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: pw.Text(
                                      sk,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    if (language != null && language.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Container(
                                height: 15,
                                width: 15,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(5),
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                "Languages",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 7,
                          ),
                          ...language
                              .map((lang) => pw.Padding(
                                    padding: const pw.EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: pw.Text(
                                      lang,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    if (education != null && education.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Row(
                            children: [
                              pw.Container(
                                height: 15,
                                width: 15,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(5),
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                "Education",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 7,
                          ),
                          ...education.map((edu) {
                            final parts = edu.split("\n");
                            return pw.Padding(
                              padding:
                                  const pw.EdgeInsets.only(left: 10, bottom: 8),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    parts[0],
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  if (parts.length > 1)
                                    pw.Text(
                                      parts[1],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  if (parts.length > 2)
                                    pw.Text(
                                      parts[2],
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    if (achivement != null && achivement.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 12,
                          ),
                          pw.Row(
                            children: [
                              pw.Container(
                                height: 15,
                                width: 15,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(5),
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                "Achivement",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 7,
                          ),
                          ...achivement
                              .map((ach) => pw.Padding(
                                    padding: const pw.EdgeInsets.only(
                                        left: 10, bottom: 5),
                                    child: pw.Text(
                                      ach,
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                  ],
                ),
              ),
            ],
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

  static void function7({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required String aboutMe,
    List? experience,
    List? achivement,
    List? language,
    List? education,
    List? skill,
    List? project,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

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
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(15),
                        color: PdfColor.fromHex("#03335e"),
                      ),
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(15),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              name,
                              style: pw.TextStyle(
                                fontSize: 21,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex("#ffffff"),
                              ),
                            ),
                            pw.SizedBox(
                              height: 7,
                            ),
                            pw.Text(
                              profession,
                              style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromHex("#ffffff"),
                              ),
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            pw.Text(
                              aboutMe,
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColor.fromHex("#ffffff"),
                              ),
                              textAlign: pw.TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    width: 20,
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (image != null)
                          pw.Center(
                            child: pw.ClipOval(
                              child: pw.Container(
                                width: 110,
                                height: 110,
                                child: pw.Image(
                                  image,
                                  fit: pw.BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        pw.SizedBox(
                          height: 10,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              emailIcon!,
                              width: 10,
                              height: 10,
                            ),
                            pw.SizedBox(
                              width: 7,
                            ),
                            pw.Text(
                              email,
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
                              width: 10,
                              height: 10,
                            ),
                            pw.SizedBox(
                              width: 7,
                            ),
                            pw.Text(
                              "+91 $phoneNo",
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
                              addressIcon!,
                              width: 10,
                              height: 10,
                            ),
                            pw.SizedBox(
                              width: 7,
                            ),
                            pw.Expanded(
                              child: pw.Text(
                                address,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Padding(
                padding: pw.EdgeInsets.all(20),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (experience != null && experience.isNotEmpty)
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(
                                  children: [
                                    pw.Container(
                                      height: 15,
                                      width: 15,
                                      decoration: pw.BoxDecoration(
                                        borderRadius:
                                            pw.BorderRadius.circular(5),
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      width: 7,
                                    ),
                                    pw.Text(
                                      "Experience",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                ...experience.map((exp) {
                                  final parts = exp.split("\n");
                                  return pw.Padding(
                                    padding:
                                        const pw.EdgeInsets.only(bottom: 8),
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          parts[0],
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        if (parts.length > 1)
                                          pw.Text(
                                            parts[1],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        if (parts.length > 2)
                                          pw.Text(
                                            parts[2],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          if (education != null && education.isNotEmpty)
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(
                                  height: 12,
                                ),
                                pw.Row(
                                  children: [
                                    pw.Container(
                                      height: 15,
                                      width: 15,
                                      decoration: pw.BoxDecoration(
                                        borderRadius:
                                            pw.BorderRadius.circular(5),
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      width: 7,
                                    ),
                                    pw.Text(
                                      "Education",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                ...education.map((edu) {
                                  final parts = edu.split("\n");
                                  return pw.Padding(
                                    padding:
                                        const pw.EdgeInsets.only(bottom: 8),
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          parts[0],
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        if (parts.length > 1)
                                          pw.Text(
                                            parts[1],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        if (parts.length > 2)
                                          pw.Text(
                                            parts[2],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          if (project != null && project.isNotEmpty)
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(
                                  height: 12,
                                ),
                                pw.Row(
                                  children: [
                                    pw.Container(
                                      height: 15,
                                      width: 15,
                                      decoration: pw.BoxDecoration(
                                        borderRadius:
                                            pw.BorderRadius.circular(5),
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      width: 7,
                                    ),
                                    pw.Text(
                                      "Projects",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                ...project.map((proj) {
                                  final parts = proj.split("\n");
                                  return pw.Padding(
                                    padding:
                                        const pw.EdgeInsets.only(bottom: 8),
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          parts[0],
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        if (parts.length > 1)
                                          pw.Text(
                                            parts[1],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        if (parts.length > 2)
                                          pw.Text(
                                            parts[2],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      width: 10,
                    ),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (skill != null && skill.isNotEmpty)
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Row(
                                  children: [
                                    pw.Container(
                                      height: 15,
                                      width: 15,
                                      decoration: pw.BoxDecoration(
                                        borderRadius:
                                            pw.BorderRadius.circular(5),
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      width: 7,
                                    ),
                                    pw.Text(
                                      "Skills",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                ...skill
                                    .map((sk) => pw.Padding(
                                          padding: const pw.EdgeInsets.only(
                                              bottom: 6),
                                          child: pw.Text(
                                            sk,
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ],
                            ),
                          if (achivement != null && achivement.isNotEmpty)
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(
                                  height: 14,
                                ),
                                pw.Row(
                                  children: [
                                    pw.Container(
                                      height: 15,
                                      width: 15,
                                      decoration: pw.BoxDecoration(
                                        borderRadius:
                                            pw.BorderRadius.circular(5),
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      width: 7,
                                    ),
                                    pw.Text(
                                      "Achivements",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                ...achivement
                                    .map((ach) => pw.Padding(
                                          padding: const pw.EdgeInsets.only(
                                              bottom: 6),
                                          child: pw.Text(
                                            ach,
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ],
                            ),
                          if (language != null && language.isNotEmpty)
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(
                                  height: 14,
                                ),
                                pw.Row(
                                  children: [
                                    pw.Container(
                                      height: 15,
                                      width: 15,
                                      decoration: pw.BoxDecoration(
                                        borderRadius:
                                            pw.BorderRadius.circular(5),
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      width: 7,
                                    ),
                                    pw.Text(
                                      "Languages",
                                      style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                  ],
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                ...language
                                    .map((lang) => pw.Padding(
                                          padding: const pw.EdgeInsets.only(
                                              bottom: 6),
                                          child: pw.Text(
                                            lang,
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
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

  static void function8({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required String aboutMe,
    List? experience,
    List? achivement,
    List? language,
    List? education,
    List? skill,
    List? project,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

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

    try {
      addressIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_location.png"))
            .buffer
            .asUint8List(),
      );
      phoneIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_phone.png"))
            .buffer
            .asUint8List(),
      );
      emailIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_email.png"))
            .buffer
            .asUint8List(),
      );
    } catch (e) {
      addressIcon = null;
      phoneIcon = null;
      emailIcon = null;
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Column(
            children: [
              pw.Container(
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(10),
                  color: PdfColor.fromHex("#03335e"),
                ),
                child: pw.Padding(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Row(
                    children: [
                      if (image != null)
                        pw.Container(
                          decoration: pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.circular(10),
                            color: PdfColor.fromHex("#ffffff"),
                          ),
                          child: pw.ClipRRect(
                            horizontalRadius: 10,
                            verticalRadius: 10,
                            child: pw.Image(
                              image,
                              height: 100,
                              width: 100,
                              fit: pw.BoxFit.cover,
                            ),
                          ),
                        ),
                      pw.SizedBox(
                        width: 30,
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            name,
                            style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#ffffff"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 7,
                          ),
                          pw.Text(
                            profession,
                            style: pw.TextStyle(
                              fontSize: 13,
                              color: PdfColor.fromHex("#ffffff"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.Row(
                            children: [
                              pw.Image(
                                emailIcon!,
                                width: 10,
                                height: 10,
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                email,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColor.fromHex("#ffffff"),
                                ),
                              ),
                              pw.SizedBox(
                                width: 13,
                              ),
                              pw.Image(
                                phoneIcon!,
                                width: 10,
                                height: 10,
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                "+91 $phoneNo",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColor.fromHex("#ffffff"),
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
                                addressIcon!,
                                width: 10,
                                height: 10,
                              ),
                              pw.SizedBox(
                                width: 7,
                              ),
                              pw.Text(
                                address,
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: PdfColor.fromHex("#ffffff"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Summary",
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex("#03335e"),
                          ),
                        ),
                        pw.SizedBox(
                          height: 7,
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 10),
                          child: pw.Text(
                            aboutMe,
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: pw.TextAlign.justify,
                          ),
                        ),
                        if (experience != null && experience.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 20,
                              ),
                              pw.Text(
                                "Experience",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              ...experience.map((exp) {
                                final parts = exp.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        parts[0],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      if (parts.length > 1)
                                        pw.Text(
                                          parts[1],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      if (parts.length > 2)
                                        pw.Text(
                                          parts[2],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        if (project != null && project.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 12,
                              ),
                              pw.Text(
                                "Projects",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              ...project.map((proj) {
                                final parts = proj.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        parts[0],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      if (parts.length > 1)
                                        pw.Text(
                                          parts[1],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      if (parts.length > 2)
                                        pw.Text(
                                          parts[2],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                  pw.SizedBox(
                    width: 20,
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (skill != null && skill.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Skills",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              ...skill
                                  .map((sk) => pw.Padding(
                                        padding: const pw.EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        child: pw.Text(
                                          sk,
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        if (language != null && language.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                "Languages",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              ...language
                                  .map((lang) => pw.Padding(
                                        padding: const pw.EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        child: pw.Text(
                                          lang,
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        if (education != null && education.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 15,
                              ),
                              pw.Text(
                                "Education",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              ...education.map((edu) {
                                final parts = edu.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(
                                      left: 10, bottom: 8),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        parts[0],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      if (parts.length > 1)
                                        pw.Text(
                                          parts[1],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      if (parts.length > 2)
                                        pw.Text(
                                          parts[2],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        if (achivement != null && achivement.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 12,
                              ),
                              pw.Text(
                                "Achivement",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              ...achivement
                                  .map((ach) => pw.Padding(
                                        padding: const pw.EdgeInsets.only(
                                            left: 10, bottom: 5),
                                        child: pw.Text(
                                          ach,
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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

  static void function9({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required String aboutMe,
    List? experience,
    List? achivement,
    List? language,
    List? education,
    List? skill,
    List? project,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

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
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Row(
                children: [
                  if (image != null)
                    pw.ClipOval(
                      child: pw.Container(
                        width: 110,
                        height: 110,
                        child: pw.Image(
                          image,
                          fit: pw.BoxFit.cover,
                        ),
                      ),
                    ),
                  pw.SizedBox(
                    width: 20,
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        name,
                        style: pw.TextStyle(
                          fontSize: 23,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(
                        height: 7,
                      ),
                      pw.Text(
                        profession,
                        style: pw.TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(
                height: 12,
              ),
              pw.Container(
                color: PdfColor.fromHex("#03335e"),
                child: pw.Padding(
                  padding:
                      pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Summary",
                        style: pw.TextStyle(
                          fontSize: 15,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex("#ffffff"),
                        ),
                      ),
                      pw.SizedBox(
                        height: 7,
                      ),
                      pw.Text(
                        aboutMe,
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: PdfColor.fromHex("#ffffff"),
                        ),
                        textAlign: pw.TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(
            height: 10,
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Contact",
                      style: pw.TextStyle(
                        fontSize: 15,
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
                          emailIcon!,
                          width: 10,
                          height: 10,
                        ),
                        pw.SizedBox(
                          width: 7,
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            email,
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
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
                          width: 10,
                          height: 10,
                        ),
                        pw.SizedBox(
                          width: 7,
                        ),
                        pw.Text(
                          "+91 $phoneNo",
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
                          addressIcon!,
                          width: 10,
                          height: 10,
                        ),
                        pw.SizedBox(
                          width: 7,
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            address,
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (skill != null && skill.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 20,
                          ),
                          pw.Text(
                            "Skills",
                            style: pw.TextStyle(
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          ...skill
                              .map((sk) => pw.Padding(
                                    padding:
                                        const pw.EdgeInsets.only(bottom: 6),
                                    child: pw.Row(
                                      children: [
                                        pw.ClipOval(
                                          child: pw.Container(
                                            height: 4,
                                            width: 4,
                                            color: PdfColor.fromHex("#03335e"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 8,
                                        ),
                                        pw.Text(
                                          sk,
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    if (education != null && education.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 14,
                          ),
                          pw.Text(
                            "Education",
                            style: pw.TextStyle(
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          ...education.map((edu) {
                            final parts = edu.split("\n");
                            return pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 8),
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.only(top: 5),
                                    child: pw.ClipOval(
                                      child: pw.Container(
                                        height: 4,
                                        width: 4,
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 8,
                                  ),
                                  pw.Expanded(
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          parts[0],
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        if (parts.length > 1)
                                          pw.Text(
                                            parts[1],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        if (parts.length > 2)
                                          pw.Text(
                                            parts[2],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                  ],
                ),
              ),
              pw.SizedBox(
                width: 10,
              ),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (experience != null && experience.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Experience",
                            style: pw.TextStyle(
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          ...experience.map((exp) {
                            final parts = exp.split("\n");
                            return pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 8),
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.only(top: 5),
                                    child: pw.ClipOval(
                                      child: pw.Container(
                                        height: 4,
                                        width: 4,
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 8,
                                  ),
                                  pw.Expanded(
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          parts[0],
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        if (parts.length > 1)
                                          pw.Text(
                                            parts[1],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        if (parts.length > 2)
                                          pw.Text(
                                            parts[2],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    if (achivement != null && achivement.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 12,
                          ),
                          pw.Text(
                            "Achivement",
                            style: pw.TextStyle(
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          ...achivement
                              .map((ach) => pw.Padding(
                                    padding:
                                        const pw.EdgeInsets.only(bottom: 6),
                                    child: pw.Row(
                                      children: [
                                        pw.ClipOval(
                                          child: pw.Container(
                                            height: 4,
                                            width: 4,
                                            color: PdfColor.fromHex("#03335e"),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 8,
                                        ),
                                        pw.Expanded(
                                          child: pw.Text(
                                            ach,
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    if (project != null && project.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 14,
                          ),
                          pw.Text(
                            "Projects",
                            style: pw.TextStyle(
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          ...project.map((proj) {
                            final parts = proj.split("\n");
                            return pw.Padding(
                              padding: const pw.EdgeInsets.only(bottom: 8),
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.only(top: 5),
                                    child: pw.ClipOval(
                                      child: pw.Container(
                                        height: 4,
                                        width: 4,
                                        color: PdfColor.fromHex("#03335e"),
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 8,
                                  ),
                                  pw.Expanded(
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          parts[0],
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                        ),
                                        if (parts.length > 1)
                                          pw.Text(
                                            parts[1],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        if (parts.length > 2)
                                          pw.Text(
                                            parts[2],
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    if (language != null && language.isNotEmpty)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 12,
                          ),
                          pw.Text(
                            "Languages",
                            style: pw.TextStyle(
                              fontSize: 15,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.Wrap(
                            spacing: 20,
                            runSpacing: 10,
                            children: language
                                .map((lang) => pw.Container(
                                      padding:
                                          const pw.EdgeInsets.only(bottom: 6),
                                      child: pw.Text(
                                        lang,
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
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

  static void function10({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    required String aboutMe,
    List? experience,
    List? achivement,
    List? language,
    List? education,
    List? skill,
    List? project,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

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

    try {
      addressIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_location.png"))
            .buffer
            .asUint8List(),
      );
      phoneIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_phone.png"))
            .buffer
            .asUint8List(),
      );
      emailIcon = pw.MemoryImage(
        (await rootBundle.load("assets/icons/white_email.png"))
            .buffer
            .asUint8List(),
      );
    } catch (e) {
      addressIcon = null;
      phoneIcon = null;
      emailIcon = null;
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  if (image != null)
                    pw.Container(
                      child: pw.Image(
                        image,
                        height: 150,
                        width: 150,
                      ),
                    ),
                  pw.SizedBox(
                    width: 15,
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Container(
                              height: 8,
                              width: 30,
                              color: PdfColor.fromHex("#03335e"),
                            ),
                            pw.SizedBox(
                              width: 10,
                            ),
                            pw.Text(
                              "Summary",
                              style: pw.TextStyle(
                                fontSize: 15,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex("#03335e"),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 7,
                        ),
                        pw.Text(
                          aboutMe,
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                          textAlign: pw.TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: image == null ? 20 : 0,
              ),
              pw.Container(
                color: PdfColor.fromHex("#03335e"),
                child: pw.Padding(
                  padding: pw.EdgeInsets.all(15),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              name,
                              style: pw.TextStyle(
                                fontSize: 22,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex("#ffffff"),
                              ),
                            ),
                            pw.SizedBox(
                              height: 7,
                            ),
                            pw.Text(
                              profession,
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromHex("#ffffff"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.only(right: 20),
                        child: pw.Container(
                          height: 45,
                          width: 1.5,
                          color: PdfColor.fromHex("#ffffff"),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Row(
                              children: [
                                pw.Image(
                                  emailIcon!,
                                  width: 10,
                                  height: 10,
                                ),
                                pw.SizedBox(
                                  width: 7,
                                ),
                                pw.Text(
                                  email,
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColor.fromHex("#ffffff"),
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
                                  width: 10,
                                  height: 10,
                                ),
                                pw.SizedBox(
                                  width: 7,
                                ),
                                pw.Text(
                                  "+91 $phoneNo",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColor.fromHex("#ffffff"),
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
                                  addressIcon!,
                                  width: 10,
                                  height: 10,
                                ),
                                pw.SizedBox(
                                  width: 7,
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    address,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      color: PdfColor.fromHex("#ffffff"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (skill != null && skill.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Row(
                                children: [
                                  pw.Container(
                                    height: 8,
                                    width: 30,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                  pw.SizedBox(
                                    width: 10,
                                  ),
                                  pw.Text(
                                    "Skills",
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColor.fromHex("#03335e"),
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Wrap(
                                spacing: 20,
                                runSpacing: 10,
                                children: skill
                                    .map((sk) => pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              bottom: 6),
                                          child: pw.Text(
                                            sk,
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        if (language != null && language.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 14,
                              ),
                              pw.Row(
                                children: [
                                  pw.Container(
                                    height: 8,
                                    width: 30,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                  pw.SizedBox(
                                    width: 10,
                                  ),
                                  pw.Text(
                                    "languages",
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColor.fromHex("#03335e"),
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Wrap(
                                spacing: 20,
                                runSpacing: 10,
                                children: language
                                    .map((lang) => pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              bottom: 6),
                                          child: pw.Text(
                                            lang,
                                            style: pw.TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        if (achivement != null && achivement.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 14,
                              ),
                              pw.Row(
                                children: [
                                  pw.Container(
                                    height: 8,
                                    width: 30,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                  pw.SizedBox(
                                    width: 10,
                                  ),
                                  pw.Text(
                                    "Achivements",
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColor.fromHex("#03335e"),
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              ...achivement
                                  .map((ach) => pw.Padding(
                                        padding:
                                            const pw.EdgeInsets.only(bottom: 6),
                                        child: pw.Text(
                                          ach,
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                  pw.SizedBox(
                    width: 10,
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (experience != null && experience.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Row(
                                children: [
                                  pw.Container(
                                    height: 8,
                                    width: 30,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                  pw.SizedBox(
                                    width: 10,
                                  ),
                                  pw.Text(
                                    "Experience",
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColor.fromHex("#03335e"),
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              ...experience.map((exp) {
                                final parts = exp.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 8),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        parts[0],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      if (parts.length > 1)
                                        pw.Text(
                                          parts[1],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      if (parts.length > 2)
                                        pw.Text(
                                          parts[2],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        if (education != null && education.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 12,
                              ),
                              pw.Row(
                                children: [
                                  pw.Container(
                                    height: 8,
                                    width: 30,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                  pw.SizedBox(
                                    width: 10,
                                  ),
                                  pw.Text(
                                    "Education",
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColor.fromHex("#03335e"),
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              ...education.map((edu) {
                                final parts = edu.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 8),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        parts[0],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      if (parts.length > 1)
                                        pw.Text(
                                          parts[1],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      if (parts.length > 2)
                                        pw.Text(
                                          parts[2],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        if (project != null && project.isNotEmpty)
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 12,
                              ),
                              pw.Row(
                                children: [
                                  pw.Container(
                                    height: 8,
                                    width: 30,
                                    color: PdfColor.fromHex("#03335e"),
                                  ),
                                  pw.SizedBox(
                                    width: 10,
                                  ),
                                  pw.Text(
                                    "Projects",
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColor.fromHex("#03335e"),
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              ...project.map((proj) {
                                final parts = proj.split("\n");
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(bottom: 8),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        parts[0],
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      ),
                                      if (parts.length > 1)
                                        pw.Text(
                                          parts[1],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      if (parts.length > 2)
                                        pw.Text(
                                          parts[2],
                                          style: pw.TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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
      final html.Blob blob = html.Blob([uint8list], 'application/pdf');
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

      showSnackbar(
          "Resume", "Your resume download successfully !", "$dir/$name.pdf");

      Navigator.of(context).pop();
    }
  }
}
