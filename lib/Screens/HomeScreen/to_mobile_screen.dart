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

class ToMobileScreen extends StatelessWidget {
  ToMobileScreen({Key? key}) : super(key: key);
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
        SvgPicture.asset(Images.information, color: Colors.green,),
          SizedBox(width: 15),
          Padding(
            padding: EdgeInsets.only(right: 25),
            child:SvgPicture.asset(Images.setting, color: Colors.green,),
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
                  text: "UPI Money Transfer",
                  fontSize: 22,
                  color: black171,
                ),
                CommonTextWidget.InterRegular(
                  text: "Make payments to DigiWallet, PhonePe or Gpay",
                  fontSize: 14,
                  color: black1E1,
                ),
                SizedBox(height: 15),
                CommonTextFieldWidget.TextFormField3(
                  controller: enterNumberController,
                  hintText: "Enter Name or Mobile Number",
                  keyboardType: TextInputType.number,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        // Get.to(() => SearchContactScreen());
                      },
                      child:SvgPicture.asset(Images.book, color: Colors.green,),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                CommonTextWidget.InterBold(
                  text: "Recent Payments",
                  fontSize: 20,
                  color: grey757,
                ),
                SizedBox(height: 22),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15,
                    childAspectRatio:
                        MediaQuery.of(context).size.aspectRatio * 2 / 1.7,
                  ),
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: Lists.recentPaymentList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.asset(
                          Lists.recentPaymentList[index]["image"],
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(height: 10),
                        CommonTextWidget.InterSemiBold(
                            color: black171,
                            text: Lists.recentPaymentList[index]["text"],
                            fontSize: 16,
                            textAlign: TextAlign.center),
                      ],
                    );
                  },
                ),
                CommonTextWidget.InterBold(
                  text: "Contacts",
                  fontSize: 20,
                  color: grey757,
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
                CommonTextWidget.InterSemiBold(
                  text: "B",
                  fontSize: 20,
                  color: black,
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
