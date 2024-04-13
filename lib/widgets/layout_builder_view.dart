import 'package:flutter/material.dart';

class LayoutBuilderView extends StatelessWidget {
  final Widget mobileView;
  final Widget tabletView;
  final Widget webView;
  const LayoutBuilderView(
      {super.key,
      required this.mobileView,
      required this.tabletView,
      required this.webView});

  @override
  Widget build(BuildContext context) {
    // For web view
    if (MediaQuery.of(context).size.width >= 900) {
      return webView;
    }

    // For tablet view
    else if (MediaQuery.of(context).size.width >= 400 &&
        MediaQuery.of(context).size.width < 900) {
      return tabletView;
    }

    // For mobile view
    else {
      return mobileView;
    }
  }
}
