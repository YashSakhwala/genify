// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFSecondScreen extends StatefulWidget {
  const PDFSecondScreen({super.key});

  @override
  State<PDFSecondScreen> createState() => _PDFSecondScreenState();
}

class _PDFSecondScreenState extends State<PDFSecondScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clientController = TextEditingController();
  final _addressController = TextEditingController();
  final _items = <Item>[];

  @override
  void dispose() {
    _clientController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _addItem() {
    setState(() {
      _items.add(Item(name: '', quantity: 0, price: 0.0));
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _generatePdf() {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text('Client: ${_clientController.text}'),
              pw.Text('Address: ${_addressController.text}'),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                headers: ['Item', 'Quantity', 'Price', 'Total'],
                data: _items
                    .map((item) => [
                          item.name,
                          item.quantity.toString(),
                          item.price.toStringAsFixed(2),
                          (item.quantity * item.price).toStringAsFixed(2)
                        ])
                    .toList(),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Total: ${_items.fold(0.0, (sum, item) => sum + (item.quantity * item.price)).toStringAsFixed(2)}'),
              pw.Text("Item"),
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
        title: Text('Invoice Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _clientController,
                decoration: InputDecoration(labelText: 'Client Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter client name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Client Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter client address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ..._items.asMap().entries.map((entry) {
                int index = entry.key;
                Item item = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: item.name,
                        decoration: InputDecoration(labelText: 'Item Name'),
                        onChanged: (value) {
                          item.name = value;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        initialValue: item.quantity.toString(),
                        decoration: InputDecoration(labelText: 'Quantity'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          item.quantity = int.tryParse(value) ?? 0;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        initialValue: item.price.toString(),
                        decoration: InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          item.price = double.tryParse(value) ?? 0.0;
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeItem(index),
                    ),
                  ],
                );
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addItem,
                child: Text('Add Item'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _generatePdf();
                  }
                },
                child: Text('Generate PDF'),
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
