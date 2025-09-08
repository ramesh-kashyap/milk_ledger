import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/CashBackAndOfferScreen/cashback_won_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_grid_widget_view.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashBackAndOfferScreen extends StatelessWidget {
  CashBackAndOfferScreen({Key? key}) : super(key: key);

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
          text: "Cashback & Offers",
          fontSize: 18,
          color: black171,
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => CashBackWonScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: greyE5E, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 8, left: 8, right: 8, bottom: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextWidget.InterBold(
                                text: "₹1000",
                                fontSize: 18,
                                color: Colors.green,
                              ),
                              CommonTextWidget.InterMedium(
                                text: "Cashback Won",
                                fontSize: 12,
                                color: black171,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => CashBackWonScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: greyE5E, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 8, left: 8, right: 8, bottom: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextWidget.InterBold(
                                text: "20",
                                fontSize: 18,
                                color: Colors.green,
                              ),
                              CommonTextWidget.InterMedium(
                                text: "Cashback Points",
                                fontSize: 12,
                                color: black171,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => CashBackWonScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: greyE5E, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 8, left: 8, right: 8, bottom: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextWidget.InterBold(
                                text: "9",
                                fontSize: 18,
                                color: Colors.green,
                              ),
                              CommonTextWidget.InterMedium(
                                text: "My Vouchers",
                                fontSize: 12,
                                color: black171,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 22, right: 22, bottom: 15),
                child: CommonTextWidget.InterBold(
                  text: "Convert Cashback Pointes",
                  fontSize: 18,
                  color: black171,
                ),
              ),
              CommonGridWidget.grid1(
                context,
                Lists.convertCashBackList,
                () {},
              ),
              SizedBox(height: 20),
              Divider(color: greyE7E, thickness: 1),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 22, right: 22, bottom: 15),
                child: CommonTextWidget.InterBold(
                  text: "Convert Cashback Pointes",
                  fontSize: 18,
                  color: black171,
                ),
              ),
              CommonGridWidget.grid(
                context,
                Lists.exclusiveOffersList,
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
