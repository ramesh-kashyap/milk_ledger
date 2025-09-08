import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFBF,
      appBar: AppBar(
        backgroundColor: whiteFBF,
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
          text: "Profile",
          fontSize: 18,
          color: black171,
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Center(
                  child:
                      Image.asset(Images.profileImage, height: 100, width: 100),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CommonTextWidget.InterMedium(
                    text: "Name",
                    fontSize: 14,
                    color: black171,
                  ),
                ),
                SizedBox(height: 10),
                CommonTextFieldWidget.TextFormField3(
                  controller: nameController,
                  hintText: "John Doe",
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CommonTextWidget.InterMedium(
                    text: "Email Address",
                    fontSize: 14,
                    color: black171,
                  ),
                ),
                SizedBox(height: 10),
                CommonTextFieldWidget.TextFormField3(
                  controller: emailController,
                  hintText: "Johndoe@gmail.com",
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: CommonTextWidget.InterMedium(
                      text: "Edit",
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CommonTextWidget.InterMedium(
                    text: "Phone No.",
                    fontSize: 14,
                    color: black171,
                  ),
                ),
                SizedBox(height: 10),
                CommonTextFieldWidget.TextFormField3(
                  controller: phoneController,
                  hintText: "12345 67890",
                  keyboardType: TextInputType.number,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: CommonTextWidget.InterMedium(
                      text: "Update",
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                CommonTextWidget.InterBold(
                  text: "Payment Accounts Status",
                  fontSize: 18,
                  color: black171,
                ),
                SizedBox(height: 20),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: -8,
                  leading: SvgPicture.asset(
                    Images.digiWallet,
                    color: Colors.green,
                  ),
                  title: CommonTextWidget.InterBold(
                    text: "DigiWallet",
                    fontSize: 14,
                    color: black171,
                  ),
                  subtitle: CommonTextWidget.InterRegular(
                    text: "₹1,00,0000 Monthly Limit",
                    fontSize: 12,
                    color: grey757,
                  ),
                  trailing: CommonTextWidget.InterMedium(
                    text: "Activate Now",
                    fontSize: 14,
                    color: Colors.green,
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
