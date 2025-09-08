import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HelpScreen4 extends StatelessWidget {
  HelpScreen4({Key? key}) : super(key: key);

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
          text: "24x7 Help",
          fontSize: 18,
          color: black171,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget.InterBold(
              text: "Recharges & Bill Payments",
              fontSize: 20,
              color: black171,
            ),
            Center(
              child: Column(
                children: [
                SvgPicture.asset(Images.order,color: Colors.green,),
                  SizedBox(height: 12),
                  CommonTextWidget.InterBold(
                    text: "No recent orders found",
                    fontSize: 18,
                    color: black171,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteFCF,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ListTile(
                horizontalTitleGap: 0,
                leading:SvgPicture.asset(Images.chat,color: Colors.green,),
                title: CommonTextWidget.InterBold(
                  text: "Need help with non order related queries?",
                  fontSize: 14,
                  color: black171,
                ),
                subtitle: CommonTextWidget.InterRegular(
                  text: "Chat with us",
                  fontSize: 12,
                  color: grey757,
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: grey757, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
