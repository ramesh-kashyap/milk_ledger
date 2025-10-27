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
import 'package:get_storage/get_storage.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
 

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedLang = "English"; // default languages
  final box = GetStorage();
   @override
   void initState() {
    super.initState();

    // 👇 check what is the current active locale
    final currentLocale = Get.locale;

    if (currentLocale?.languageCode == 'hi') {
      selectedLang = "Hindi";
    } else if (currentLocale?.languageCode == 'pa') {
      selectedLang = "Punjabi";
    } else {
      selectedLang = "English";
    }
  }
     void _showLanguageDialog() {
    Get.defaultDialog(
      title: "Select Language",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      content: Column(
        children: [
          RadioListTile<String>(
            value: "English",
            groupValue: selectedLang,
            onChanged: (val) {
              setState(() => selectedLang = val!);
              Get.updateLocale(const Locale('en', 'US')); // ✅ change locale
              box.write('language', 'en_US'); 
              Get.back();
            },
            title: const Text("English"),
          ),
          RadioListTile<String>(
            value: "Hindi",
            groupValue: selectedLang,
            onChanged: (val) {
              setState(() => selectedLang = val!);
              Get.updateLocale(const Locale('hi', 'IN')); // ✅ change locale
              box.write('language', 'hi_IN');
              print("✅ Locale changed to: ${Get.locale}");
              Get.back();
            },
            title: const Text("हिंदी"),
          ),
          RadioListTile<String>(
            value: "Punjabi",
            groupValue: selectedLang,
            onChanged: (val) {
              setState(() => selectedLang = val!);
              Get.updateLocale(const Locale('pa', 'IN')); // ✅ change locale
              box.write('language', 'pa_IN');
              Get.back();
            },
            title: const Text("ਪੰਜਾਬੀ"),
          ),

        ],
      ),
      radius: 12,
    );
  }

  Future<void> loginUser() async {
  final phone = phoneNumberController.text.trim();
  final password = passwordController.text.trim();

  // ✅ Use proper pattern: +countrycode (7–15 digits) OR 10 digits starting with 6–9
  final phoneRegex = RegExp(r'^(\+?[1-9]\d{0,3}\d{7,12}|[6-9]\d{9})$');

  print("Attempting login with phone: $phone, isValid: ${phoneRegex.hasMatch(phone)}");

  // ✅ Validate phone first
  if (phone.isEmpty) {
    Get.snackbar("Error", "Please enter your phone number");
    return;
  } else if (!phoneRegex.hasMatch(phone)) {
    Get.snackbar("Error", "Please enter a valid 10-digit phone number");
    return;
  }



  try {
    final response = await ApiService.post('/login', {
      "username": phone,
      "password": password,
    });

    final data = response.data;
    if (data['status'] == true && data['token'] != null) {
      await ApiService.saveToken(data['token']);
      Get.offAll(() => HomeScreen());
    } else {
      Get.snackbar("Login Failed", data['message'] ?? "Something went wrong");
    }
  } catch (e) {
    Get.snackbar("Error", "Something went wrong");
    print("Login Error: $e");
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
              text: "login_account".tr,
              color: black171,
              fontSize: 20,
            ),
            SvgPicture.asset(Images.user),
          ],
        ),
        InkWell(
          onTap: _showLanguageDialog, 
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
          text: "app_description".tr,
          fontSize: 12,
          color: grey757,
        ),
        SizedBox(height: 50),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: CommonTextWidget.InterMedium(
            text: "phone_number".tr,
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
            Get.to(() =>());
          },
          child: Center(
            child: CommonTextWidget.InterRegular(
              text: "need_help".tr,
              color: grey757,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(height: 15),
        CommonButtonWidget.button(
          text: "proceed_securely".tr,
          buttonColor: Colors.green,
          onTap: () {
            final phone = phoneNumberController.text.trim();
              final phoneRegex = RegExp(r'^(?:\+91)?[6-9]\d{9}$');;
            if (phone.isEmpty) {
    Get.snackbar("Error", "Please enter your phone number");
    return;
  } else if (!phoneRegex.hasMatch(phone)) {
    Get.snackbar("Error", "Please enter a valid phone number");
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
        // Center(
        //   child: InkWell(
        //     onTap: () {
        //       Get.to(() => HomeScreen());
        //     },
        //     child: CommonTextWidget.InterBold(
        //       text: "SKIP",
        //       color: Colors.green,
        //       fontSize: 16,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  /// BottomText Widget View
 Widget BottomTextWidgetView() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: 'agreement_text_1'.tr,
      style: TextStyle(
        fontFamily: FontFamily.InterRegular,
        fontSize: 10,
        color: grey757,
      ),
      children: <TextSpan>[
        TextSpan(
          text: 'terms_conditions'.tr,
          recognizer: TapGestureRecognizer()
            ..onTap = () => Get.to(() => TermsAndConditionsScreen()),
          style: TextStyle(
              fontSize: 10,
              fontFamily: FontFamily.InterRegular,
              color: Colors.green),
        ),
        TextSpan(
          text: 'and_text'.tr,
          style: TextStyle(
              fontSize: 10,
              fontFamily: FontFamily.InterRegular,
              color: grey757),
        ),
        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () => Get.to(() => PrivacyPolicyScreen()),
          text: 'privacy_policy'.tr,
          style: TextStyle(
              fontSize: 10,
              fontFamily: FontFamily.InterRegular,
              color: Colors.green),
        ),
        TextSpan(
          text: 'agreement_text_2'.tr,
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
