// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/home_screen_option/banner_view/banner_common_view.dart';
import '../../widgets/layout_builder_view.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: BannerCommonViewScreen(),
      tabletView: BannerCommonViewScreen(),
      mobileView: BannerCommonViewScreen(),
    );
  }
}
