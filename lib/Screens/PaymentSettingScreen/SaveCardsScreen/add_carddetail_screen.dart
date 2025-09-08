import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/add_carddetail_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardDetailScreen extends StatelessWidget {
  AddCardDetailScreen({Key? key}) : super(key: key);

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final AddCardDetailController addCardDetailController =
      AddCardDetailController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 300),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: white,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: whiteF9F,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: CommonTextWidget.InterSemiBold(
                      text: "Enter Debit or Credit Card Details",
                      fontSize: 20,
                      color: black171,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: CommonTextWidget.InterRegular(
                      text: "Card Number",
                      fontSize: 12,
                      color: grey757,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: CommonTextFieldWidget.TextFormField4(
                      keyboardType: TextInputType.number,
                      hintText: "XX XXXX",
                      controller: cardNumberController,
                    ),
                  ),
                  SizedBox(height: 28),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget.InterRegular(
                                text: "Expiry / Validity Date",
                                fontSize: 12,
                                color: grey757,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextFieldWidget.TextFormField4(
                                      keyboardType: TextInputType.text,
                                      hintText: "MM",
                                      controller: monthController,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: CommonTextFieldWidget.TextFormField4(
                                      keyboardType: TextInputType.text,
                                      hintText: "YY",
                                      controller: yearController,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 35),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget.InterRegular(
                                text: "Expiry / Validity Date",
                                fontSize: 12,
                                color: grey757,
                              ),
                              SizedBox(height: 10),
                              CommonTextFieldWidget.TextFormField4(
                                keyboardType: TextInputType.text,
                                hintText: "CVV",
                                controller: cvvController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => InkWell(
                            onTap: () {
                              addCardDetailController.select.value =
                                  !addCardDetailController.select.value;
                            },
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                color: addCardDetailController.select.isTrue
                                    ? Colors.green
                                    : white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: addCardDetailController.select.isTrue
                                        ? Colors.green
                                        : greyDCD,
                                    width: 1),
                              ),
                              child: Center(
                                child:
                                    Icon(Icons.check, color: white, size: 10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: CommonTextWidget.InterRegular(
                            text: "Save card as per latest RBI guidelines",
                            fontSize: 12,
                            color: grey757,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                    child: CommonButtonWidget.button(
                      text: "Pay ₹2.00",
                      buttonColor: Colors.green,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
