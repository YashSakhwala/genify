// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:genify/screens/home_screen_option/banner_view/banner_make_function.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_image.dart';
import '../../../../config/app_style.dart';
import '../../../../widgets/common_widgets/button_view.dart';
import '../../../bottom_bar/bottom_bar_screen.dart';

class WebAllBannerScreen extends StatefulWidget {
  final String name;
  final String profession;
  final String email;
  final String phoneNo;
  final String address;
  final Color textColor;

  const WebAllBannerScreen({
    super.key,
    required this.name,
    required this.profession,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.textColor,
  });

  @override
  State<WebAllBannerScreen> createState() => _WebAllBannerScreenState();
}

class _WebAllBannerScreenState extends State<WebAllBannerScreen> {
  List banner = [
    {"image": AppImages.banner1},
    {"image": AppImages.banner2},
    {"image": AppImages.banner3},
    {"image": AppImages.banner4},
    {"image": AppImages.banner5},
    {"image": AppImages.banner6},
    {"image": AppImages.banner7},
    {"image": AppImages.banner8},
    {"image": AppImages.banner9},
    {"image": AppImages.banner10},
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
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
                  width: 750,
                ),
                Expanded(
                  child: ButtonView(
                    onTap: () {
                      bannerSelection(selectedIndex);
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
              height: 40,
            ),
            Expanded(
              child: ListView(
                children: [
                  Text(
                    "--- Select any one banner ---",
                    style: AppTextStyle.smallTextStyle
                        .copyWith(color: AppColors.greyColor),
                    textAlign: TextAlign.center,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 270,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: banner.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: selectedIndex == index
                                ? Border.all(
                                    color: AppColors.primaryColor,
                                    width: 3,
                                  )
                                : null,
                            image: DecorationImage(
                              image: Image.asset(
                                banner[index]["image"],
                              ).image,
                              fit: BoxFit.fill,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blackColor.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
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

  void bannerSelection(int index) {
    if (index == 0) {
      BannerMake.function1(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        context: context,
      );
    } else if (index == 1) {
      BannerMake.function2(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        context: context,
      );
    } else if (index == 2) {
      BannerMake.function3(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        context: context,
      );
    } else if (index == 3) {
      BannerMake.function4(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        context: context,
      );
    } else if (index == 4) {
      BannerMake.function5(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        context: context,
      );
    } else if (index == 5) {
      BannerMake.function6(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        context: context,
      );
    } else if (index == 6) {
      BannerMake.function7(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        context: context,
      );
    } else if (index == 7) {
      BannerMake.function8(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        context: context,
      );
    } else if (index == 8) {
      BannerMake.function9(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        context: context,
      );
    } else if (index == 9) {
      BannerMake.function10(
        name: widget.name,
        profession: widget.profession,
        email: widget.email,
        phoneNo: widget.phoneNo,
        address: widget.address,
        textColor: widget.textColor,
        context: context,
      );
    }
  }
}
