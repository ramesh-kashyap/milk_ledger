import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/SendSmsScreen/send_sms_failed_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomePaytmScreen extends StatelessWidget {
  WelcomePaytmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      appBar: AppBar(
        backgroundColor: whiteF9F,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child:SvgPicture.asset(Images.welcomePaytmImage),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget.InterBold(
                  color: black171,
                  fontSize: 20,
                  text: "Welcome to Paytm!",
                ),
                SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    text: "The number ",
                    style: TextStyle(
                      fontFamily: FontFamily.InterRegular,
                      fontSize: 13,
                      color: grey757,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "1234567890",
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: FontFamily.InterMedium,
                            color: black171),
                      ),
                      TextSpan(
                        text:
                            "s already registered with us, but the account has not been accessed in a while. Please select an option to proceed.",
                        style: TextStyle(
                          fontFamily: FontFamily.InterRegular,
                          fontSize: 13,
                          color: grey757,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: (){
                Get.bottomSheet(
                  SendSmsFailedScreen(),
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                );
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  child:SvgPicture.asset(Images.createNewUser),
                ),
                title: CommonTextWidget.InterSemiBold(
                  text: "Create a new account",
                  fontSize: 14,
                  color: black171,
                ),
                subtitle: CommonTextWidget.InterRegular(
                  text: "if the existing account is not yours, create "
                      "a new account and start enjoying Paytm "
                      "services",
                  fontSize: 12,
                  color: grey757,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: (){
                Get.bottomSheet(
                  SendSmsFailedScreen(),
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                );
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  child:SvgPicture.asset(Images.loginImage),
                ),
                title: CommonTextWidget.InterSemiBold(
                  text: "Login to existing account",
                  fontSize: 14,
                  color: black171,
                ),
                subtitle: CommonTextWidget.InterRegular(
                  text: "if the existing account is not yours, create "
                      "a new account and start enjoying Paytm "
                      "services",
                  fontSize: 12,
                  color: grey757,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: CommonTextWidget.InterSemiBold(
                text: "Why am I seeing this",
                fontSize: 14,
                color: Colors.green,
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
