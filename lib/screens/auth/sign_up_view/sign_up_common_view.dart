// ignore_for_file: prefer_const_constructors, prefer_function_declarations_over_variables, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps, unused_local_variable

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genify/config/app_colors.dart';
import 'package:genify/config/app_style.dart';
import 'package:genify/controller/auth_controller.dart';
import 'package:genify/screens/auth/login_screen.dart';
import 'package:genify/widgets/common_widgets/button_view.dart';
import 'package:genify/widgets/common_widgets/toast_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_image.dart';
import '../../../widgets/common_widgets/indicatior.dart';
import '../../../widgets/common_widgets/text_field_view.dart';
import "package:universal_html/html.dart" as html;
import '../otp_screen.dart';

class SignUpCommomView extends StatefulWidget {
  const SignUpCommomView({super.key});

  @override
  State<SignUpCommomView> createState() => _SignUpCommomViewState();
}

class _SignUpCommomViewState extends State<SignUpCommomView> {
  AuthController authController = Get.put(AuthController());

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String verificationId = "";

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    authController.imagePath.value = "";
    authController.webImageFile.value = null;

    authController.getID(context: context);

    bool emailMatch = authController.userID.contains(email.text);
    bool phoneMatch = authController.userID.contains(phoneNo.text);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Create an Account",
              style: AppTextStyle.largeTextStyle,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () async {
              if (kIsWeb) {
                html.FileUploadInputElement uploadInput =
                    html.FileUploadInputElement();
                uploadInput.accept = 'image/*';
                uploadInput.click();

                uploadInput.onChange.listen((event) {
                  final file = uploadInput.files!.first;
                  final reader = html.FileReader();

                  reader.readAsDataUrl(file);
                  reader.onLoadEnd.listen((event) {
                    authController.webImageFile.value = file;
                    authController.imagePath.value = reader.result as String;
                  });
                });
              } else {
                ImagePicker imagePicker = ImagePicker();

                XFile? xFile =
                    await imagePicker.pickImage(source: ImageSource.gallery);

                if (xFile != null && xFile.path.isNotEmpty) {
                  authController.imagePath.value = xFile.path;
                }
              }
            },
            child: Stack(
              children: [
                Obx(
                  () => Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.shade300,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: authController.imagePath.value.isEmpty
                            ? Image.asset(
                                AppImages.addImage,
                                color: AppColors.greyColor,
                                scale: 11,
                              ).image
                            : kIsWeb
                                ? Image.network(
                                    authController.imagePath.value,
                                  ).image
                                : Image.file(
                                    File(authController.imagePath.value),
                                  ).image,
                        fit: authController.imagePath.value.isEmpty
                            ? BoxFit.scaleDown
                            : BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 5,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldView(
            title: "Name",
            titleStyle: AppTextStyle.regularTextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            hintText: "Joseph Buttler",
            controller: name,
            needValidator: true,
            nameValidator: true,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldView(
            title: "Email",
            titleStyle: AppTextStyle.regularTextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            hintText: "example@gmail.com",
            controller: email,
            needValidator: true,
            emailValidator: true,
          ),
          SizedBox(
            height: 20,
          ),
          TextFieldView(
            title: "Phone Number",
            titleStyle: AppTextStyle.regularTextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            hintText: "1234567890",
            keyboardType: TextInputType.phone,
            controller: phoneNo,
            needValidator: true,
            phoneNoValidator: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(10),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => TextFieldView(
              title: "Password",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              hintText: "******",
              controller: password,
              obscureText: authController.isSignUpPasswordShow.value,
              needValidator: true,
              passwordValidator: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  authController.isSignUpPasswordShow.value =
                      !authController.isSignUpPasswordShow.value;
                },
                child: Image.asset(
                  authController.isSignUpPasswordShow.value
                      ? AppImages.openEye
                      : AppImages.closeEye,
                  color: AppColors.greyColor,
                  scale: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(
            () => TextFieldView(
              title: "Confirm Password",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              hintText: "******",
              controller: confirmPassword,
              obscureText: authController.isConfirmPasswordShow.value,
              needValidator: true,
              passwordValidator: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  authController.isConfirmPasswordShow.value =
                      !authController.isConfirmPasswordShow.value;
                },
                child: Image.asset(
                  authController.isConfirmPasswordShow.value == true
                      ? AppImages.openEye
                      : AppImages.closeEye,
                  color: AppColors.greyColor,
                  scale: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 55,
          ),
          ButtonView(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                if (password.text != confirmPassword.text) {
                  toastView(
                    msg: "Both passwords are not same",
                    context: context,
                  );
                } else if (authController.imagePath.value.isEmpty) {
                  toastView(
                    msg: "Please select profile image",
                    context: context,
                  );
                } else {
                  bool emailMatch = authController.userID.contains(email.text);
                  bool phoneMatch =
                      authController.userID.contains(phoneNo.text);

                  if (emailMatch) {
                    toastView(
                      msg: "Email already exists",
                      context: context,
                    );
                  } else if (phoneMatch) {
                    toastView(
                      msg: "Phone number already exists",
                      context: context,
                    );
                  } else {
                    showIndicator(context);
                    String phoneNumber = phoneNo.text.trim();
                    if (!phoneNumber.startsWith("+91")) {
                      phoneNumber = "+91" + phoneNumber;
                    }

                    final PhoneVerificationCompleted verificationCompleted =
                        (PhoneAuthCredential credential) async {
                      await firebaseAuth.signInWithCredential(credential);
                    };

                    final PhoneVerificationFailed verificationFailed =
                        (FirebaseAuthException authException) {};

                    final PhoneCodeSent codeSent = (String verificationId,
                        [int? forceResendingToken]) async {
                      toastView(
                        msg: "OTP is successfully sent to your mobile number",
                        context: context,
                      );

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(
                          name: name.text,
                          email: email.text,
                          password: password.text,
                          phoneNo: phoneNo.text,
                          verificationId: verificationId,
                        ),
                      ));
                    };

                    final PhoneCodeAutoRetrievalTimeout
                        codeAutoRetrievalTimeout = (String verificationId) {};

                    await firebaseAuth.verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      timeout: Duration(seconds: 120),
                      verificationCompleted: verificationCompleted,
                      verificationFailed: verificationFailed,
                      codeSent: codeSent,
                      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
                    );
                  }
                }
              }
            },
            title: "Sign Up",
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Do you have an account? ',
                  style: AppTextStyle.regularTextStyle.copyWith(fontSize: 14),
                ),
                TextSpan(
                    text: 'Log In',
                    style: AppTextStyle.regularTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
