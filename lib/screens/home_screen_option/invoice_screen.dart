// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'invoice_view/invoice_common_view.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: InvoiceCommonViewScreen(),
      tabletView: InvoiceCommonViewScreen(),
      mobileView: InvoiceCommonViewScreen(),
    );
  }
}