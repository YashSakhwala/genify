// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, await_only_futures, non_constant_identifier_names

import "dart:convert";
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

  RxList combinedList = [].obs;

  RxList dataEntries = [].obs;
  RxList expensesEntries = [].obs;
  RxList incomeEntries = [].obs;

  RxList todayTransactions = [].obs;
  RxList todayExpensesList = [].obs;
  RxList todayIncomeList = [].obs;

  RxList<double> amountsList = <double>[].obs;
  RxList<double> incomeAmountsList = <double>[].obs;
  RxList<double> expensesAmountsList = <double>[].obs;

  RxInt totalAmount = 0.obs;
  RxInt totalExpenses = 0.obs;
  RxInt totalIncome = 0.obs;

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
    String realTime = DateFormat("hh:mm:ss a").format(now);

    String dateTimeString = now.toString();
    String uniqueTime = RegExp(r"\d+$").stringMatch(dateTimeString) ?? "";

    String url = "";

    if (kIsWeb) {
      final file = webImageFile.value;
      if (file != null) {
        final reader = html.FileReader();
        reader.readAsDataUrl(file);

        await reader.onLoad.first;
        final encoded = reader.result as String;
        final data = base64Decode(encoded.split(",").last);

        String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
        String ext = file.name.split(".").last;

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
      "uniqueTime": uniqueTime,
      "type": type,
    };

    var data = await firebaseFirestore.collection("Transactions").doc(userId);

    DocumentSnapshot docSnapshot = await data.get();

    if (docSnapshot.exists) {
      Map temp = docSnapshot.data() as Map<String, dynamic>;

      if (type == "Expenses") {
        List expenses = temp["Expenses"] ?? [];

        expenses.add(newTransaction);
        await data.update({"Expenses": expenses});
      } else if (type == "Income") {
        List income = temp["Income"] ?? [];

        income.add(newTransaction);
        await data.update({"Income": income});
      }
    } else {
      if (type == "Expenses") {
        await data.set({
          "Expenses": [newTransaction],
        });
      } else if (type == "Income") {
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
    isLoader.value = true;

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    var data =
        await firebaseFirestore.collection("Transactions").doc(userId).get();

    Map transactionData = data.data() ?? {};

    List expensesList = [];
    List incomeList = [];

    expensesList = transactionData["Expenses"] ?? [];
    incomeList = transactionData["Income"] ?? [];

    // Sorting by time
    DateTime now = DateTime.now();
    String todayDate = "${now.day}-${now.month}-${now.year}";

    DateTime parseDateTime(String dateString, String timeString) {
      String dateTimeString = "$dateString $timeString";
      DateFormat dateFormat = DateFormat("d-M-yyyy hh:mm:ss a");
      return dateFormat.parse(dateTimeString);
    }

    // All transactions sorting
    combinedList.clear();
    combinedList.value = [...expensesList, ...incomeList];

    combinedList.sort((a, b) {
      DateTime dateTimeA = parseDateTime(a["date"], a["time"]);
      DateTime dateTimeB = parseDateTime(b["date"], b["time"]);
      return dateTimeB.compareTo(dateTimeA);
    });

    dataEntries.clear();
    Map dateWiseData = {};

    for (var i in combinedList) {
      String date = i["date"];
      if (!dateWiseData.containsKey(date)) {
        dateWiseData[date] = [];
      }
      dateWiseData[date]!.add(i);
    }

    dataEntries.value = dateWiseData.entries.toList();

    // Expenses transactions sorting
    expensesList.sort((a, b) {
      DateTime dateTimeA = parseDateTime(a["date"], a["time"]);
      DateTime dateTimeB = parseDateTime(b["date"], b["time"]);
      return dateTimeB.compareTo(dateTimeA);
    });

    expensesEntries.clear();
    Map expensesDateWiseData = {};

    for (var i in expensesList) {
      String date = i["date"];
      if (!expensesDateWiseData.containsKey(date)) {
        expensesDateWiseData[date] = [];
      }
      expensesDateWiseData[date]!.add(i);
    }

    expensesEntries.value = expensesDateWiseData.entries.toList();

    // Income transactions sorting
    incomeList.sort((a, b) {
      DateTime dateTimeA = parseDateTime(a["date"], a["time"]);
      DateTime dateTimeB = parseDateTime(b["date"], b["time"]);
      return dateTimeB.compareTo(dateTimeA);
    });

    incomeEntries.clear();
    Map incomeDateWiseData = {};

    for (var i in incomeList) {
      String date = i["date"];
      if (!incomeDateWiseData.containsKey(date)) {
        incomeDateWiseData[date] = [];
      }
      incomeDateWiseData[date]!.add(i);
    }

    incomeEntries.value = incomeDateWiseData.entries.toList();

    // Today transactions
    todayTransactions.clear();
    todayIncomeList.clear();
    todayExpensesList.clear();

    for (var transaction in combinedList) {
      if (transaction["date"] == todayDate) {
        todayTransactions.add(transaction);

        if (transaction["type"] == "Expenses") {
          todayExpensesList.add(transaction);
        } else if (transaction["type"] == "Income") {
          todayIncomeList.add(transaction);
        }
      }
    }

    // All amount sorting
    amountsList.clear();
    incomeAmountsList.clear();
    expensesAmountsList.clear();

    amountsList.addAll(todayTransactions.map((transaction) {
      double amount = double.parse(transaction["amount"]);

      if (transaction["type"] == "Expenses") {
        expensesAmountsList.add(-amount);
        return -amount;
      } else if (transaction["type"] == "Income") {
        incomeAmountsList.add(amount);
        return amount;
      } else {
        return 0.0;
      }
    }).toList());

    amountsList.value = amountsList.reversed.toList();
    incomeAmountsList.value = incomeAmountsList.reversed.toList();
    expensesAmountsList.value = expensesAmountsList.reversed.toList();

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

    isLoader.value = false;
  }

  Future<void> updateTransactionData({
    required String amount,
    required String title,
    required String subTitle,
    required String payment,
    required String uniqueTime,
    required String image,
    required BuildContext context,
  }) async {
    showIndicator(context);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    DocumentReference docRef =
        await firebaseFirestore.collection("Transactions").doc(userId);

    DocumentSnapshot docSnapshot = await docRef.get();
    Map data = docSnapshot.data() as Map<String, dynamic>;

    List expenses = data["Expenses"];
    List income = data["Income"];

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    String url = "";

    if (imagePath.value.isNotEmpty) {
      if (kIsWeb) {
        final file = webImageFile.value;
        if (file != null) {
          final reader = html.FileReader();
          reader.readAsDataUrl(file);

          await reader.onLoad.first;
          final encoded = reader.result as String;
          final data = base64Decode(encoded.split(",").last);

          String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
          String ext = file.name.split(".").last;

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
    }

    for (var i = 0; i < expenses.length; i++) {
      if (expenses[i]["uniqueTime"] == uniqueTime) {
        expenses[i] = {
          ...expenses[i] as Map<String, dynamic>,
          "amount": amount,
          "image": imagePath.value.isNotEmpty ? url : image,
          "title": title,
          "subTitle": subTitle,
          "payment": payment,
        };
        break;
      }
    }

    for (var i = 0; i < income.length; i++) {
      if (income[i]["uniqueTime"] == uniqueTime) {
        income[i] = {
          ...income[i] as Map<String, dynamic>,
          "amount": amount,
          "image": imagePath.value.isNotEmpty ? url : image,
          "title": title,
          "subTitle": subTitle,
          "payment": payment,
        };
        break;
      }
    }

    await docRef.update({
      "Expenses": expenses,
      "Income": income,
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BottomBarScreen(),
        ),
        (route) => false);
  }

  Future<void> removeTransactionData({
    required String uniqueTime,
    required BuildContext context,
  }) async {
    showIndicator(context);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String? userId =
        LocalStorage.sharedPreferences.getString(LocalStorage.userId);

    DocumentReference docRef =
        await firebaseFirestore.collection("Transactions").doc(userId);

    DocumentSnapshot docSnapshot = await docRef.get();
    Map data = docSnapshot.data() as Map<String, dynamic>;

    List expenses = data["Expenses"];
    List income = data["Income"];

    expenses.removeWhere((expense) => expense["uniqueTime"] == uniqueTime);

    income.removeWhere((income) => income["uniqueTime"] == uniqueTime);

    await docRef.update({
      "Expenses": expenses,
      "Income": income,
    });

    // BottomBarController bottomBarController = Get.put(BottomBarController());

    // bottomBarController.index.value = 0;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BottomBarScreen(),
        ),
        (route) => false);
  }
}
