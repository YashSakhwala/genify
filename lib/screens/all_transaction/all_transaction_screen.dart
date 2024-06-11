// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'all_transaction_view/all_transaction_common_view.dart';
import 'all_transaction_view/web_all_transaction_view.dart';

class AllTransactionScreen extends StatefulWidget {
  const AllTransactionScreen({super.key});

  @override
  State<AllTransactionScreen> createState() => _AllTransactionScreenState();
}

class _AllTransactionScreenState extends State<AllTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebAllTransactionScreen(),
      tabletView: AllTransactionCommonViewScreen(),
      mobileView: AllTransactionCommonViewScreen(),
    );
  }
}