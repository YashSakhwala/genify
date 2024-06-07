// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import 'package:genify/widgets/common_widgets/text_field_view.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceCommonViewScreen extends StatefulWidget {
  const InvoiceCommonViewScreen({super.key});

  @override
  State<InvoiceCommonViewScreen> createState() =>
      _InvoiceCommonViewScreenState();
}

class _InvoiceCommonViewScreenState extends State<InvoiceCommonViewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();

  List items = [];

  void generatePdf() {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Invoice",
                style: pw.TextStyle(fontSize: 24),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Text("Client: ${name.text}"),
              pw.Text("Address: ${address.text}"),
              pw.SizedBox(
                height: 20,
              ),
              pw.Table.fromTextArray(
                context: context,
                headers: ["Item", "Quantity", "Price", "Total"],
                data: items
                    .map((item) => [
                          item.name,
                          item.quantity.toString(),
                          item.price.toStringAsFixed(2),
                          (item.quantity * item.price).toStringAsFixed(2)
                        ])
                    .toList(),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Text(
                  "Total: ${items.fold(0.0, (sum, item) => sum + (item.quantity * item.price)).toStringAsFixed(2)}"),
            ],
          );
        },
      ),
    );

    Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Generator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFieldView(
                title: "Client name",
                controller: name,
                needValidator: true,
                nameValidator: true,
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldView(
                title: "Client address",
                controller: address,
                needValidator: true,
                addressValidator: true,
              ),
              SizedBox(
                height: 20,
              ),
              ...items.asMap().entries.map((entry) {
                int index = entry.key;
                Item item = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: item.name,
                        decoration: InputDecoration(
                          labelText: "Item name",
                        ),
                        onChanged: (value) {
                          item.name = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: item.quantity.toString(),
                        decoration: InputDecoration(
                          labelText: "Quantity",
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          item.quantity = int.tryParse(value) ?? 0;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: item.price.toString(),
                        decoration: InputDecoration(
                          labelText: "Price",
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          item.price = double.tryParse(value) ?? 0.0;
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          items.removeAt(index);
                        });
                      },
                    ),
                  ],
                );
              }),
              SizedBox(
                height: 40,
              ),
              ButtonView(
                title: "Add item",
                onTap: () {
                  setState(() {
                    items.add(
                      Item(name: "", quantity: 0, price: 0.0),
                    );
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              ButtonView(
                title: "Generate PDF",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    generatePdf();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  String name;
  int quantity;
  double price;

  Item({
    required this.name,
    required this.quantity,
    required this.price,
  });
}
