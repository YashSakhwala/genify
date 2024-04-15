// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors, unrelated_type_equality_checks

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:genify/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import '../widgets/common_widgets/indicatior.dart';
import 'local_storage.dart';

class AuthController extends GetxController {
  RxBool isPasswordShow = true.obs;
  RxBool isConfirmPasswordShow = true.obs;
  RxBool isSignUpScreen = true.obs;

  Future<void> logIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      showIndicator(context);
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      if (isSignUpScreen == true) {
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        print(userCredential.user!.uid);
      } else {
        UserCredential userCredential = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);

        print(userCredential.user!.uid);
      }

      LocalStorage.sharedPreferences.setBool(LocalStorage.logIn, true);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomBarScreen()),
        (route) => false,
      );
    } catch (e) {
      toastMessage(msg: "Email is incorrect");
      // toastMessage(msg: e.toString());

      Navigator.of(context).pop();
    }
  }
}
