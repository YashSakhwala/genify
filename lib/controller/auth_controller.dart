// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genify/controller/local_storage.dart';
import 'package:genify/widgets/common_widgets/indicatior.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import 'package:get/get.dart';
import '../screens/bottom_bar/bottom_bar_screen.dart';

class AuthController extends GetxController {
  RxBool isPasswordShow = true.obs;
  RxBool isConfirmPasswordShow = true.obs;

  Future<void> logIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      showIndicator(context);
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      LocalStorage.sharedPreferences.setBool(LocalStorage.logIn, true);

      print(userCredential.user!.uid);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomBarScreen()),
        (route) => false,
      );
    } catch (e) {
      toastMessage(msg: "Email is incorrect");

      Navigator.of(context).pop();
    }
  }
}
