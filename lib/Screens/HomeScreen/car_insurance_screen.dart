import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/TermsConditionsAndPrivacyPolicyScreens/terms_And_conditions_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarInsuranceScreen extends StatelessWidget {
  CarInsuranceScreen({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

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
        title: CommonTextWidget.InterSemiBold(
          text: "Car Insurance",
          fontSize: 18,
          color: black171,
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
                SizedBox(height: 25),
                Image.asset(Images.carInsuranceScreenImage),
                SizedBox(height: 25),
                CommonTextWidget.InterSemiBold(
                  text: "Enter Four wheeler number to get quote",
                  fontSize: 16,
                  color: black171,
                ),
                SizedBox(height: 10),
                CommonTextFieldWidget.TextFormField3(
                  controller: controller,
                  hintText: "e.g. DL99TLXXXX",
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "By proceeding you agree to ",
                      style: TextStyle(
                        fontFamily: FontFamily.InterRegular,
                        fontSize: 12,
                        color: black171,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => Get.to(() => TermsAndConditionsScreen()),
                          text: "Terms & Conditions",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: FontFamily.InterRegular,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                CommonButtonWidget.button(
                  onTap: () {},
                  buttonColor: Colors.green,
                  text: "Get Quote",
                ),
                SizedBox(height: 10),
                Center(
                  child: CommonTextWidget.InterMedium(
                    text: "Proceed without four wheeler number ",
                    fontSize: 12,
                    color: Colors.green,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
