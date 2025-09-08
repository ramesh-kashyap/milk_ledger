import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DigiwalletTicketTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Row(
        children: [
        SvgPicture.asset(Images.airplane,),
          SizedBox(width: 3),
          Text("Flight"),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: [
        SvgPicture.asset(Images.train),
          SizedBox(width: 3),
          Text("Train"),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: [
        SvgPicture.asset(Images.bus),
          SizedBox(width: 3),
          Text("Bus"),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: [
        SvgPicture.asset(Images.airplane),
          SizedBox(width: 3),
          Text("Intl.Flights"),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: [
        SvgPicture.asset(Images.metro),
          SizedBox(width: 3),
          Text("Metro"),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: [
        SvgPicture.asset(Images.discount),
          SizedBox(width: 3),
          Text("Offers"),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: [
        SvgPicture.asset(Images.hotel),
          SizedBox(width: 3),
          Text("Hotels"),
        ],
      ),
    ),
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  // ignore: prefer_typing_uninitialized_variables
  var selectedIndex;

  onIndexChange(index) {
    selectedIndex = index;
    update();
  }
}
