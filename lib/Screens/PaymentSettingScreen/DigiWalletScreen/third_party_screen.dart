import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ThirdPartyScreen extends StatelessWidget {
  ThirdPartyScreen({Key? key}) : super(key: key);

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
      ),
      body: Column(
        children: [
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: CommonTextWidget.InterBold(
              text: "Third Party Apps linked with DigiWallet",
              fontSize: 18,
              color: black171,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50),
        SvgPicture.asset(Images.thirdPartyImage, color: Colors.green,),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: CommonTextWidget.InterRegular(
              text: "Your DigiWallet is not linked with any App",
              fontSize: 16,
              color: black171,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
