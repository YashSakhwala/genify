// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_style.dart';
import '../../../../widgets/common_widgets/appbar.dart';
import '../../../../widgets/common_widgets/text_field_view.dart';

class DiscountCalculationScreen extends StatefulWidget {
  const DiscountCalculationScreen({super.key});

  @override
  State<DiscountCalculationScreen> createState() =>
      _DiscountCalculationScreenState();
}

class _DiscountCalculationScreenState extends State<DiscountCalculationScreen> {
  final TextEditingController originalPriceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController finalPriceController = TextEditingController();
  final TextEditingController savingsController = TextEditingController();

  void calculateDiscount() {
    double originalPrice = double.tryParse(originalPriceController.text) ?? 0.0;
    double discount = double.tryParse(discountController.text) ?? 0.0;

    double discountAmount = originalPrice * discount / 100;
    double finalPrice = originalPrice - discountAmount;

    setState(() {
      finalPriceController.text = finalPrice.toStringAsFixed(2);
      savingsController.text = discountAmount.toStringAsFixed(2);
    });
  }

  Widget discountUnitInputField(
      String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
          ),
        ),
        Expanded(
          child: Container(
            child: TextFieldView(
              title: "",
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter value",
                hintStyle: AppTextStyle.regularTextStyle
                    .copyWith(color: AppColors.greyColor),
              ),
              textAlign: TextAlign.end,
              style: AppTextStyle.regularTextStyle.copyWith(fontSize: 19),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    originalPriceController.addListener(calculateDiscount);
    discountController.addListener(calculateDiscount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: "Discount",
        style: AppTextStyle.regularTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width >= 900 ? false : true,
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
      ),
      body: FlipInX(
        child: Center(
          child: Container(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  discountUnitInputField(
                      "Original Price", originalPriceController),
                  SizedBox(
                    height: 20,
                  ),
                  discountUnitInputField("Discount (% off)", discountController),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Final Price",
                        style:
                            AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
                      ),
                      Text(
                        finalPriceController.text,
                        style: AppTextStyle.regularTextStyle.copyWith(
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "You save ${savingsController.text}",
                    style: AppTextStyle.regularTextStyle.copyWith(
                      color: AppColors.greyColor,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
