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
import "package:flutter/foundation.dart";
import 'package:http/http.dart' as http;

import "../../../widgets/common_widgets/snackbar_view.dart";

class CardMake {
  static String imagePath = "";
  static String backgroundImagePath = "";

  static void function1({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    Color? textColor,
    Color? backgroundColor,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? backgroundImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    final PdfColor pdfTextColor =
        textColor != null ? PdfColor.fromInt(textColor.value) : PdfColors.black;

    final PdfColor pdfBackgroundColor = backgroundColor != null
        ? PdfColor.fromInt(backgroundColor.value)
        : PdfColors.white;

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
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: pdfBackgroundColor,
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Row(
              children: [
                pw.SizedBox(
                  width: 10,
                ),
                if (image != null)
                  pw.Container(
                    height: 100,
                    width: 90,
                    decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.circular(10),
                      image: pw.DecorationImage(
                        image: pw.Image(
                          image,
                          height: 100,
                          width: 90,
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
                          color: pdfTextColor == PdfColors.black
                              ? PdfColor.fromHex("#03335e")
                              : pdfTextColor,
                        ),
                      ),
                      pw.SizedBox(
                        height: 5,
                      ),
                      pw.Text(
                        profession,
                        style: pw.TextStyle(
                          fontSize: 6,
                          color: pdfTextColor,
                        ),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Container(
                        height: 1,
                        width: 85,
                        color: PdfColor.fromHex("#03335e"),
                      ),
                      pw.SizedBox(
                        height: 15,
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
                              color: pdfTextColor,
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
                              color: pdfTextColor,
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
                          pw.SizedBox(
                            width: 120,
                            child: pw.Text(
                              address,
                              style: pw.TextStyle(
                                fontSize: 5,
                                color: pdfTextColor,
                              ),
                              textAlign: pw.TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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

  static void function2({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    Color? textColor,
    Color? backgroundColor,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? backgroundImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    final PdfColor pdfTextColor =
        textColor != null ? PdfColor.fromInt(textColor.value) : PdfColors.black;

    final PdfColor pdfBackgroundColor = backgroundColor != null
        ? PdfColor.fromInt(backgroundColor.value)
        : PdfColors.white;

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
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: pdfBackgroundColor,
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Padding(
              padding: pw.EdgeInsets.all(5),
              child: pw.Column(
                children: [
                  pw.Expanded(
                    child: pw.Padding(
                      padding: pw.EdgeInsets.all(5),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          if (image != null)
                            pw.ClipOval(
                              child: pw.Container(
                                width: 50,
                                height: 50,
                                child: pw.Image(
                                  image,
                                  width: 50,
                                  height: 50,
                                  fit: pw.BoxFit.cover,
                                ),
                              ),
                            ),
                          pw.SizedBox(
                            width: 15,
                          ),
                          pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                name,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  color: pdfTextColor == PdfColors.black
                                      ? PdfColor.fromHex("#03335e")
                                      : pdfTextColor,
                                ),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text(
                                profession,
                                style: pw.TextStyle(
                                  fontSize: 6,
                                  color: pdfTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
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
                                    pw.Expanded(
                                      child: pw.Text(
                                        address,
                                        style: pw.TextStyle(
                                          fontSize: 5,
                                          color: pdfTextColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        pw.Container(
                          height: 40,
                          width: 1,
                          color: PdfColor.fromHex("#03335e"),
                        ),
                        pw.Expanded(
                          child: pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
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
                                        color: pdfTextColor,
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
                                        color: pdfTextColor,
                                      ),
                                    ),
                                  ],
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

  static void function3({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    Color? textColor,
    Color? backgroundColor,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? backgroundImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    final PdfColor pdfTextColor =
        textColor != null ? PdfColor.fromInt(textColor.value) : PdfColors.black;

    final PdfColor pdfBackgroundColor = backgroundColor != null
        ? PdfColor.fromInt(backgroundColor.value)
        : PdfColors.white;

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
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: pdfBackgroundColor,
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      if (image != null)
                        pw.ClipOval(
                          child: pw.Container(
                            width: 50,
                            height: 50,
                            child: pw.Image(
                              image,
                              width: 50,
                              height: 50,
                              fit: pw.BoxFit.cover,
                            ),
                          ),
                        ),
                      pw.SizedBox(
                        height: 15,
                      ),
                      pw.Text(
                        name,
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: pdfTextColor == PdfColors.black
                              ? PdfColor.fromHex("#03335e")
                              : pdfTextColor,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                      pw.SizedBox(
                        height: 5,
                      ),
                      pw.Text(
                        profession,
                        style: pw.TextStyle(fontSize: 6, color: pdfTextColor),
                      ),
                    ],
                  ),
                ),
                pw.Expanded(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
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
                          pw.Expanded(
                            child: pw.Text(
                              address,
                              style: pw.TextStyle(
                                  fontSize: 5, color: pdfTextColor),
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
                            phoneIcon!,
                            height: 5,
                            width: 5,
                          ),
                          pw.SizedBox(
                            width: 5,
                          ),
                          pw.Text(
                            "+91 $phoneNo",
                            style:
                                pw.TextStyle(fontSize: 5, color: pdfTextColor),
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
                            height: 5,
                            width: 5,
                          ),
                          pw.SizedBox(
                            width: 5,
                          ),
                          pw.Text(
                            email,
                            style:
                                pw.TextStyle(fontSize: 5, color: pdfTextColor),
                          ),
                        ],
                      ),
                    ],
                  ),
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

  static void function4({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    Color? textColor,
    Color? backgroundColor,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? backgroundImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    final PdfColor pdfTextColor =
        textColor != null ? PdfColor.fromInt(textColor.value) : PdfColors.black;

    final PdfColor pdfBackgroundColor = backgroundColor != null
        ? PdfColor.fromInt(backgroundColor.value)
        : PdfColors.white;

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
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: pdfBackgroundColor,
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Container(
                    color: PdfColor.fromHex("#03335e"),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        if (image != null)
                          pw.ClipOval(
                            child: pw.Container(
                              width: 50,
                              height: 50,
                              child: pw.Image(
                                image,
                                width: 50,
                                height: 50,
                                fit: pw.BoxFit.cover,
                              ),
                            ),
                          ),
                        pw.SizedBox(
                          height: 15,
                        ),
                        pw.Text(
                          name,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                            color: pdfTextColor == PdfColors.black
                                ? PdfColors.white
                                : pdfTextColor,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(
                          height: 5,
                        ),
                        pw.Text(
                          profession,
                          style: pw.TextStyle(
                            fontSize: 6,
                            color: pdfTextColor == PdfColors.black
                                ? PdfColors.white
                                : pdfTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(
                  width: 10,
                ),
                pw.Expanded(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
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
                          pw.Expanded(
                            child: pw.Text(
                              address,
                              style: pw.TextStyle(
                                  fontSize: 5, color: pdfTextColor),
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
                            phoneIcon!,
                            height: 5,
                            width: 5,
                          ),
                          pw.SizedBox(
                            width: 5,
                          ),
                          pw.Text(
                            "+91 $phoneNo",
                            style:
                                pw.TextStyle(fontSize: 5, color: pdfTextColor),
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
                            height: 5,
                            width: 5,
                          ),
                          pw.SizedBox(
                            width: 5,
                          ),
                          pw.Text(
                            email,
                            style:
                                pw.TextStyle(fontSize: 5, color: pdfTextColor),
                          ),
                        ],
                      ),
                    ],
                  ),
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

  static void function5({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    Color? textColor,
    Color? backgroundColor,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? backgroundImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    final PdfColor pdfTextColor =
        textColor != null ? PdfColor.fromInt(textColor.value) : PdfColors.black;

    final PdfColor pdfBackgroundColor = backgroundColor != null
        ? PdfColor.fromInt(backgroundColor.value)
        : PdfColors.white;

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
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: pdfBackgroundColor,
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Padding(
              padding: pw.EdgeInsets.all(10),
              child: pw.Column(
                children: [
                  if (image != null)
                    pw.ClipOval(
                      child: pw.Container(
                        width: 50,
                        height: 50,
                        child: pw.Image(
                          image,
                          width: 50,
                          height: 50,
                          fit: pw.BoxFit.cover,
                        ),
                      ),
                    ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    name,
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: pdfTextColor == PdfColors.black
                          ? PdfColor.fromHex("#03335e")
                          : pdfTextColor,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                  pw.SizedBox(
                    height: 3,
                  ),
                  pw.Text(
                    profession,
                    style: pw.TextStyle(
                      fontSize: 6,
                      color: pdfTextColor,
                    ),
                  ),
                  pw.SizedBox(
                    height: 7,
                  ),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                          child: pw.Column(
                            children: [
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
                                  pw.Expanded(
                                    child: pw.Text(
                                      address,
                                      style: pw.TextStyle(
                                        fontSize: 5,
                                        color: pdfTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 20,
                        width: 1,
                        color: PdfColor.fromHex("#03335e"),
                      ),
                      pw.Expanded(
                        child: pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                          child: pw.Column(
                            children: [
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
                                      color: pdfTextColor,
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
                                      color: pdfTextColor,
                                    ),
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

  static void function6({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    Color? textColor,
    Color? backgroundColor,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? backgroundImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    final PdfColor pdfTextColor =
        textColor != null ? PdfColor.fromInt(textColor.value) : PdfColors.black;

    final PdfColor pdfBackgroundColor = backgroundColor != null
        ? PdfColor.fromInt(backgroundColor.value)
        : PdfColors.white;

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
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: pdfBackgroundColor,
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Row(
              children: [
                pw.SizedBox(
                  width: 10,
                ),
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    if (image != null)
                      pw.Container(
                        height: 85,
                        width: 75,
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(10),
                          image: pw.DecorationImage(
                            image: pw.Image(
                              image,
                              height: 100,
                              width: 90,
                              fit: pw.BoxFit.fill,
                            ).image,
                          ),
                        ),
                      ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Text(
                      name,
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: pdfTextColor == PdfColors.black
                            ? PdfColor.fromHex("#03335e")
                            : pdfTextColor,
                      ),
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Text(
                      profession,
                      style: pw.TextStyle(
                        fontSize: 6,
                        color: pdfTextColor,
                      ),
                    ),
                  ],
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
                              color: pdfTextColor,
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
                              color: pdfTextColor,
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
                          pw.SizedBox(
                            width: 120,
                            child: pw.Expanded(
                              child: pw.Text(
                                address,
                                style: pw.TextStyle(
                                  fontSize: 5,
                                  color: pdfTextColor,
                                ),
                                textAlign: pw.TextAlign.justify,
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

  static void function7({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    Color? textColor,
    Color? backgroundColor,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? backgroundImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    final PdfColor pdfTextColor =
        textColor != null ? PdfColor.fromInt(textColor.value) : PdfColors.black;

    final PdfColor pdfBackgroundColor = backgroundColor != null
        ? PdfColor.fromInt(backgroundColor.value)
        : PdfColors.white;

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
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: pdfBackgroundColor,
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Row(
              children: [
                pw.SizedBox(
                  width: 10,
                ),
                pw.Container(
                  height: 200,
                  width: 90,
                  color: PdfColor.fromHex("#03335e"),
                  child: pw.Stack(
                    children: [
                      if (image != null)
                        pw.Container(
                          height: 100,
                          width: 70,
                          decoration: pw.BoxDecoration(
                            image: pw.DecorationImage(
                              image: pw.Image(
                                image,
                                height: 100,
                                width: 90,
                                fit: pw.BoxFit.fill,
                              ).image,
                            ),
                          ),
                        ),
                      pw.Positioned(
                        bottom: 0,
                        child: pw.Container(
                          height: 45,
                          width: 30,
                          decoration: pw.BoxDecoration(
                            color: pdfBackgroundColor,
                            border: pw.Border(
                              left: pw.BorderSide(
                                color: PdfColor.fromHex("#03335e"),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                          color: pdfTextColor == PdfColors.black
                              ? PdfColor.fromHex("#03335e")
                              : pdfTextColor,
                        ),
                      ),
                      pw.SizedBox(
                        height: 5,
                      ),
                      pw.Text(
                        profession,
                        style: pw.TextStyle(
                          fontSize: 6,
                          color: pdfTextColor,
                        ),
                      ),
                      pw.SizedBox(
                        height: 15,
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
                              color: pdfTextColor,
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
                              color: pdfTextColor,
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
                          pw.SizedBox(
                            width: 120,
                            child: pw.Text(
                              address,
                              style: pw.TextStyle(
                                fontSize: 5,
                                color: pdfTextColor,
                              ),
                              textAlign: pw.TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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

  static void function8({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    Color? textColor,
    Color? backgroundColor,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? backgroundImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    final PdfColor pdfTextColor =
        textColor != null ? PdfColor.fromInt(textColor.value) : PdfColors.black;

    final PdfColor pdfBackgroundColor = backgroundColor != null
        ? PdfColor.fromInt(backgroundColor.value)
        : PdfColors.white;

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
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: pdfBackgroundColor,
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Padding(
              padding: pw.EdgeInsets.all(5),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Expanded(
                    child: pw.Padding(
                      padding:
                          pw.EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          if (image != null)
                            pw.ClipOval(
                              child: pw.Container(
                                width: 50,
                                height: 50,
                                child: pw.Image(
                                  image,
                                  width: 50,
                                  height: 50,
                                  fit: pw.BoxFit.cover,
                                ),
                              ),
                            ),
                          pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                name,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  color: pdfTextColor == PdfColors.black
                                      ? PdfColor.fromHex("#03335e")
                                      : pdfTextColor,
                                ),
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text(
                                profession,
                                style: pw.TextStyle(
                                  fontSize: 6,
                                  color: pdfTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 25),
                    child: pw.Container(
                      height: 1,
                      width: double.infinity,
                      color: PdfColor.fromHex("#03335e"),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Padding(
                      padding:
                          pw.EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: pw.Column(
                        children: [
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
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
                                      color: pdfTextColor,
                                    ),
                                  ),
                                ],
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
                                      color: pdfTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.symmetric(horizontal: 30),
                            child: pw.Row(
                              children: [
                                pw.Image(
                                  addressIcon!,
                                  height: 5,
                                  width: 5,
                                ),
                                pw.SizedBox(
                                  width: 5,
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    address,
                                    style: pw.TextStyle(
                                      fontSize: 5,
                                      color: pdfTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

  static void function9({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    Color? textColor,
    Color? backgroundColor,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? backgroundImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    final PdfColor pdfTextColor =
        textColor != null ? PdfColor.fromInt(textColor.value) : PdfColors.black;

    final PdfColor pdfBackgroundColor = backgroundColor != null
        ? PdfColor.fromInt(backgroundColor.value)
        : PdfColors.white;

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
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: pdfBackgroundColor,
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Row(
              children: [
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
                          color: pdfTextColor == PdfColors.black
                              ? PdfColor.fromHex("#03335e")
                              : pdfTextColor,
                        ),
                      ),
                      pw.SizedBox(
                        height: 5,
                      ),
                      pw.Text(
                        profession,
                        style: pw.TextStyle(
                          fontSize: 6,
                          color: pdfTextColor,
                        ),
                      ),
                      pw.SizedBox(
                        height: 20,
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
                              color: pdfTextColor,
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
                              color: pdfTextColor,
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
                          pw.SizedBox(
                            width: 120,
                            child: pw.Text(
                              address,
                              style: pw.TextStyle(
                                fontSize: 5,
                                color: pdfTextColor,
                              ),
                              textAlign: pw.TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  width: 10,
                ),
                if (image != null)
                  pw.Container(
                    height: double.infinity,
                    width: 120,
                    decoration: pw.BoxDecoration(
                      image: pw.DecorationImage(
                        image: pw.Image(
                          image,
                          fit: pw.BoxFit.fill,
                        ).image,
                      ),
                    ),
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

  static void function10({
    required String name,
    required String profession,
    required String email,
    required String phoneNo,
    required String address,
    Color? textColor,
    Color? backgroundColor,
    required BuildContext context,
  }) async {
    showIndicator(context);

    final pdf = pw.Document();
    pw.MemoryImage? image;
    pw.MemoryImage? backgroundImage;
    pw.MemoryImage? addressIcon;
    pw.MemoryImage? phoneIcon;
    pw.MemoryImage? emailIcon;

    final PdfColor pdfTextColor =
        textColor != null ? PdfColor.fromInt(textColor.value) : PdfColors.black;

    final PdfColor pdfBackgroundColor = backgroundColor != null
        ? PdfColor.fromInt(backgroundColor.value)
        : PdfColors.white;

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
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: pdfBackgroundColor,
              image: backgroundImage != null
                  ? pw.DecorationImage(
                      image: pw.Image(
                      backgroundImage,
                      fit: pw.BoxFit.cover,
                    ).image)
                  : null,
            ),
            child: pw.Padding(
              padding: pw.EdgeInsets.all(10),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (image != null)
                    pw.ClipOval(
                      child: pw.Container(
                        width: 30,
                        height: 30,
                        child: pw.Image(
                          image,
                          width: 30,
                          height: 30,
                          fit: pw.BoxFit.cover,
                        ),
                      ),
                    ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                    name,
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: pdfTextColor == PdfColors.black
                          ? PdfColor.fromHex("#03335e")
                          : pdfTextColor,
                    ),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Text(
                    profession,
                    style: pw.TextStyle(
                      fontSize: 6,
                      color: pdfTextColor,
                    ),
                  ),
                  pw.SizedBox(
                    height: 20,
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
                          color: pdfTextColor,
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
                          color: pdfTextColor,
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
                      pw.Expanded(
                        child: pw.Text(
                          address,
                          style: pw.TextStyle(
                            fontSize: 5,
                            color: pdfTextColor,
                          ),
                        ),
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
        msg: "Card download process is complete",
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
          "Card", "Your card download successfully !", "$dir/$name.pdf");

      Navigator.of(context).pop();
    }
  }
}
