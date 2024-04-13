// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/home/home_view/web_home_view.dart';
import '../../widgets/layout_builder_view.dart';
import 'home_view/home_common_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebHomeScreen(),
      tabletView: HomeCommonViewScreen(),
      mobileView: HomeCommonViewScreen(),
    );
    
   
  }
}
