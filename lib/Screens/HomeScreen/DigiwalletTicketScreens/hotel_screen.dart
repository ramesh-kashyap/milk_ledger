import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';

class HotelScreen extends StatelessWidget {
  HotelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 400),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: black3C4.withOpacity(0.2),
              blurRadius: 40,
              offset: Offset(0, 15),
            ),
          ],
          color: white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget.InterRegular(
                text: "City / Locality Hotel Name",
                fontSize: 12,
                color: grey757,
              ),
              SizedBox(height: 4),
              CommonTextWidget.InterMedium(
                text: "City, Area or Hotel Name",
                fontSize: 14,
                color: black171,
              ),
              SizedBox(height: 18),
              Divider(color: greyC4C.withOpacity(0.5), thickness: 0.5),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget.InterRegular(
                        text: "Check In",
                        fontSize: 12,
                        color: grey757,
                      ),
                      Row(
                        children: [
                          CommonTextWidget.InterMedium(
                            text: "27",
                            fontSize: 32,
                            color: black171,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget.InterRegular(
                                text: "September",
                                fontSize: 12,
                                color: black171,
                              ),
                              CommonTextWidget.InterSemiBold(
                                text: "Tuesday",
                                fontSize: 12,
                                color: black171,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 35,
                    width: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: greyF3F,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonTextWidget.InterRegular(
                          text: "1",
                          fontSize: 12,
                          color: black171,
                        ),
                        CommonTextWidget.InterRegular(
                          text: "Night",
                          fontSize: 8,
                          color: grey757,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget.InterRegular(
                        text: "Check Out",
                        fontSize: 12,
                        color: grey757,
                      ),
                      Row(
                        children: [
                          CommonTextWidget.InterMedium(
                            text: "28",
                            fontSize: 32,
                            color: black171,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget.InterRegular(
                                text: "September",
                                fontSize: 12,
                                color: black171,
                              ),
                              CommonTextWidget.InterSemiBold(
                                text: "Wednesday",
                                fontSize: 12,
                                color: black171,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(color: greyC4C.withOpacity(0.5), thickness: 0.5),
              SizedBox(height: 30),
              CommonButtonWidget.button(
                onTap: () {},
                buttonColor: Colors.green,
                text: "Search Hotels",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
