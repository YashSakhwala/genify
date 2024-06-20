// ignore_for_file: prefer_const_constructors

// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:genify/screens/home/home_view/web_home_view.dart';
// import 'package:get/get.dart';
import '../../widgets/layout_builder_view.dart';
// import '../no_network/no_internet_screen.dart';
import 'home_view/home_common_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> connectivitySubscription;
  // @override
  // void initState() {
  //   connectivitySubscription =
  //       _connectivity.onConnectivityChanged.listen(updateConnectionState);

  //   super.initState();
  // }

  // Future<void> initConnectivity() async {
  //   late ConnectivityResult result;

  //   result = await _connectivity.checkConnectivity();
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   return updateConnectionState(result);
  // }

  // Future<void> updateConnectionState(ConnectivityResult result) async {
  //   if (result == ConnectivityResult.mobile ||
  //       result == ConnectivityResult.wifi) {
  //     showStatus(result, true);
  //   } else {
  //     showStatus(result, false);
  //   }
  // }

  // void showStatus(ConnectivityResult result, bool status) {
  //   status == true
  //       ? Get.back()
  //       : Get.to(
  //           () => const NoInternetScreen(),
  //         );
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilderView(
      webView: WebHomeScreen(),
      tabletView: HomeCommonViewScreen(),
      mobileView: HomeCommonViewScreen(),
    );
  }
}
