// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'dart:io' as io;
import 'package:genify/screens/bottom_bar/bottom_bar_screen.dart';
import "package:universal_html/html.dart" as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:genify/widgets/common_widgets/indicatior.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import '../config/local_storage.dart';

class AuthController extends GetxController {
  final RxBool isLoginPasswordShow = true.obs;
  final RxBool isSignUpPasswordShow = true.obs;
  final RxBool isConfirmPasswordShow = true.obs;
  final RxString imagePath = "".obs;
  final Rx<html.File?> webImageFile = Rx<html.File?>(null);

  final RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

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
      await LocalStorage.sharedPreferences
          .setString(LocalStorage.userId, userCredential.user!.uid);

      await getProfile(context: context);
    } catch (e) {
      toastView(
        msg: "Email or password is incorrect",
        context: context,
      );

      Navigator.of(context).pop();
    }
  }

  Future<void> signUp({
    required String name,
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
      String url = "";

      if (kIsWeb) {
        final file = webImageFile.value;
        if (file != null) {
          final reader = html.FileReader();
          reader.readAsDataUrl(file);

          await reader.onLoad.first;
          final encoded = reader.result as String;
          final data = base64Decode(encoded.split(',').last);

          String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
          String ext = file.name.split('.').last;

          Reference reference = firebaseStorage.ref("$dateTime.$ext");

          UploadTask uploadTask = reference.putData(data);

          TaskSnapshot taskSnapshot = await uploadTask;
          if (taskSnapshot.state == TaskState.success) {
            url = await reference.getDownloadURL();
          } else {
            toastView(
              msg: "File upload failed",
              context: context,
            );
          }
        }
      } else {
        io.File file = io.File(imagePath.value);
        String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
        String ext = imagePath.value.split("/").last.split(".").last;

        Reference reference = firebaseStorage.ref("$dateTime.$ext");

        UploadTask uploadTask = reference.putFile(file);

        TaskSnapshot taskSnapshot = await uploadTask;
        if (taskSnapshot.state == TaskState.success) {
          url = await reference.getDownloadURL();
        } else {
          toastView(
            msg: "File upload failed",
            context: context,
          );
        }
      }

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore.collection("User").doc(userId).set({
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "image": url,
        "birthDate": "",
        "country": "India",
      });

      await LocalStorage.sharedPreferences.setBool(LocalStorage.logIn, true);
      await LocalStorage.sharedPreferences
          .setString(LocalStorage.userId, userId);

      getProfile(context: context);
    } catch (e) {
      toastView(
        msg: "An error occurred",
        context: context,
      );

      Navigator.of(context).pop();
    }
  }

  Future<void> getProfile({
    required BuildContext context,
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    var data = await firebaseFirestore.collection("User").doc(userId).get();

    userData.value = data.data() ?? {};

    Future.delayed(
      Duration(seconds: 4),
      () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomBarScreen(),
            ),
            (route) => false);
      },
    );
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phoneNo,
    required String birthDate,
    required String country,
    required BuildContext context,
  }) async {
    try {
      showIndicator(context);

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      String? userId =
          LocalStorage.sharedPreferences.getString(LocalStorage.userId);

      await firebaseFirestore.collection("User").doc(userId).update({
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "birthDate": birthDate,
        "country": country,
      });

      FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      String url = "";

      if (kIsWeb) {
        final file = webImageFile.value;
        if (file != null) {
          final reader = html.FileReader();
          reader.readAsDataUrl(file);

          await reader.onLoad.first;
          final encoded = reader.result as String;
          final data = base64Decode(encoded.split(',').last);

          String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
          String ext = file.name.split('.').last;

          Reference reference = firebaseStorage.ref("$dateTime.$ext");

          UploadTask uploadTask = reference.putData(data);

          TaskSnapshot taskSnapshot = await uploadTask;
          if (taskSnapshot.state == TaskState.success) {
            url = await reference.getDownloadURL();

            await firebaseFirestore.collection("User").doc(userId).update({
              "image": url,
            });

            userData["image"] = url;
          } else {
            toastView(
              msg: "File upload failed",
              context: context,
            );
          }
        }
      } else {
        io.File file = io.File(imagePath.value);
        String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
        String ext = imagePath.value.split("/").last.split(".").last;

        Reference reference = firebaseStorage.ref("$dateTime.$ext");

        UploadTask uploadTask = reference.putFile(file);

        TaskSnapshot taskSnapshot = await uploadTask;
        if (taskSnapshot.state == TaskState.success) {
          url = await reference.getDownloadURL();

          await firebaseFirestore.collection("User").doc(userId).update({
            "image": url,
          });

          userData["image"] = url;
        } else {
          toastView(
            msg: "File upload failed",
            context: context,
          );
        }
      }

      Map<String, dynamic> data = {
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "image": imagePath.value.isNotEmpty ? url : userData["image"],
        "birthDate": birthDate,
        "country": country,
      };

      userData.value = data;

      toastView(
        msg: "Profile updated successfully",
        context: context,
      );

      Navigator.of(context).pop();
    } catch (e) {
      toastView(
        msg: "Failed to upload image",
        context: context,
      );

      Navigator.of(context).pop();
    }
  }
}
