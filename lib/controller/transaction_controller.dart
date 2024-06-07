// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, await_only_futures, non_constant_identifier_names

import "dart:convert";
import "dart:developer";
import "dart:io" as io;
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:genify/screens/bottom_bar/bottom_bar_screen.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "../config/local_storage.dart";
import "../widgets/common_widgets/indicatior.dart";
import "../widgets/common_widgets/toast_view.dart";
import "package:universal_html/html.dart" as html;

class TransactionController extends GetxController {
  RxBool isLoader = false.obs;

  RxString imagePath = "".obs;
  final Rx<html.File?> webImageFile = Rx<html.File?>(null);

  RxList expensesList = [].obs;
  RxList incomeList = [].obs;

  RxInt totalAmount = 0.obs;
  RxInt totalExpenses = 0.obs;
  RxInt totalIncome = 0.obs;

  RxList combinedList = [].obs;
  RxList<double> amountsList = <double>[].obs;

  Future<void> AllTransaction({
    required String amount,
    required String title,
    required String subTitle,
    required String payment,
    required BuildContext context,
    required String type,
  }) async {
    showIndicator(context);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    DateTime now = DateTime.now();
    String realDate = "${now.day}-${now.month}-${now.year}";
    String realTime = DateFormat("hh:mm a").format(now);

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

    Map newTransaction = {
      "amount": amount,
      "image": url,
      "title": title,
      "subTitle": subTitle,
      "payment": payment,
      "date": realDate,
      "time": realTime,
      "type": type,
    };

    var data = await firebaseFirestore.collection("Transactions").doc(userId);

    DocumentSnapshot docSnapshot = await data.get();

    if (docSnapshot.exists) {
      Map temp = docSnapshot.data() as Map<String, dynamic>;

      if (type == "expenses") {
        List expenses = temp["Expenses"] ?? [];

        expenses.add(newTransaction);
        await data.update({"Expenses": expenses});
      } else if (type == "income") {
        List income = temp["Income"] ?? [];

        income.add(newTransaction);
        await data.update({"Income": income});
      }
    } else {
      if (type == "expenses") {
        await data.set({
          "Expenses": [newTransaction],
        });
      } else if (type == "income") {
        await data.set({
          "Income": [newTransaction],
        });
      }
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => BottomBarScreen()),
      (route) => false,
    );
  }

  Future<void> getTransactionData() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    var data =
        await firebaseFirestore.collection("Transactions").doc(userId).get();

    Map transactionData = data.data() ?? {};

    expensesList.value = transactionData["Expenses"] ?? [];
    incomeList.value = transactionData["Income"] ?? [];

    expensesList.value = expensesList.reversed.toList();
    incomeList.value = incomeList.reversed.toList();

    // Transaction sorting
    combinedList.clear();

    combinedList.value = [...expensesList, ...incomeList];

    DateTime parseTime(String timeString) {
      String cleanedTimeString =
          timeString.replaceAll(RegExp(r"[^\x00-\x7F]"), "");
      String timePattern = "hh:mm a";
      DateFormat dateFormat = DateFormat(timePattern);
      return dateFormat.parse(cleanedTimeString);
    }

    combinedList.sort((a, b) {
      DateTime timeA = parseTime(a["time"]);
      DateTime timeB = parseTime(b["time"]);
      return timeB.compareTo(timeA);
    });

    // Amount sorting
    amountsList.clear();

    amountsList.addAll(combinedList.map((transaction) {
      double amount = double.parse(transaction["amount"]);

      return transaction["type"] == "expenses"
          ? -amount
          : transaction["type"] == "income"
              ? amount
              : 0.0;
    }).toList());

    amountsList.value = amountsList.reversed.toList();

    log(amountsList.toString());

    // Transaction calculation
    totalAmount.value = 0;
    totalExpenses.value = 0;
    totalIncome.value = 0;

    for (var expense in expensesList) {
      totalExpenses.value += int.parse(expense["amount"]);
    }
    totalAmount.value -= totalExpenses.value;

    for (var income in incomeList) {
      totalIncome.value += int.parse(income["amount"]);
    }
    totalAmount.value += totalIncome.value;
  }
}
