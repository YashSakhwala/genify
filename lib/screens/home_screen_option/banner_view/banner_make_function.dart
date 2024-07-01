// ignore_for_file: unused_local_variable, use_build_context_synchronously, prefer_const_constructors

import "dart:io" as io;
import "package:external_path/external_path.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:genify/screens/bottom_bar/bottom_bar_screen.dart";
import "package:genify/widgets/common_widgets/indicatior.dart";
import "package:genify/widgets/common_widgets/toast_view.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;
import "package:universal_html/html.dart" as html;
import "package:flutter/foundation.dart";
import 'package:http/http.dart' as http;
import "../../../widgets/common_widgets/snackbar_view.dart";

class BannerMake {
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
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/bg_1.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
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
            PdfPageFormat(24 * PdfPageFormat.inch, 10 * PdfPageFormat.inch),
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
              padding: pw.EdgeInsets.all(30),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      if (image != null)
                        pw.Container(
                          height: 230,
                          width: 230,
                          decoration: pw.BoxDecoration(
                            shape: pw.BoxShape.circle,
                            border: pw.Border.all(
                              color: PdfColor.fromHex("#03335e"),
                              width: 3,
                            ),
                            image: pw.DecorationImage(
                              image: pw.Image(
                                image,
                                height: 230,
                                width: 230,
                                fit: pw.BoxFit.fill,
                              ).image,
                            ),
                          ),
                        ),
                      pw.SizedBox(
                        height: 25,
                      ),
                      pw.Text(
                        name,
                        style: pw.TextStyle(
                          fontSize: 35,
                          fontWeight: pw.FontWeight.bold,
                          color: pdfTextColor == PdfColors.black
                              ? PdfColor.fromHex("#03335e")
                              : pdfTextColor,
                        ),
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Text(
                        profession,
                        style: pw.TextStyle(
                          fontSize: 20,
                          color: pdfTextColor,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    width: 200,
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Row(
                        children: [
                          pw.Image(
                            phoneIcon!,
                            height: 30,
                            width: 30,
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Text(
                            "+91 $phoneNo",
                            style: pw.TextStyle(
                              fontSize: 30,
                              color: pdfTextColor,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Row(
                        children: [
                          pw.Image(
                            emailIcon!,
                            height: 30,
                            width: 30,
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Text(
                            email,
                            style: pw.TextStyle(
                              fontSize: 30,
                              color: pdfTextColor,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Row(
                        children: [
                          pw.Image(
                            addressIcon!,
                            height: 30,
                            width: 30,
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Text(
                            address,
                            style: pw.TextStyle(
                              fontSize: 30,
                              color: pdfTextColor,
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
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/bg_2.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
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
            PdfPageFormat(24 * PdfPageFormat.inch, 10 * PdfPageFormat.inch),
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
              padding: pw.EdgeInsets.all(50),
              child: pw.Column(
                children: [
                  pw.Expanded(
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Row(
                          children: [
                            pw.Image(
                              emailIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Text(
                              email,
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                        pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            if (image != null)
                              pw.Container(
                                height: 230,
                                width: 230,
                                decoration: pw.BoxDecoration(
                                  shape: pw.BoxShape.circle,
                                  border: pw.Border.all(
                                    color: PdfColor.fromHex("#03335e"),
                                    width: 3,
                                  ),
                                  image: pw.DecorationImage(
                                    image: pw.Image(
                                      image,
                                      height: 230,
                                      width: 230,
                                      fit: pw.BoxFit.fill,
                                    ).image,
                                  ),
                                ),
                              ),
                            pw.SizedBox(
                              height: 25,
                            ),
                            pw.Text(
                              name,
                              style: pw.TextStyle(
                                fontSize: 35,
                                fontWeight: pw.FontWeight.bold,
                                color: pdfTextColor == PdfColors.black
                                    ? PdfColor.fromHex("#03335e")
                                    : pdfTextColor,
                              ),
                            ),
                            pw.SizedBox(
                              height: 20,
                            ),
                            pw.Text(
                              profession,
                              style: pw.TextStyle(
                                fontSize: 20,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              phoneIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Text(
                              "+91 $phoneNo",
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Row(
                        children: [
                          pw.Image(
                            addressIcon!,
                            height: 30,
                            width: 30,
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Text(
                            address,
                            style: pw.TextStyle(
                              fontSize: 30,
                              color: pdfTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: 70,
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
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/bg_3.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
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
            PdfPageFormat(24 * PdfPageFormat.inch, 10 * PdfPageFormat.inch),
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
              padding: pw.EdgeInsets.all(50),
              child: pw.Row(
                children: [
                  if (image != null)
                    pw.Container(
                      height: double.infinity,
                      width: 500,
                      decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(50),
                        image: pw.DecorationImage(
                          image: pw.Image(
                            image,
                            fit: pw.BoxFit.fill,
                          ).image,
                        ),
                      ),
                    ),
                  pw.SizedBox(
                    width: 250,
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          name,
                          style: pw.TextStyle(
                            fontSize: 50,
                            fontWeight: pw.FontWeight.bold,
                            color: pdfTextColor == PdfColors.black
                                ? PdfColor.fromHex("#03335e")
                                : pdfTextColor,
                          ),
                        ),
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Text(
                          profession,
                          style: pw.TextStyle(
                            fontSize: 30,
                            color: pdfTextColor,
                          ),
                        ),
                        pw.SizedBox(
                          height: 70,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              phoneIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Text(
                              "+91 $phoneNo",
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 30,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              emailIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Text(
                              email,
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 30,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              addressIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.SizedBox(
                              width: 600,
                              child: pw.Text(
                                address,
                                style: pw.TextStyle(
                                  fontSize: 30,
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
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/bg_4.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
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
            PdfPageFormat(24 * PdfPageFormat.inch, 10 * PdfPageFormat.inch),
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
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(50),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          name,
                          style: pw.TextStyle(
                            fontSize: 50,
                            fontWeight: pw.FontWeight.bold,
                            color: pdfTextColor == PdfColors.black
                                ? PdfColor.fromHex("#03335e")
                                : pdfTextColor,
                          ),
                        ),
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Text(
                          profession,
                          style: pw.TextStyle(
                            fontSize: 30,
                            color: pdfTextColor,
                          ),
                        ),
                        pw.SizedBox(
                          height: 70,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              phoneIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Text(
                              "+91 $phoneNo",
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 30,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              emailIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Text(
                              email,
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 30,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              addressIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.SizedBox(
                              width: 600,
                              child: pw.Text(
                                address,
                                style: pw.TextStyle(
                                  fontSize: 30,
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
                ),
                if (image != null)
                  pw.Expanded(
                    child: pw.Container(
                      height: double.infinity,
                      width: 800,
                      decoration: pw.BoxDecoration(
                        image: pw.DecorationImage(
                          image: pw.Image(
                            image,
                            fit: pw.BoxFit.fill,
                          ).image,
                        ),
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
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/bg_5.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
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
            PdfPageFormat(24 * PdfPageFormat.inch, 10 * PdfPageFormat.inch),
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
              padding: pw.EdgeInsets.all(40),
              child: pw.Container(
                height: 600,
                width: 1650,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColor.fromHex("#03335e"),
                    width: 3,
                  ),
                ),
                child: pw.Padding(
                  padding: pw.EdgeInsets.all(60),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              name,
                              style: pw.TextStyle(
                                fontSize: 50,
                                fontWeight: pw.FontWeight.bold,
                                color: pdfTextColor == PdfColors.black
                                    ? PdfColor.fromHex("#03335e")
                                    : pdfTextColor,
                              ),
                            ),
                            pw.SizedBox(
                              height: 20,
                            ),
                            pw.Text(
                              profession,
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                            pw.SizedBox(
                              height: 70,
                            ),
                            pw.Row(
                              children: [
                                pw.Image(
                                  phoneIcon!,
                                  height: 30,
                                  width: 30,
                                ),
                                pw.SizedBox(
                                  width: 20,
                                ),
                                pw.Text(
                                  "+91 $phoneNo",
                                  style: pw.TextStyle(
                                    fontSize: 30,
                                    color: pdfTextColor,
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 30,
                            ),
                            pw.Row(
                              children: [
                                pw.Image(
                                  emailIcon!,
                                  height: 30,
                                  width: 30,
                                ),
                                pw.SizedBox(
                                  width: 20,
                                ),
                                pw.Text(
                                  email,
                                  style: pw.TextStyle(
                                    fontSize: 30,
                                    color: pdfTextColor,
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 30,
                            ),
                            pw.Row(
                              children: [
                                pw.Image(
                                  addressIcon!,
                                  height: 30,
                                  width: 30,
                                ),
                                pw.SizedBox(
                                  width: 20,
                                ),
                                pw.SizedBox(
                                  width: 600,
                                  child: pw.Text(
                                    address,
                                    style: pw.TextStyle(
                                      fontSize: 30,
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
                      if (image != null)
                        pw.Container(
                          height: double.infinity,
                          width: 500,
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
                ),
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
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/bg_6.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
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
            PdfPageFormat(24 * PdfPageFormat.inch, 10 * PdfPageFormat.inch),
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
              padding: pw.EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                    height: double.infinity,
                    width: 5,
                    color: PdfColor.fromHex("#03335e"),
                  ),
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        name,
                        style: pw.TextStyle(
                          fontSize: 40,
                          fontWeight: pw.FontWeight.bold,
                          color: pdfTextColor == PdfColors.black
                              ? PdfColor.fromHex("#03335e")
                              : pdfTextColor,
                        ),
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Text(
                        profession,
                        style: pw.TextStyle(
                          fontSize: 25,
                          color: pdfTextColor,
                        ),
                      ),
                      pw.SizedBox(
                        height: 30,
                      ),
                      if (image != null)
                        pw.Container(
                          height: 230,
                          width: 230,
                          decoration: pw.BoxDecoration(
                            shape: pw.BoxShape.circle,
                            border: pw.Border.all(
                              color: PdfColor.fromHex("#03335e"),
                              width: 3,
                            ),
                            image: pw.DecorationImage(
                              image: pw.Image(
                                image,
                                height: 230,
                                width: 230,
                                fit: pw.BoxFit.fill,
                              ).image,
                            ),
                          ),
                        ),
                      pw.SizedBox(
                        height: 30,
                      ),
                      pw.Row(
                        children: [
                          pw.Image(
                            phoneIcon!,
                            height: 30,
                            width: 30,
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Text(
                            "+91 $phoneNo",
                            style: pw.TextStyle(
                              fontSize: 30,
                              color: pdfTextColor,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Row(
                        children: [
                          pw.Image(
                            emailIcon!,
                            height: 30,
                            width: 30,
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Text(
                            email,
                            style: pw.TextStyle(
                              fontSize: 30,
                              color: pdfTextColor,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Row(
                        children: [
                          pw.Image(
                            addressIcon!,
                            height: 30,
                            width: 30,
                          ),
                          pw.SizedBox(
                            width: 20,
                          ),
                          pw.Text(
                            address,
                            style: pw.TextStyle(
                              fontSize: 30,
                              color: pdfTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Container(
                    height: double.infinity,
                    width: 5,
                    color: PdfColor.fromHex("#03335e"),
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
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/bg_7.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
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
            PdfPageFormat(24 * PdfPageFormat.inch, 10 * PdfPageFormat.inch),
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
            child: pw.Column(
              children: [
                pw.Container(
                  height: 150,
                  width: double.infinity,
                  color: PdfColor.fromHex("#03335e"),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.only(bottom: 30, left: 50),
                    child: pw.Align(
                      alignment: pw.Alignment.bottomLeft,
                      child: pw.Text(
                        name,
                        style: pw.TextStyle(
                          fontSize: 45,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex("#ffffff"),
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(50),
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              profession,
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                            pw.SizedBox(
                              height: 50,
                            ),
                            pw.Row(
                              children: [
                                pw.Image(
                                  phoneIcon!,
                                  height: 30,
                                  width: 30,
                                ),
                                pw.SizedBox(
                                  width: 20,
                                ),
                                pw.Text(
                                  "+91 $phoneNo",
                                  style: pw.TextStyle(
                                    fontSize: 30,
                                    color: pdfTextColor,
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 20,
                            ),
                            pw.Row(
                              children: [
                                pw.Image(
                                  emailIcon!,
                                  height: 30,
                                  width: 30,
                                ),
                                pw.SizedBox(
                                  width: 20,
                                ),
                                pw.Text(
                                  email,
                                  style: pw.TextStyle(
                                    fontSize: 30,
                                    color: pdfTextColor,
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 20,
                            ),
                            pw.Row(
                              children: [
                                pw.Image(
                                  addressIcon!,
                                  height: 30,
                                  width: 30,
                                ),
                                pw.SizedBox(
                                  width: 20,
                                ),
                                pw.SizedBox(
                                  width: 600,
                                  child: pw.Text(
                                    address,
                                    style: pw.TextStyle(
                                      fontSize: 30,
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
                    pw.Expanded(
                      child: image != null
                          ? pw.Column(
                              children: [
                                pw.Container(
                                  height: 470,
                                  width: double.infinity,
                                  decoration: pw.BoxDecoration(
                                    image: pw.DecorationImage(
                                      image: pw.Image(
                                        image,
                                        fit: pw.BoxFit.fill,
                                      ).image,
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  height: 100,
                                  width: double.infinity,
                                  color: PdfColor.fromHex("#03335e"),
                                ),
                              ],
                            )
                          : pw.SizedBox(),
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
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/bg_8.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
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
            PdfPageFormat(24 * PdfPageFormat.inch, 10 * PdfPageFormat.inch),
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
            child: pw.Column(
              children: [
                pw.Container(
                  height: 250,
                  width: double.infinity,
                  child: pw.Padding(
                    padding: pw.EdgeInsets.only(bottom: 30),
                    child: pw.Align(
                      alignment: pw.Alignment.bottomLeft,
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex("#03335e"),
                          borderRadius: pw.BorderRadius.only(
                            topRight: pw.Radius.circular(40),
                            bottomRight: pw.Radius.circular(40),
                          ),
                        ),
                        child: pw.Padding(
                          padding: pw.EdgeInsets.symmetric(
                              horizontal: 50, vertical: 30),
                          child: pw.Text(
                            name,
                            style: pw.TextStyle(
                              fontSize: 45,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex("#ffffff"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.only(right: 300),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(50),
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              profession,
                              style: pw.TextStyle(
                                fontSize: 35,
                                color: pdfTextColor,
                              ),
                            ),
                            pw.SizedBox(
                              height: 50,
                            ),
                            pw.Row(
                              children: [
                                pw.Image(
                                  phoneIcon!,
                                  height: 30,
                                  width: 30,
                                ),
                                pw.SizedBox(
                                  width: 20,
                                ),
                                pw.Text(
                                  "+91 $phoneNo",
                                  style: pw.TextStyle(
                                    fontSize: 30,
                                    color: pdfTextColor,
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 20,
                            ),
                            pw.Row(
                              children: [
                                pw.Image(
                                  emailIcon!,
                                  height: 30,
                                  width: 30,
                                ),
                                pw.SizedBox(
                                  width: 20,
                                ),
                                pw.Text(
                                  email,
                                  style: pw.TextStyle(
                                    fontSize: 30,
                                    color: pdfTextColor,
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 20,
                            ),
                            pw.Row(
                              children: [
                                pw.Image(
                                  addressIcon!,
                                  height: 30,
                                  width: 30,
                                ),
                                pw.SizedBox(
                                  width: 20,
                                ),
                                pw.SizedBox(
                                  width: 600,
                                  child: pw.Text(
                                    address,
                                    style: pw.TextStyle(
                                      fontSize: 30,
                                      color: pdfTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (image != null)
                        pw.Container(
                          height: 470,
                          width: 320,
                          decoration: pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.only(
                              topLeft: pw.Radius.circular(140),
                              topRight: pw.Radius.circular(140),
                            ),
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
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/bg_9.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
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
            PdfPageFormat(24 * PdfPageFormat.inch, 10 * PdfPageFormat.inch),
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
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(50),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          decoration: pw.BoxDecoration(
                            color: PdfColor.fromHex("#03335e"),
                            borderRadius: pw.BorderRadius.circular(50),
                          ),
                          child: pw.Padding(
                            padding: pw.EdgeInsets.symmetric(
                                horizontal: 50, vertical: 30),
                            child: pw.Text(
                              name,
                              style: pw.TextStyle(
                                fontSize: 45,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex("#ffffff"),
                              ),
                            ),
                          ),
                        ),
                        pw.SizedBox(
                          height: 40,
                        ),
                        pw.Text(
                          profession,
                          style: pw.TextStyle(
                            fontSize: 30,
                            color: pdfTextColor,
                          ),
                        ),
                        pw.SizedBox(
                          height: 70,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              phoneIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Text(
                              "+91 $phoneNo",
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 30,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              emailIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Text(
                              email,
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 30,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              addressIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.SizedBox(
                              width: 600,
                              child: pw.Text(
                                address,
                                style: pw.TextStyle(
                                  fontSize: 30,
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
                ),
                pw.Expanded(
                  child: pw.Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.only(
                        topLeft: pw.Radius.circular(70),
                        bottomLeft: pw.Radius.circular(70),
                      ),
                      color: PdfColor.fromHex("#03335e"),
                    ),
                    child: image != null
                        ? pw.Center(
                            child: pw.Container(
                              width: 530,
                              height: 530,
                              decoration: pw.BoxDecoration(
                                shape: pw.BoxShape.circle,
                                color: PdfColor.fromHex("#03335e"),
                                border: pw.Border.all(
                                  color: PdfColors.white,
                                  width: 13,
                                ),
                              ),
                              child: pw.Center(
                                child: pw.Container(
                                  width: 400,
                                  height: 400,
                                  decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.circle,
                                    image: pw.DecorationImage(
                                      image: pw.Image(image).image,
                                      fit: pw.BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : pw.SizedBox(),
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
    } else {
      try {
        backgroundImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/bg_10.png"))
              .buffer
              .asUint8List(),
        );
      } catch (e) {
        backgroundImage = null;
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
            PdfPageFormat(24 * PdfPageFormat.inch, 10 * PdfPageFormat.inch),
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
                    height: double.infinity,
                    width: double.infinity,
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex("#03335e"),
                    ),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        if (image != null)
                          pw.Container(
                            width: 350,
                            height: 350,
                            decoration: pw.BoxDecoration(
                              shape: pw.BoxShape.circle,
                              image: pw.DecorationImage(
                                image: pw.Image(image).image,
                                fit: pw.BoxFit.cover,
                              ),
                            ),
                          ),
                        pw.SizedBox(
                          height: 40,
                        ),
                        pw.Text(
                          name,
                          style: pw.TextStyle(
                            fontSize: 45,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex("#ffffff"),
                          ),
                        ),
                        pw.SizedBox(
                          height: 30,
                        ),
                        pw.Text(
                          profession,
                          style: pw.TextStyle(
                            fontSize: 30,
                            color: PdfColor.fromHex("#ffffff"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Expanded(
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(50),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Image(
                              phoneIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Text(
                              "+91 $phoneNo",
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 30,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              emailIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.Text(
                              email,
                              style: pw.TextStyle(
                                fontSize: 30,
                                color: pdfTextColor,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 30,
                        ),
                        pw.Row(
                          children: [
                            pw.Image(
                              addressIcon!,
                              height: 30,
                              width: 30,
                            ),
                            pw.SizedBox(
                              width: 20,
                            ),
                            pw.SizedBox(
                              width: 600,
                              child: pw.Text(
                                address,
                                style: pw.TextStyle(
                                  fontSize: 30,
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
        msg: "Banner download process is complete",
        context: context,
      );

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BottomBarScreen(),
          ),
          (route) => false);
    } else {
      final dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String name = DateTime.now().millisecondsSinceEpoch.toString();

      final String path = "$dir/$name.pdf";
      final io.File file = io.File(path);
      await file.writeAsBytes(uint8list);

      showSnackbar(
          "Banner", "Your banner download successfully !", "$dir/$name.pdf");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BottomBarScreen(),
          ),
          (route) => false);
    }
  }
}