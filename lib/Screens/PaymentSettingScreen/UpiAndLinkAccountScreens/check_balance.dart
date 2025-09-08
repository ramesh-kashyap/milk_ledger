import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/check_balance_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentSettingScreen/UpiAndLinkAccountScreens/change_pin_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentSettingScreen/UpiAndLinkAccountScreens/select_bank_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CheckBalanceScreen extends StatelessWidget {
  CheckBalanceScreen({Key? key}) : super(key: key);
  final CheckBalanceController checkBalanceController =
      Get.put(CheckBalanceController());

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CommonTextWidget.InterBold(
                  text: "Payment Settings",
                  fontSize: 20,
                  color: black171,
                ),
                SizedBox(height: 8),
                CommonTextWidget.InterMedium(
                  text: "Select default bank account to receive money",
                  fontSize: 16,
                  color: black171,
                ),
                SizedBox(height: 22),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: greyE5E, width: 1),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: whiteF9F,
                          child:SvgPicture.asset(Images.bobImge,color: Colors.green,),
                        ),
                        title: CommonTextWidget.InterBold(
                          text: "Bank of Baroda",
                          fontSize: 16,
                          color: black171,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget.InterMedium(
                              text: "Saving a?c No. XX 1953",
                              fontSize: 12,
                              color: grey757,
                            ),
                            CommonTextWidget.InterMedium(
                              text: "A/c Holder Name: John Doe",
                              fontSize: 12,
                              color: grey757,
                            ),
                            SizedBox(height: 12),
                            CommonTextWidget.InterBold(
                              text: "₹ 10,000",
                              fontSize: 24,
                              color: black171,
                            ),
                            SizedBox(height: 6),
                            CommonTextWidget.InterRegular(
                              text: "Ten thousand rupees only",
                              fontSize: 10,
                              color: grey757,
                            ),
                            SizedBox(height: 4),
                            CommonTextWidget.InterRegular(
                              text:
                                  "Available Balance at 10:51, 15 September 2022",
                              fontSize: 10,
                              color: greyA6A,
                            ),
                          ],
                        ),
                        trailing: Obx(
                          () => InkWell(
                            onTap: () {
                              checkBalanceController.select.value =
                                  !checkBalanceController.select.value;
                            },
                            child:SvgPicture.asset(
                                checkBalanceController.select.isTrue
                                    ? Images.selectedIcon
                                    : Images.unSelectedIcon),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(15),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: greyF6F,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget.InterMedium(
                                text: "Remove Account",
                                fontSize: 10,
                                color: grey757,
                              ),
                              SizedBox(
                                height: 20,
                                width: 10,
                                child: VerticalDivider(
                                  width: 20,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                  color: greyE5E,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => ChangePinScreen());
                                },
                                child: CommonTextWidget.InterSemiBold(
                                  text: "Change PIN",
                                  fontSize: 10,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                width: 10,
                                child: VerticalDivider(
                                  width: 20,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                  color: greyE5E,
                                ),
                              ),
                              CommonTextWidget.InterSemiBold(
                                text: "Check Balance",
                                fontSize: 10,
                                color: greyF6F,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Get.to(() => SelectBankScreen());
                  },
                  child: Container(
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
                      leading:SvgPicture.asset(Images.bankImage, color: Colors.green,),
                      title: CommonTextWidget.InterSemiBold(
                        text: "Add Another Bank Account",
                        fontSize: 14,
                        color: black171,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: grey757, size: 18),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => InkWell(
                        onTap: () {
                          checkBalanceController.select1.value =
                              !checkBalanceController.select1.value;
                        },
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: checkBalanceController.select1.isTrue
                                ? Colors.green
                                : white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color:
                                    checkBalanceController.select1.isTrue
                                        ? Colors.green
                                        : greyDCD,
                                width: 1),
                          ),
                          child: Center(
                            child: Icon(Icons.check, color: white, size: 10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CommonTextWidget.InterRegular(
                        text:
                            "If default account is experiencing high transaction "
                            "failures, DigiWallet will automatically use another "
                            "account for receiving money",
                        fontSize: 12,
                        color: grey757,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.upiAndLinkAccountList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: greyE5E, width: 1),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        child: Row(
                          children: [
                          SvgPicture.asset(
                                Lists.upiAndLinkAccountList[index]["image"]
                                , color: Colors.green,),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget.InterSemiBold(
                                    text: Lists.upiAndLinkAccountList[index]
                                        ["text1"],
                                    fontSize: 14,
                                    color: black171,
                                  ),
                                  CommonTextWidget.InterRegular(
                                    text: Lists.upiAndLinkAccountList[index]
                                        ["text2"],
                                    fontSize: 12,
                                    color: grey6A7,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
