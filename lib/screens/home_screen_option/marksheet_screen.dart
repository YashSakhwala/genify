// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/home_screen_option/marksheet_view.dart/marksheet_common_view.dart';
import 'package:genify/widgets/layout_builder_view.dart';

class MarksheetScreen extends StatefulWidget {
  const MarksheetScreen({super.key});

  @override
  State<MarksheetScreen> createState() => _MarksheetScreenState();
}

class _MarksheetScreenState extends State<MarksheetScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      mobileView: MarksheetCommonViewScreen(),
      tabletView: MarksheetCommonViewScreen(),
      webView: MarksheetCommonViewScreen(),
    );
  }
}
