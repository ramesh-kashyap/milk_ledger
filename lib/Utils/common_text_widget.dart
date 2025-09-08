import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:flutter/material.dart';

class CommonTextWidget {
  static InterBold(
      {String? text, Color? color, double? fontSize, TextAlign? textAlign}) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: FontFamily.InterBold,
      ),
    );
  }

  static InterRegular(
      {String? text, Color? color, double? fontSize, TextAlign? textAlign}) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: FontFamily.InterRegular,
      ),
    );
  }

  static InterSemiBold(
      {String? text, Color? color, double? fontSize, TextAlign? textAlign}) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: FontFamily.InterSemiBold,
      ),
    );
  }

  static InterMedium(
      {String? text, Color? color, double? fontSize, TextAlign? textAlign}) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: FontFamily.InterMedium,
      ),
    );
  }

  static InterLight(
      {String? text, Color? color, double? fontSize, TextAlign? textAlign}) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: FontFamily.InterLight,
      ),
    );
  }
}
