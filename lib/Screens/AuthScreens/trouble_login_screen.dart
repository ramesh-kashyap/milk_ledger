import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ProfileSettingScreen/profile_setting_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TroubleLoginScreen extends StatelessWidget {
  TroubleLoginScreen({Key? key}) : super(key: key);

  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      body: Padding(
        padding: EdgeInsets.only(top: 60, bottom: 20, left: 22, right: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TopIcon Widget View
            TopIconWidgetView(),

            /// Text Widget View
            TextWidgetView(),

            /// TextField Widget View
            TextFieldWidgetView(),

            /// Button Widget View
            ButtonWidgetView(),
          ],
        ),
      ),
    );
  }

  /// TopIcon Widget View
  Widget TopIconWidgetView() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Icon(Icons.arrow_back, size: 20, color: black171),
    );
  }

  /// Text Widget View
  Widget TextWidgetView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        CommonTextWidget.InterBold(
          text: "Trouble logging in",
          fontSize: 20,
          color: black171,
        ),
        SizedBox(height: 12),
        CommonTextWidget.InterRegular(
          text:
              "To continue, please enter your mobile number registered on Paytm",
          fontSize: 12,
          color: grey757,
        ),
      ],
    );
  }

  /// TextField Widget View
  Widget TextFieldWidgetView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: CommonTextWidget.InterMedium(
            text: "Phone Number ",
            color: black171,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 10),
        CommonTextFieldWidget.TextFormField1(
          hintText: "1234567890",
          keyboardType: TextInputType.number,
          controller: phoneNumberController,
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 5),
            child: CommonTextWidget.InterSemiBold(
              text: "+91",
              color: black171,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }

  /// Button Widget View
  Widget ButtonWidgetView() {
    return CommonButtonWidget.button(
      text: "Proceed",
      buttonColor: Colors.green,
      onTap: () {
        Get.to(() => ProfileSettingScreen());
      },
    );
  }
}
