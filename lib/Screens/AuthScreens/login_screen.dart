import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/home_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PermissionScreen/permission_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/AuthScreens/trouble_login_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ChooseLanguageScreen/choose_language_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/TermsConditionsAndPrivacyPolicyScreens/privacy_policy_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/TermsConditionsAndPrivacyPolicyScreens/terms_And_conditions_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> loginUser() async {
    if (phoneNumberController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please enter phone number and password");
      return;
    }

    // setState(() {
    //   isLoading = true;
    //   buttonText = "Processing...";
    // });

    try {
      print("Phone number: ${phoneNumberController.text}");

      final response = await ApiService.post('/login', {
        "username": phoneNumberController.text.trim(),
        "password": passwordController.text.trim(),
      });

      final data = response.data;

      if (data['status'] == true && data['token'] != null) {
        print("Phone nu78");
        await ApiService.saveToken(data['token']); // Save the token securely
        Get.offAll(() => HomeScreen()); // Go to HomeScreen
      } else {
        print("Phone num4678");
        Get.snackbar("Login Failed", data['message'] ?? "Something went wrong");
      }
    } catch (e) {
      // setState(() {
      //   buttonText = "Proceed Securely";
      // });
      Get.snackbar("Error", "Something went wrong");
      print("Login Error: $e");
    } finally {
      // setState(() {
      //   isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("@@@${Get.height}");
    return Scaffold(
      backgroundColor: whiteF9F,
      body: Padding(
        padding: EdgeInsets.only(top: 60, bottom: 20, left: 22, right: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Widget View
            TopWidgetView(),

            /// TextField Widget View
            TextFieldWidgetView(),
            Spacer(),

            /// BottomText Widget View
            BottomTextWidgetView(),
          ],
        ),
      ),
    );
  }

  /// Top Widget View
  Widget TopWidgetView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CommonTextWidget.InterBold(
              text: "Login Account ",
              color: black171,
              fontSize: 20,
            ),
            SvgPicture.asset(Images.user),
          ],
        ),
        InkWell(
          onTap: () {
            Get.to(() => ChooseLanguageScreen());
          },
          child: Image.asset(Images.indiaFlagImage, height: 32, width: 42),
        ),
      ],
    );
  }

  /// TextField Widget View
  Widget TextFieldWidgetView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonTextWidget.InterRegular(
          text: "Pay using UPI, Wallet, Bank Accounts and Cards",
          fontSize: 12,
          color: grey757,
        ),
        SizedBox(height: 50),
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
        InkWell(
          onTap: () {
            Get.to(() => TroubleLoginScreen());
          },
          child: Center(
            child: CommonTextWidget.InterRegular(
              text: "Need Help?",
              color: grey757,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(height: 15),
        CommonButtonWidget.button(
          text: "Proceed Securely",
          buttonColor: Colors.green,
          onTap: () {
            final phone = phoneNumberController.text.trim();
            if (phone.isEmpty) {
              Get.snackbar('Required', 'Please enter your mobile number');
              return;
            }
            Get.bottomSheet(
              PermissionScreen(phone: phone),
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
            );
          },
        ),
        SizedBox(height: 15),
        Center(
          child: InkWell(
            onTap: () {
              Get.to(() => HomeScreen());
            },
            child: CommonTextWidget.InterBold(
              text: "SKIP",
              color: Colors.green,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  /// BottomText Widget View
  Widget BottomTextWidgetView() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "By proceeding, you agree to our ",
        style: TextStyle(
          fontFamily: FontFamily.InterRegular,
          fontSize: 10,
          color: grey757,
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Terms & conditions ",
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(() => TermsAndConditionsScreen()),
            style: TextStyle(
                fontSize: 10,
                fontFamily: FontFamily.InterRegular,
                color: Colors.green),
          ),
          TextSpan(
            text: "& ",
            style: TextStyle(
                fontSize: 10,
                fontFamily: FontFamily.InterRegular,
                color: grey757),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(() => PrivacyPolicyScreen()),
            text: "Privacy Policy. ",
            style: TextStyle(
                fontSize: 10,
                fontFamily: FontFamily.InterRegular,
                color: Colors.green),
          ),
          TextSpan(
            text:
                "If you provide permission to access your contact list, DigiWallet shall sync your contacts with its servers. SMS may be sent from your mobile number for verification purposes. standard operator charges may apply for SMS.",
            style: TextStyle(
                fontSize: 10,
                fontFamily: FontFamily.InterRegular,
                color: grey757),
          ),
        ],
      ),
    );
  }
}
