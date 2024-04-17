// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/local_storage.dart';
import 'package:genify/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalStorage.sharedPreferences = await SharedPreferences.getInstance();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAq15bsAom32VqHMKJWRc7fVsJ07kWYByA",
            authDomain: "genify-app-d06b8.firebaseapp.com",
            projectId: "genify-app-d06b8",
            storageBucket: "genify-app-d06b8.appspot.com",
            messagingSenderId: "955025586687",
            appId: "1:955025586687:web:e1adc46853417090ce0fca",
            measurementId: "G-6C0BTDVPRE"));
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
