// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/home_screen_option/card_view/card_common_view.dart';
import '../../widgets/layout_builder_view.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: CardCommonViewScreen(),
      tabletView: CardCommonViewScreen(),
      mobileView: CardCommonViewScreen(),
    );
  }
}