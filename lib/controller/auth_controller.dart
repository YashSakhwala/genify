// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genify/widgets/common_widgets/indicatior.dart';
import 'package:get/get.dart';

import '../screens/bottom_bar/bottom_bar_screen.dart';

class AuthController extends GetxController {
  RxBool isPasswordShow = false.obs;
  RxBool isConfirmPasswordShow = false.obs;

  Future<void> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    showIndicator(context);
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    print(userCredential.user!.uid);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => BottomBarScreen()),
      (route) => false,
    );
  }
}
