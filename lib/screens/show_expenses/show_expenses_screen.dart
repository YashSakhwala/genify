// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'show_expenses_view/show_expenses_common_view.dart';
import 'show_expenses_view/web_show_expenses_view.dart';

class ShowExpensesScreen extends StatefulWidget {
  const ShowExpensesScreen({super.key});

  @override
  State<ShowExpensesScreen> createState() => _ShowExpensesScreenState();
}

class _ShowExpensesScreenState extends State<ShowExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebShowExpensesScreen(),
      tabletView: ShowExpensesCommonViewScreen(),
      mobileView: ShowExpensesCommonViewScreen(),
    );
  }
}
