// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:genify/widgets/common_widgets/indicatior.dart';
import 'package:get/get.dart';
import 'package:genify/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import '../config/local_storage.dart';

class AuthController extends GetxController {
  final RxBool isLoginPasswordShow = true.obs;
  final RxBool isSignUpPasswordShow = true.obs;
  final RxBool isConfirmPasswordShow = true.obs;
  final RxString imagePath = "".obs;

  Future<void> logIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      showIndicator(context);
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      print(userCredential.user!.uid);

      await LocalStorage.sharedPreferences.setBool(LocalStorage.logIn, true);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const BottomBarScreen()),
        (route) => false,
      );
    } catch (e) {
      toastMessage(msg: "Email or password is incorrect", context: context);
      Navigator.of(context).pop();
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String phoneNo,
    required BuildContext context,
  }) async {
    try {
      showIndicator(context);
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String userId = userCredential.user!.uid;

      FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      File file = File(imagePath.value);

      if (await file.exists()) {
        String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
        String ext = imagePath.value.split("/").last.split(".").last;

        Reference reference = firebaseStorage.ref("$dateTime.$ext");

        UploadTask uploadTask = reference.putFile(file);

        TaskSnapshot taskSnapshot = await uploadTask;

        if (taskSnapshot.state == TaskState.success) {
          String url = await reference.getDownloadURL();

          FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

          await firebaseFirestore.collection("user").doc(userId).set({
            "email": email,
            "phone_no": phoneNo,
            "image": url,
          });

          await LocalStorage.sharedPreferences
              .setBool(LocalStorage.logIn, true);
          await LocalStorage.sharedPreferences
              .setString(LocalStorage.userId, userId);

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const BottomBarScreen()),
            (route) => false,
          );
        } else {
          toastMessage(msg: "File upload failed", context: context);
        }
      } else {
        toastMessage(msg: "File not found", context: context);
      }
    } catch (e) {
      toastMessage(msg: "An error occurred: $e", context: context);
      print('Error during signUp: $e');
      Navigator.of(context).pop();
    }
  }
}
