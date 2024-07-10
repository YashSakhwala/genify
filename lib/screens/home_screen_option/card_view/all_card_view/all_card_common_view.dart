// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_image.dart';
import '../../../../config/app_style.dart';
import '../../../../widgets/common_widgets/button_view.dart';
import '../../../bottom_bar/bottom_bar_screen.dart';
import '../card_make_function.dart';

class AllCardCommonScreen extends StatefulWidget {
  final String name;
  final String profession;
  final String email;
  final String phoneNo;
  final String address;
  final Color textColor;
  final Color backgroundColor;

  const AllCardCommonScreen({
    super.key,
    required this.name,
    required this.profession,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  State<AllCardCommonScreen> createState() => _AllCardCommonScreenState();
}

class _AllCardCommonScreenState extends State<AllCardCommonScreen> {
  List card = [
    {"image": AppImages.card1},
    {"image": AppImages.card2},
    {"image": AppImages.card3},
    {"image": AppImages.card4},
    {"image": AppImages.card5},
    {"image": AppImages.card6},
    {"image": AppImages.card7},
    {"image": AppImages.card8},
    {"image": AppImages.card9},
    {"image": AppImages.card10},
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ButtonView(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => BottomBarScreen(),
                          ),
                          (route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.whiteColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          "Home",
                          style: AppTextStyle.smallTextStyle.copyWith(
                            fontSize: 13,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                ),
                Expanded(
                  child: ButtonView(
                    onTap: () {
                      cardSelection(selectedIndex);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Download",
                          style: AppTextStyle.smallTextStyle.copyWith(
                            fontSize: 13,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.whiteColor,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  Text(
                    "--- Select any one card ---",
                    style: AppTextStyle.smallTextStyle
                        .copyWith(color: AppColors.greyColor),
                    textAlign: TextAlign.center,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: card.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: FlipInX(
                          child: Container(
                            height: 200,
                            width: 200,
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: selectedIndex == index
                                  ? Border.all(
                                      color: AppColors.primaryColor,
                                      width: 3,
                                    )
                                  : null,
                              image: DecorationImage(
                                image: Image.asset(
                                  card[index]["image"],
                                ).image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void cardSelection(int index) {
    if (index == 0) {
      CardMake.function1(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        context: context,
      );
    } else if (index == 1) {
      CardMake.function2(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        context: context,
      );
    } else if (index == 2) {
      CardMake.function3(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        context: context,
      );
    } else if (index == 3) {
      CardMake.function4(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        context: context,
      );
    } else if (index == 4) {
      CardMake.function5(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        context: context,
      );
    } else if (index == 5) {
      CardMake.function6(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        context: context,
      );
    } else if (index == 6) {
      CardMake.function7(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        context: context,
      );
    } else if (index == 7) {
      CardMake.function8(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        context: context,
      );
    } else if (index == 8) {
      CardMake.function9(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        context: context,
      );
    } else if (index == 9) {
      CardMake.function10(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        context: context,
      );
    }
  }
}
