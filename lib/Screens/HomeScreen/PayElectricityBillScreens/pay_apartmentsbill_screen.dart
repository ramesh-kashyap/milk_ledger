import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:flutter/material.dart';

class PayApartmentBillScreen extends StatelessWidget {
  PayApartmentBillScreen({Key? key}) : super(key: key);
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTextFieldWidget.TextFormField3(
          controller: cityController,
          hintText: "City",
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 200),
        CommonButtonWidget.button(
          onTap: () {},
          buttonColor: Colors.green,
          text: "Proceed",
        ),
        SizedBox(height: 10),
        CommonTextWidget.InterRegular(
          text: "Apartment Office might take a day to reflect this "
          "payments in your account statement.",
          fontSize: 14,
          color: grey757,
        ),
      ],
    );
  }
}
