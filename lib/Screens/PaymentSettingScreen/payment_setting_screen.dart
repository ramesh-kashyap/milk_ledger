import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentSettingScreen extends StatelessWidget {
  PaymentSettingScreen({Key? key}) : super(key: key);

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
          text: "Payment Settings",
          fontSize: 18,
          color: black171,
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 15, left: 22, right: 22, bottom: 20),
          itemCount: Lists.paymentSettingList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: InkWell(
              onTap: Lists.paymentSettingList[index]["onTap"],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SvgPicture.asset(
                    Lists.paymentSettingList[index]["image"],
                    color: Colors.green,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget.InterMedium(
                          text: Lists.paymentSettingList[index]["text1"],
                          fontSize: 14,
                          color: black171,
                        ),
                        SizedBox(height: 2),
                        CommonTextWidget.InterRegular(
                          text: Lists.paymentSettingList[index]["text2"],
                          fontSize: 12,
                          color: grey757,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child:
                        Icon(Icons.arrow_forward_ios, color: grey757, size: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
