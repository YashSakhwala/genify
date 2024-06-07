import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  void generateInvoicePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Invoice',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text('Customer Name: John Doe'),
                pw.Text('Invoice Date: 2024-05-28'),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  data: [
                    ['Item', 'Quantity', 'Price', 'Total'],
                    ['Item 1', '2', '\$15', '\$30'],
                    ['Item 2', '1', '\$50', '\$50'],
                    ['Item 3', '3', '\$10', '\$30'],
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text('Total: \$110',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    // Save or print the PDF
    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } catch (e) {
      print("Error generating PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice PDF Generator'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            generateInvoicePdf();
          },
          child: Text('Generate Invoice PDF'),
        ),
      ),
    );
  }
}
