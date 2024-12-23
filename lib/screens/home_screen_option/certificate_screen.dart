// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/home_screen_option/certificate_view/certificate_common_view.dart';
import 'package:genify/widgets/layout_builder_view.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      mobileView: CertificateCommonViewScreen(),
      tabletView: CertificateCommonViewScreen(),
      webView: CertificateCommonViewScreen(),
    );
  }
}
