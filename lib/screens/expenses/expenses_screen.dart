// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/expenses/expenses_view/web_expenses_view.dart';
import '../../widgets/layout_builder_view.dart';
import 'expenses_view/expenses_common_view.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebExpenesScreen(),
      tabletView: ExpensesCommonViewScreen(),
      mobileView: ExpensesCommonViewScreen(),
    );
  }
}
