// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'add_expenses_view/add_expenses_common_view.dart';
import 'add_expenses_view/web_add_expenses_view.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({super.key});

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebAddExpensesScreen(),
      tabletView: AddExpensesCommonViewScreen(),
      mobileView: AddExpensesCommonViewScreen(),
    );
  }
}