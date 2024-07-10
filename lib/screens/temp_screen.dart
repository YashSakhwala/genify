// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../config/app_colors.dart';
import '../config/app_style.dart';
import '../controller/transaction_controller.dart';
import '../widgets/common_widgets/appbar.dart';
import '../widgets/common_widgets/text_field_view.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  TransactionController transactionController =
      Get.put(TransactionController());

  final TextEditingController amount = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController subTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      appBar: AppBarView(
        title: "Incomes",
        style: AppTextStyle.regularTextStyle.copyWith(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.greenColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width,
              color: AppColors.greyColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 85, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How Much?",
                          style: AppTextStyle.regularTextStyle.copyWith(
                            color: AppColors.whiteColor.withOpacity(0.7),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "₹ ",
                              style: AppTextStyle.regularTextStyle.copyWith(
                                fontSize: 50,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            Expanded(
                              child: TextFieldView(
                                title: "",
                                controller: amount,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9\.]')),
                                ],
                                cursorHeight: 50,
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontSize: 50,
                                  color: AppColors.whiteColor,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "0",
                                  hintStyle:
                                      AppTextStyle.regularTextStyle.copyWith(
                                    fontSize: 50,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.redColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
