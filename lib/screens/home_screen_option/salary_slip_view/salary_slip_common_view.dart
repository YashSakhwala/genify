// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import "dart:io";
import "package:flutter/material.dart";
import "package:genify/screens/home_screen_option/salary_slip_view/salary_slip_make_function.dart";
import "package:image_picker/image_picker.dart";
import "../../../config/app_colors.dart";
import "../../../config/app_image.dart";
import "../../../config/app_style.dart";
import "../../../widgets/common_widgets/appbar.dart";
import "../../../widgets/common_widgets/button_view.dart";
import "../../../widgets/common_widgets/text_field_view.dart";
import "../../../widgets/common_widgets/toast_view.dart";

class SalarySlipCommonViewScreen extends StatefulWidget {
  const SalarySlipCommonViewScreen({super.key});

  @override
  State<SalarySlipCommonViewScreen> createState() =>
      _SalarySlipCommonViewScreenState();
}

class _SalarySlipCommonViewScreenState
    extends State<SalarySlipCommonViewScreen> {
  final TextEditingController companyName = TextEditingController();
  final TextEditingController employeeName = TextEditingController();
  final TextEditingController employeeID = TextEditingController();
  final TextEditingController department = TextEditingController();
  final TextEditingController designation = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController mealAllowance = TextEditingController();
  final TextEditingController transportationAllowance = TextEditingController();
  final TextEditingController medicalAllowance = TextEditingController();
  final TextEditingController retirementInsurance = TextEditingController();
  final TextEditingController tax = TextEditingController();

  final TextEditingController bankName = TextEditingController();
  final TextEditingController bankAccountNumber = TextEditingController();

  String paymentMethod = "Cash";

  @override
  void initState() {
    SalaryMake.signatureImagePath = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarView(
        title: "Salary Slip",
        style: AppTextStyle.largeTextStyle.copyWith(
          color: AppColors.whiteColor,
        ),
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        iconThemeData: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView(
          children: [
            TextFieldView(
              title: "Company Name",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: companyName,
              hintText: "MD Pharma",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Employee Name",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: employeeName,
              hintText: "Varun Mishra",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Employee ID",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: employeeID,
              keyboardType: TextInputType.number,
              hintText: "1234",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Employee Department",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: department,
              hintText: "General affairs",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Employee Designation",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: designation,
              hintText: "Manager",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Basic Salary",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: salary,
              keyboardType: TextInputType.phone,
              hintText: "2000.00",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Meal Allowance",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: mealAllowance,
              keyboardType: TextInputType.phone,
              hintText: "300.00",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Transportation Allowance",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: transportationAllowance,
              keyboardType: TextInputType.phone,
              hintText: "300.00",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Medical Allowance",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: medicalAllowance,
              keyboardType: TextInputType.phone,
              hintText: "300.00",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Retirement Insurance",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: retirementInsurance,
              keyboardType: TextInputType.phone,
              hintText: "25.00",
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldView(
              title: "Tax",
              titleStyle: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              controller: tax,
              keyboardType: TextInputType.phone,
              hintText: "25.00",
            ),
            SizedBox(
              height: 20,
            ),
            if (paymentMethod == "Bank Transfer") ...[
              SizedBox(
                height: 20,
              ),
              TextFieldView(
                title: "Bank Name",
                titleStyle: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                controller: bankName,
                hintText: "State bank of india",
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldView(
                title: "Bank Account Number",
                titleStyle: AppTextStyle.regularTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                controller: bankAccountNumber,
                keyboardType: TextInputType.number,
                hintText: "1234567890",
              ),
              SizedBox(
                height: 20,
              ),
            ],
            Text(
              "Select Payment Method",
              style: AppTextStyle.regularTextStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.greyColor,
                ),
              ),
              child: DropdownButton(
                value: paymentMethod,
                isExpanded: true,
                underline: SizedBox(),
                items: ["Cash", "Bank Transfer"].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    paymentMethod = newValue!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.greyColor.shade300,
                    image: DecorationImage(
                      image: SalaryMake.signatureImagePath.isEmpty
                          ? Image.asset(
                              AppImages.addImage,
                              color: AppColors.greyColor.shade300,
                              scale: 12,
                            ).image
                          : Image.file(
                              File(SalaryMake.signatureImagePath),
                            ).image,
                      fit: SalaryMake.signatureImagePath.isEmpty
                          ? BoxFit.scaleDown
                          : BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 17,
                ),
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add a signature",
                          style: AppTextStyle.regularTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Some companies require salary slip without signature, so check before adding one.",
                          style: AppTextStyle.regularTextStyle
                              .copyWith(fontSize: 9),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            ImagePicker imagePicker = ImagePicker();

                            XFile? xFile = await imagePicker.pickImage(
                                source: ImageSource.gallery);

                            if (xFile != null && xFile.path.isNotEmpty) {
                              SalaryMake.signatureImagePath = xFile.path;
                            }

                            setState(() {});
                          },
                          child: Container(
                            height: 43,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Upload signature",
                                style: AppTextStyle.regularTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            ButtonView(
              title: "Continue",
              onTap: () {
                if (mealAllowance.text.isEmpty ||
                    transportationAllowance.text.isEmpty ||
                    medicalAllowance.text.isEmpty ||
                    retirementInsurance.text.isEmpty ||
                    tax.text.isEmpty) {
                  mealAllowance.text = "0";
                  transportationAllowance.text = "0";
                  medicalAllowance.text = "0";
                  retirementInsurance.text = "0";
                  tax.text = "0";
                }

                if (companyName.text.isEmpty ||
                    employeeName.text.isEmpty ||
                    employeeID.text.isEmpty ||
                    department.text.isEmpty ||
                    designation.text.isEmpty ||
                    salary.text.isEmpty) {
                  toastView(
                    msg: "Please fill all details",
                    context: context,
                  );
                } else {
                  SalaryMake.generateSalarySlip(
                    companyName: companyName.text,
                    employeeName: employeeName.text,
                    employeeID: employeeID.text,
                    department: department.text,
                    designation: designation.text,
                    salary: salary.text,
                    mealAllowance: mealAllowance.text,
                    transportationAllowance: transportationAllowance.text,
                    medicalAllowance: medicalAllowance.text,
                    retirementInsurance: retirementInsurance.text,
                    tax: tax.text,
                    paymentMethod: paymentMethod,
                    bankName:
                        paymentMethod == "Bank Transfer" ? bankName.text : null,
                    bankAccountNumber: paymentMethod == "Bank Transfer"
                        ? bankAccountNumber.text
                        : null,
                    context: context,
                  );
                }

                // SalaryMake.generateSalarySlip(
                //   companyName: "MD Pharam",
                //   employeeName: "Yash Sakhwala",
                //   employeeID: "1366",
                //   department: "Developement",
                //   designation: "Senior Developer",
                //   salary: "50000",
                //   mealAllowance: "5700",
                //   transportationAllowance: "3000",
                //   medicalAllowance: "3970",
                //   retirementInsurance: "7000",
                //   tax: "482",
                //   paymentMethod: paymentMethod,
                //   bankName:
                //       paymentMethod == "Bank Transfer" ? bankName.text : null,
                //   bankAccountNumber: paymentMethod == "Bank Transfer"
                //       ? bankAccountNumber.text
                //       : null,
                //   context: context,
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
