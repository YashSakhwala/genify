// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/home_screen_option/barcode_view/barcode_common_view.dart';
import '../../widgets/layout_builder_view.dart';

class BarcodeScreen extends StatefulWidget {
  const BarcodeScreen({super.key});

  @override
  State<BarcodeScreen> createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: BarcodeCommonViewScreen(),
      tabletView: BarcodeCommonViewScreen(),
      mobileView: BarcodeCommonViewScreen(),
    );
  }
}
