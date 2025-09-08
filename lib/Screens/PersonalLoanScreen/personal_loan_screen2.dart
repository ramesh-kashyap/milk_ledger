import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/personal_loan_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PersonalLoanScreen2 extends StatelessWidget {
  PersonalLoanScreen2({Key? key}) : super(key: key);

  final TextEditingController enterPanController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PersonalLoanController personalLoanController =
      Get.put(PersonalLoanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          SvgPicture.asset(Images.personalLoan),
            SizedBox(width: 10),
            CommonTextWidget.InterSemiBold(
              text: "Personal\nLoan",
              fontSize: 18,
              color: black171,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Image.asset(Images.personalLoanScreenImage1),
                SizedBox(height: 30),
                CommonTextWidget.InterMedium(
                  text: "Hey John, please confirm \nyour basic details",
                  fontSize: 22,
                  color: black171,
                ),
                SizedBox(height: 6),
                CommonTextWidget.InterRegular(
                  text:
                      "We have successfully fetched your details. Please confirm and proceed.",
                  fontSize: 14,
                  color: grey757,
                ),
                SizedBox(height: 30),
                CommonTextFieldWidget.TextFormField3(
                  controller: enterPanController,
                  hintText: "Enter PAN",
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                CommonTextFieldWidget.TextFormField3(
                  controller: dateController,
                  hintText: "Date of Birth (DD/MM/YYYY)",
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                CommonTextFieldWidget.TextFormField3(
                  controller: emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 12),
                CommonTextWidget.InterRegular(
                  text:
                      "We will send all loan related documents (welcome letter, "
                      "Tax Invoice, Repayment schedule) on this email address",
                  fontSize: 12,
                  color: grey757,
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => InkWell(
                        onTap: () {
                          personalLoanController.select.value =
                              !personalLoanController.select.value;
                        },
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: personalLoanController.select.isTrue
                                ? Colors.green
                                : white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: personalLoanController.select.isTrue
                                    ? Colors.green
                                    : greyDCD,
                                width: 1),
                          ),
                          child: Center(
                            child: Icon(Icons.check, color: white, size: 10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "I agree to ",
                          style: TextStyle(
                            fontFamily: FontFamily.InterRegular,
                            fontSize: 12,
                            color: black171,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Terms and Conditions & Privacy Policy. ",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: FontFamily.InterRegular,
                                  color: Colors.green),
                            ),
                            TextSpan(
                              text:
                                  "I authorize One97 to access my credit report from credit bureaus and store it to process my Personal Loan Application.",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: FontFamily.InterRegular,
                                  color: black171),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                CommonButtonWidget.button(
                  onTap: () {},
                  buttonColor: Colors.green,
                  text: "Proceed",
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
