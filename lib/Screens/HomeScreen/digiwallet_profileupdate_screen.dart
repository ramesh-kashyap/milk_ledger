import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DigiWalletProfileUpdateScreen extends StatelessWidget {
  DigiWalletProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: blueEFE,
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
          text: "DigiWallet | Profile Update",
          fontSize: 18,
          color: black171,
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.digiWalletBgImage),
            fit: BoxFit.fill,
          ),
        ),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 22),
                CommonTextWidget.InterBold(
                  text: "Your DigiWallet\nneeds attentions!",
                  fontSize: 22,
                  color: Colors.green,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65),
                  child: CommonTextWidget.InterMedium(
                    text: "Same details in your profile need to "
                        "be updated for you to continue "
                        "enjoying exclusive Wallet benefits "
                        "and rewards seamlessly.",
                    fontSize: 14,
                    color: black171,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Get.height >= 784 ? 160 : 40),
              SvgPicture.asset(Images.iPhone11Pro),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: CommonButtonWidget.button(
                    text: "Submit Now",
                    buttonColor: Colors.green,
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 18),
                CommonTextWidget.InterSemiBold(
                  text: "Already Submitted",
                  fontSize: 16,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
