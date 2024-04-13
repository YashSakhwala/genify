// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/bottom_bar/bottom_bar_view/web_bottom_bar_view.dart';
import 'package:genify/widgets/layout_builder_view.dart';
import 'bottom_bar_view/bottom_bar_common_view.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebBottomBarScreen(),
      tabletView: BottomBarCommonView(),
      mobileView: BottomBarCommonView(),
    );
  }
}
