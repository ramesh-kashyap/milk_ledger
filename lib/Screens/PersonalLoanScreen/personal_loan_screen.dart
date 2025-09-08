import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PersonalLoanScreen/personal_loan_screen2.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PersonalLoanScreen extends StatelessWidget {
  PersonalLoanScreen({Key? key}) : super(key: key);

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
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 20),
                    child: Image.asset(Images.personalLoanScreenImage),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: CommonTextWidget.InterSemiBold(
                      text: "INSTANT",
                      fontSize: 26,
                      color: green92D,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: CommonTextWidget.InterSemiBold(
                      text: "PERSONAL LOAN",
                      fontSize: 26,
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: CommonTextWidget.InterMedium(
                      text: "Hassle-free instant loan for all your needs",
                      fontSize: 12,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF3E45E0),
                              Color(0xFF4F54BF).withOpacity(0.3),
                            ],
                          ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25),
                            CommonTextWidget.InterRegular(
                              text: "Get Instant loan upto",
                              fontSize: 10,
                              color: white,
                            ),
                            CommonTextWidget.InterBold(
                              text: "₹2.5 Lakh",
                              fontSize: 20,
                              color: white,
                            ),
                            SizedBox(height: 15),
                            CommonTextWidget.InterBold(
                              text: "FLEXIBLE LOAN\nTENURES",
                              fontSize: 20,
                              color: white,
                            ),
                            SizedBox(height: 15),
                            CommonTextWidget.InterBold(
                              text: "100% DIGITAL\nPROCESS",
                              fontSize: 20,
                              color: white,
                            ),
                            SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 120),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: black.withOpacity(0.15),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 18, left: 25, right: 25, bottom: 30),
                child: CommonButtonWidget.button(
                  text: "Check Your Loan Offer",
                  buttonColor: Colors.green,
                  onTap: () {
                    Get.to(() => PersonalLoanScreen2());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
