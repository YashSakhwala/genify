// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genify/controller/local_storage.dart';
import 'package:genify/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalStorage.sharedPreferences = await SharedPreferences.getInstance();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDla461_FMUHzFIcMrH0e6Ckcfr08ucfdc",
            authDomain: "genify-61fe5.firebaseapp.com",
            projectId: "genify-61fe5",
            storageBucket: "genify-61fe5.appspot.com",
            messagingSenderId: "346582759932",
            appId: "1:346582759932:web:85b8fecf86b7d820f7da79",
            measurementId: "G-BE6JKSRMYL"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "popins-regular"),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
