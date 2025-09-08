import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ChatScreens/chat_screen1.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/EnterAndSearchMobileNumberScreen/search_contact_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EnterMobileNumberScreen extends StatelessWidget {
  EnterMobileNumberScreen({Key? key}) : super(key: key);

  final TextEditingController enterNumberController = TextEditingController();

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
        actions: [
        SvgPicture.asset(Images.information),
          SizedBox(width: 15),
          Padding(
            padding: EdgeInsets.only(right: 25),
            child:SvgPicture.asset(Images.setting),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CommonTextWidget.InterBold(
                  text: "Enter Mobile Number to Pay",
                  fontSize: 22,
                  color: black171,
                ),
                CommonTextWidget.InterRegular(
                  text: "Send Money Directly to Bank Account",
                  fontSize: 14,
                  color: black1E1,
                ),
                SizedBox(height: 15),
                CommonTextFieldWidget.TextFormField3(
                  controller: enterNumberController,
                  hintText: "Enter Mobile Number or Name",
                  keyboardType: TextInputType.number,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => SearchContactScreen());
                      },
                      child:SvgPicture.asset(Images.book),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                CommonTextWidget.InterBold(
                  text: "Contacts",
                  fontSize: 20,
                  color: grey757,
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.enterContactList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ChatScreen1());
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading:
                            Image.asset(Lists.enterContactList[index]["image"]),
                        title: CommonTextWidget.InterSemiBold(
                          text: Lists.enterContactList[index]["text1"],
                          fontSize: 16,
                          color: black171,
                        ),
                        subtitle: CommonTextWidget.InterRegular(
                          text: Lists.enterContactList[index]["text2"],
                          fontSize: 12,
                          color: grey757,
                        ),
                        trailing: index == 2 || index == 6
                            ? CommonTextWidget.InterMedium(
                                text: "Invite",
                                fontSize: 14,
                                color: Colors.green,
                              )
                            : SizedBox.shrink(),
                      ),
                    ),
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
