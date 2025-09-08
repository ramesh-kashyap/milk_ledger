import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/digiwallet_ticket_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TrainScreen extends StatefulWidget {
  TrainScreen({Key? key}) : super(key: key);

  @override
  State<TrainScreen> createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> {
  final DigiwalletTicketTabController digiwalletTicketTabController =
      Get.put(DigiwalletTicketTabController());

  final TextEditingController fromController = TextEditingController();

  final TextEditingController toController = TextEditingController();

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController adultController = TextEditingController();
  final TextEditingController childController = TextEditingController();
  final TextEditingController infantController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 150),
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
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 30),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CommonTextFieldWidget.TextFormField6(
                          hintText: "From",
                          controller: fromController,
                          keyboardType: TextInputType.text,
                          prefixIcon: Padding(
                            padding:
                                EdgeInsets.only(right: 22, top: 10, bottom: 10),
                            child:SvgPicture.asset(Images.nounAirplane),
                          ),
                          labelText: "From",
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: blueECE,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child:SvgPicture.asset(Images.swap),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CommonTextFieldWidget.TextFormField6(
                    hintText: "To",
                    controller: toController,
                    keyboardType: TextInputType.text,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 22, top: 10, bottom: 10),
                      child:SvgPicture.asset(Images.nounAirplane2),
                    ),
                    labelText: "To",
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                    SvgPicture.asset(Images.calendar),
                      SizedBox(width: 22),
                      Expanded(
                        child: TextFormField(
                          cursorColor: black171,
                          controller: fromDateController,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          showCursor: false,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1990, 01, 01),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Container(
                                  child: child,
                                );
                              },
                            );
                            setState(() {
                              final DateFormat formatter =
                                  DateFormat('dd-MM-yyyy');
                              final String formatted = formatter.format(date!);
                              fromDateController.text = formatted;
                            });
                          },
                          style: TextStyle(
                            color: black171,
                            fontSize: 14,
                            fontFamily: FontFamily.InterSemiBold,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "From",
                            hintStyle: TextStyle(
                              color: greyA6A,
                              fontSize: 16,
                              fontFamily: FontFamily.InterRegular,
                            ),
                            labelText: "From",
                            labelStyle: TextStyle(
                              color: grey757,
                              fontSize: 14,
                              fontFamily: FontFamily.InterMedium,
                            ),
                            filled: true,
                            fillColor: white,
                            disabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    color: greyC4C.withOpacity(0.5),
                                    width: 0.5)),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    color: greyC4C.withOpacity(0.5),
                                    width: 0.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    color: greyC4C.withOpacity(0.5),
                                    width: 0.5)),
                            enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    color: greyC4C.withOpacity(0.5),
                                    width: 0.5)),
                            errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                    color: greyC4C.withOpacity(0.5),
                                    width: 0.5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: greyF5F,
                                border: Border.all(color: greyA6A, width: 0.5),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(14),                                child:SvgPicture.asset(Images.airConditioner),
                              ),
                            ),
                            SizedBox(height: 5),
                            CommonTextWidget.InterMedium(
                              text: "AC",
                              fontSize: 12,
                              color: grey757,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 25),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: greyF5F,
                                border: Border.all(color: greyA6A, width: 0.5),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(14),                                child:SvgPicture.asset(Images.nonAc),
                              ),
                            ),
                            SizedBox(height: 5),
                            CommonTextWidget.InterMedium(
                              text: "Non AC",
                              fontSize: 12,
                              color: grey757,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 25),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: greyF5F,
                                border: Border.all(color: greyA6A, width: 0.5),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(14),                                child:SvgPicture.asset(Images.seat),
                              ),
                            ),
                            SizedBox(height: 5),
                            CommonTextWidget.InterMedium(
                              text: "Seater",
                              fontSize: 12,
                              color: grey757,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 25),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: greyF5F,
                                border: Border.all(color: greyA6A, width: 0.5),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(14),
                                child:SvgPicture.asset(Images.slumber),
                              ),
                            ),
                            SizedBox(height: 5),
                            CommonTextWidget.InterMedium(
                              text: "Sleeper",
                              fontSize: 12,
                              color: grey757,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  CommonButtonWidget.button(
                    text: "Search Train",
                    buttonColor: Colors.green,
                    onTap: () {},
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
