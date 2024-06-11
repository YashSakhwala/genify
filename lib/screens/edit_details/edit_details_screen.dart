// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widgets/layout_builder_view.dart';
import 'edit_details_view/edit_details_common_view.dart';
import 'edit_details_view/web_edit_details_view.dart';

class EditDetailsScreen extends StatefulWidget {
  final String type;
  final String amount;
  final String title;
  final String subtitle;
  final String wallet;
  final String image;
  final String uniqueTime;

  const EditDetailsScreen({
    super.key,
    required this.amount,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.wallet,
    required this.image,
    required this.uniqueTime,
  });

  @override
  State<EditDetailsScreen> createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebEditDetailsScreen(
        type: widget.type,
        amount: widget.amount,
        title: widget.title,
        subtitle: widget.subtitle,
        wallet: widget.wallet,
        image: widget.image,
        uniqueTime: widget.uniqueTime,
      ),
      tabletView: EditDetailsCommonViewScreen(
        type: widget.type,
        amount: widget.amount,
        title: widget.title,
        subtitle: widget.subtitle,
        wallet: widget.wallet,
        image: widget.image,
        uniqueTime: widget.uniqueTime,
      ),
      mobileView: EditDetailsCommonViewScreen(
        type: widget.type,
        amount: widget.amount,
        title: widget.title,
        subtitle: widget.subtitle,
        wallet: widget.wallet,
        image: widget.image,
        uniqueTime: widget.uniqueTime,
      ),
    );
  }
}
