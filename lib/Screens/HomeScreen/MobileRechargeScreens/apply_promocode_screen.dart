import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MobileRechargeScreens/apply_offer_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ApplyPromoCodeScreen extends StatelessWidget {
  ApplyPromoCodeScreen({Key? key}) : super(key: key);

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
        title: CommonTextWidget.InterSemiBold(
          text: "Apply Promocode",
          fontSize: 18,
          color: black171,
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                width: Get.width,
                color: white,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    cursorColor: black171,
                    style: TextStyle(
                      color: black171,
                      fontSize: 14,
                      fontFamily: FontFamily.InterRegular,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 44,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.green,
                          ),
                          child: Center(
                            child: CommonTextWidget.InterMedium(
                              text: "Apply",
                              fontSize: 16,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                      hintText: "Enter Promocode",
                      hintStyle: TextStyle(
                        color: grey757,
                        fontSize: 14,
                        fontFamily: FontFamily.InterLight,
                      ),
                      filled: true,
                      fillColor: white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: greyEEE, width: 1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greyEEE, width: 1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greyEEE, width: 1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: Get.width,
                color: greyF6F,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CommonTextWidget.InterMedium(
                    text: "Or Select An Offer (6)",
                    fontSize: 14,
                    color: black171,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Column(
                  children: [
                    Container(
                      color: white,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(Images.applyPromoCodeImage,
                                        height: 20, width: 40),
                                    SizedBox(width: 9),
                                    CommonTextWidget.InterMedium(
                                      text: "DigiWallet Cashback \nworth ₹30",
                                      fontSize: 14,
                                      color: black171,
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.bottomSheet(
                                      ApplyOfferScreen(),
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                    );
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: greyF0F,
                                    ),
                                    child: Center(
                                      child: CommonTextWidget.InterSemiBold(
                                        text: "APPLY",
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(thickness: 1, color: greyF1F),
                            SizedBox(height: 10),
                            CommonTextWidget.InterRegular(
                              text:
                                  "Get ₹30 cashback on mobile recharge or mobile bill "
                                  "payment of ₹ 199 or more",
                              fontSize: 12,
                              color: grey757,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                CommonTextWidget.InterMedium(
                                  text: "VISDEBIT",
                                  fontSize: 11,
                                  color: grey757,
                                ),
                                SizedBox(width: 22),
                                CommonTextWidget.InterMedium(
                                  text: "OFFER DETAILS",
                                  fontSize: 11,
                                  color: grey757,
                                ),
                                SizedBox(width: 5),
                              SvgPicture.asset(Images.arrowDownIcon),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 8,
                      width: Get.width,
                      color: greyF6F,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
