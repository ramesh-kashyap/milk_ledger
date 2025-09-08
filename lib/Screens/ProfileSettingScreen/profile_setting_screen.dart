import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HelpScreen/help_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileSettingScreen extends StatelessWidget {
  ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      appBar: AppBar(
        backgroundColor: whiteF9F,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
        title: Image.asset(Images.splashImage, height: 25, width: 90),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TopText Widget View
          TopTextWidgetView(),

          /// Center Widget View
          CenterWidgetView(),
        ],
      ),
    );
  }

  /// TopText Widget View
  Widget TopTextWidgetView() {
    return Padding(
      padding: EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 60),
      child: CommonTextWidget.InterBold(
        text: "Profile Settings",
        fontSize: 20,
        color: black171,
      ),
    );
  }

  /// Center Widget View
  Widget CenterWidgetView() {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(Images.profileSettingImage),
          SizedBox(height: 25),
          CommonTextWidget.InterMedium(
            text: "Let us Know the issue you are facing?",
            fontSize: 16,
            color: black171,
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 95),
            child: CommonButtonWidget.button(
              onTap: () {
                Get.to(() => HelpScreen());
              },
              buttonColor: Colors.green,
              text: "Chat with us",
            ),
          ),
        ],
      ),
    );
  }
}
