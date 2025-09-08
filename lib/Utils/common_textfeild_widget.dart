import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:flutter/material.dart';

class CommonTextFieldWidget {
  static TextFormField1({
    prefixIcon,
    controller,
    keyboardType,
    hintText,
    bool obscureText = false,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      cursorColor: black171,
      controller: controller,
      obscureText: obscureText,  
      style: TextStyle(
        color: black171,
        fontSize: 14,
        fontFamily: FontFamily.InterSemiBold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: greyA6A,
          fontSize: 14,
          fontFamily: FontFamily.InterRegular,
        ),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: whiteF9F,
        contentPadding: EdgeInsets.zero,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(88),
            borderSide: BorderSide(color: greyA6A, width: 0.5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(88),
            borderSide: BorderSide(color: greyA6A, width: 0.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(88),
            borderSide: BorderSide(color: greyA6A, width: 0.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(88),
            borderSide: BorderSide(color: greyA6A, width: 0.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(88),
            borderSide: BorderSide(color: greyA6A, width: 0.5)),
      ),
    );
  }

  static TextFormField2({
    prefixIcon,
    suffixIcon,
    controller,
    keyboardType,
    hintText,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      cursorColor: Colors.green,
      controller: controller,
      style: TextStyle(
        color: black171,
        fontSize: 14,
        fontFamily: FontFamily.InterSemiBold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: greyA6A,
          fontSize: 16,
          fontFamily: FontFamily.InterRegular,
        ),
        prefixIcon: prefixIcon ?? SizedBox.shrink(),
        suffixIcon: suffixIcon ?? SizedBox.shrink(),
        filled: true,
        fillColor: greyF5F,
        contentPadding: EdgeInsets.zero,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: greyF5F, width: 0)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: greyF5F, width: 0)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: greyF5F, width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: greyF5F, width: 0)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: greyF5F, width: 0)),
      ),
    );
  }

  static TextFormField3({
    suffixIcon,
    controller,
    keyboardType,
    hintText,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      cursorColor: Colors.green,
      controller: controller,
      style: TextStyle(
        color: black171,
        fontSize: 14,
        fontFamily: FontFamily.InterSemiBold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: greyA6A,
          fontSize: 14,
          fontFamily: FontFamily.InterRegular,
        ),
        suffixIcon: suffixIcon ?? SizedBox.shrink(),
        filled: true,
        fillColor: whiteF9F,
        contentPadding: EdgeInsets.only(left: 15),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(88),
            borderSide: BorderSide(color: greyA6A, width: 0.5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(88),
            borderSide: BorderSide(color: greyA6A, width: 0.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(88),
            borderSide: BorderSide(color: greyA6A, width: 0.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(88),
            borderSide: BorderSide(color: greyA6A, width: 0.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(88),
            borderSide: BorderSide(color: greyA6A, width: 0.5)),
      ),
    );
  }

  static TextFormField4({
    controller,
    keyboardType,
    hintText,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      cursorColor: Colors.green,
      controller: controller,
      style: TextStyle(
        color: black171,
        fontSize: 14,
        fontFamily: FontFamily.InterSemiBold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: greyA6A,
          fontSize: 18,
          fontFamily: FontFamily.InterMedium,
        ),
        filled: true,
        fillColor: whiteF9F,
        contentPadding: EdgeInsets.only(left: 15),
        disabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyE5E, width: 0)),
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyA6A, width: 0)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyA6A, width: 0)),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyA6A, width: 0)),
        errorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyA6A, width: 0)),
      ),
    );
  }

  static TextFormField5({
    prefixIcon,
    suffixIcon,
    controller,
    keyboardType,
    hintText,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      cursorColor: Colors.green,
      controller: controller,
      style: TextStyle(
        color: black171,
        fontSize: 14,
        fontFamily: FontFamily.InterSemiBold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: greyA6A,
          fontSize: 16,
          fontFamily: FontFamily.InterRegular,
        ),
        prefixIcon: prefixIcon ?? SizedBox.shrink(),
        suffixIcon: suffixIcon ?? SizedBox.shrink(),
        filled: true,
        fillColor: greyF5F,
        contentPadding: EdgeInsets.zero,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: greyA6A, width: 1)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: greyA6A, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: greyA6A, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: greyA6A, width: 1)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: greyA6A, width: 1)),
      ),
    );
  }

  static TextFormField6({
    prefixIcon,
    controller,
    keyboardType,
    hintText,
    labelText,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      cursorColor: black171,
      controller: controller,
      style: TextStyle(
        color: black171,
        fontSize: 14,
        fontFamily: FontFamily.InterSemiBold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: greyA6A,
          fontSize: 16,
          fontFamily: FontFamily.InterRegular,
        ),
        prefixIcon: prefixIcon ?? SizedBox.shrink(),
        labelText: labelText,
        labelStyle: TextStyle(
          color: grey757,
          fontSize: 14,
          fontFamily: FontFamily.InterMedium,
        ),
        filled: true,
        fillColor: white,
        contentPadding: EdgeInsets.zero,
        disabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyC4C.withOpacity(0.5), width: 0.5)),
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyC4C.withOpacity(0.5), width: 0.5)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyC4C.withOpacity(0.5), width: 0.5)),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyC4C.withOpacity(0.5), width: 0.5)),
        errorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyC4C.withOpacity(0.5), width: 0.5)),
      ),
    );
  }

  static TextFormField7({
    controller,
    keyboardType,
    hintText,
    labelText,
    suffixIcon
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      cursorColor: black171,
      controller: controller,
      style: TextStyle(
        color: black171,
        fontSize: 14,
        fontFamily: FontFamily.InterSemiBold,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: greyA6A,
          fontSize: 16,
          fontFamily: FontFamily.InterRegular,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: grey757,
          fontSize: 14,
          fontFamily: FontFamily.InterMedium,
        ),
        suffixIcon: suffixIcon ?? SizedBox.shrink(),
        filled: true,
        fillColor: white,
        contentPadding: EdgeInsets.zero,
        disabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyC4C.withOpacity(0.5), width: 0.5)),
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyC4C.withOpacity(0.5), width: 0.5)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyC4C.withOpacity(0.5), width: 0.5)),
        enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyC4C.withOpacity(0.5), width: 0.5)),
        errorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: greyC4C.withOpacity(0.5), width: 0.5)),
      ),
    );
  }
}
