import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ChatScreens/chat_screen1.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EnterUpiIdScreen extends StatelessWidget {
  EnterUpiIdScreen({Key? key}) : super(key: key);
  final TextEditingController enterUpiIdController = TextEditingController();

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
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CommonTextWidget.InterBold(
              text: "Enter UPI ID",
              fontSize: 22,
              color: black171,
            ),
            SizedBox(height: 15),
            CommonTextFieldWidget.TextFormField3(
              controller: enterUpiIdController,
              hintText: "Enter UPI ID",
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 18),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: Lists.enterUpiIdRecentList.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () {
                    Get.to(() => ChatScreen1());
                  },
                  child: Row(
                    children: [
                      Image.asset(
                          Lists.enterUpiIdRecentList[index]["image"],
                          height: 45,
                          width: 45),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextWidget.InterSemiBold(
                            text: Lists.enterUpiIdRecentList[index]
                            ["text1"],
                            fontSize: 16,
                            color: black171,
                          ),
                          CommonTextWidget.InterMedium(
                            text: Lists.enterUpiIdRecentList[index]
                            ["text2"],
                            fontSize: 12,
                            color: black171,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
