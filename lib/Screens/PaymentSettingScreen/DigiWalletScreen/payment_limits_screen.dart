import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/payment_limits_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentLimitsScreen extends StatelessWidget {
  PaymentLimitsScreen({Key? key}) : super(key: key);

  final PaymentLimitsController paymentLimitsController =
      Get.put(PaymentLimitsController());
  final TextEditingController numberOfPaymentController =
      TextEditingController();
  final TextEditingController amountToBeSpentController =
      TextEditingController();
  final TextEditingController numberOfPaymentController1 =
      TextEditingController();
  final TextEditingController amountToBeSpentController1 =
      TextEditingController();

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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget.InterBold(
                  text: "Payment Limits",
                  fontSize: 20,
                  color: black171,
                ),
                SizedBox(height: 8),
                CommonTextWidget.InterRegular(
                  text:
                      "Select your DigiWallet account by setting up Limits for different type of payments",
                  fontSize: 14,
                  color: black171,
                ),
                SizedBox(height: 25),
                ListView.builder(
                  itemCount: Lists.paymentLimitsList.length,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 20),
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
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonTextWidget.InterMedium(
                                    text: Lists.paymentLimitsList[index]
                                        ["text"],
                                    fontSize: 14,
                                    color: black171,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      paymentLimitsController
                                              .arrowClick[index] =
                                          !paymentLimitsController
                                              .arrowClick[index];
                                    },
                                    child: Row(
                                      children: [
                                        CommonTextWidget.InterMedium(
                                          text: "ADD LIMITS",
                                          fontSize: 12,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 6),
                                      SvgPicture.asset(Images.arrowDownIcon, color: Colors.green,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              paymentLimitsController.arrowClick[index] == true
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        CommonTextWidget.InterSemiBold(
                                          text: "Daily Limit:",
                                          fontSize: 12,
                                          color: black0F1,
                                        ),
                                        SizedBox(height: 20),
                                        CommonTextFieldWidget.TextFormField3(
                                          controller: numberOfPaymentController,
                                          hintText: "Number of Payme...",
                                          keyboardType: TextInputType.text,
                                        ),
                                        SizedBox(height: 20),
                                        CommonTextFieldWidget.TextFormField3(
                                          controller: amountToBeSpentController,
                                          hintText: "Amount to be spent",
                                          keyboardType: TextInputType.text,
                                        ),
                                        SizedBox(height: 20),
                                        CommonTextWidget.InterSemiBold(
                                          text: "Monthly Limit:",
                                          fontSize: 12,
                                          color: black0F1,
                                        ),
                                        SizedBox(height: 20),
                                        CommonTextFieldWidget.TextFormField3(
                                          controller:
                                              numberOfPaymentController1,
                                          hintText: "Number of Payme...",
                                          keyboardType: TextInputType.text,
                                        ),
                                        SizedBox(height: 20),
                                        CommonTextFieldWidget.TextFormField3(
                                          controller:
                                              amountToBeSpentController1,
                                          hintText: "Amount to be spent",
                                          keyboardType: TextInputType.text,
                                        ),
                                        SizedBox(height: 30),
                                        CommonButtonWidget.button(
                                          onTap: () {},
                                          buttonColor: Colors.green,
                                          text: "Save",
                                        ),
                                        // SizedBox(height: 20),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CommonTextWidget.InterBold(
                  text: "Add Money",
                  fontSize: 18,
                  color: black171,
                ),
                SizedBox(height: 28),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0,
                  leading:
                    SvgPicture.asset(Images.automaticPaymentAndSubscription, color: Colors.green,),
                  title: CommonTextWidget.InterSemiBold(
                    text: "Add money refund back to source",
                    fontSize: 14,
                    color: black171,
                  ),
                  trailing: Obx(
                    () => Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        onChanged: (val) =>
                            paymentLimitsController.switchIsOpen.toggle(),
                        value: paymentLimitsController.switchIsOpen.value,
                        activeColor: Colors.green,
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
