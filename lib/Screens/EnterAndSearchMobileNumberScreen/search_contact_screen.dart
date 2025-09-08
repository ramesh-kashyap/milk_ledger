import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ChatScreens/chat_screen1.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchContactScreen extends StatelessWidget {
  SearchContactScreen({Key? key}) : super(key: key);

  final TextEditingController searchNumberController = TextEditingController();

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
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CommonTextWidget.InterBold(
                  text: "Search Contacts",
                  fontSize: 22,
                  color: black171,
                ),
                SizedBox(height: 18),
                CommonTextFieldWidget.TextFormField3(
                  controller: searchNumberController,
                  hintText: "Enter Mobile Number or Name",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                CommonTextWidget.InterSemiBold(
                  text: "A",
                  fontSize: 20,
                  color: black,
                ),
                SizedBox(height: 12),
                Divider(thickness: 1, color: greyDBD),
                SizedBox(height: 18),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.searchContactList1.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ChatScreen1());
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                            Lists.searchContactList1[index]["image"]),
                        title: CommonTextWidget.InterSemiBold(
                          text: Lists.searchContactList1[index]["text1"],
                          fontSize: 16,
                          color: black171,
                        ),
                        subtitle: CommonTextWidget.InterRegular(
                          text: Lists.searchContactList1[index]["text2"],
                          fontSize: 12,
                          color: grey757,
                        ),
                        trailing: index == 2
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
                SizedBox(height: 15),
                Divider(thickness: 1, color: greyDBD),
                SizedBox(height: 18),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.searchContactList2.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ChatScreen1());
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                            Lists.searchContactList2[index]["image"]),
                        title: CommonTextWidget.InterSemiBold(
                          text: Lists.searchContactList2[index]["text1"],
                          fontSize: 16,
                          color: black171,
                        ),
                        subtitle: CommonTextWidget.InterRegular(
                          text: Lists.searchContactList2[index]["text2"],
                          fontSize: 12,
                          color: grey757,
                        ),
                        trailing: index == 3
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
