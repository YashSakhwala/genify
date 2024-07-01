// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_image.dart';
import '../../../config/app_style.dart';
import 'otp_common_view.dart';

class WebOTPScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNo;
  final String password;
  final String verificationId; 

  const WebOTPScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.verificationId, 
  });

  @override
  State<WebOTPScreen> createState() => _WebOTPScreenState();
}

class _WebOTPScreenState extends State<WebOTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 60),
                  child: Text(
                    "Genify",
                    style: AppTextStyle.largeTextStyle.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 35,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset(AppImages.main).image,
                        alignment: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 90,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(17, 3, 17, 0),
                  child: OTPCommonView(
                    name: widget.name,
                    email: widget.email,
                    password: widget.password,
                    phoneNo: widget.phoneNo,
                    verificationId: widget.verificationId, 
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
