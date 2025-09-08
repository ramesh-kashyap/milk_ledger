import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrepaidOperatorDetailTabController extends GetxController with GetSingleTickerProviderStateMixin{
  final List<Tab> myTabs = <Tab>[
    Tab(text: '121 Made for you',),
    Tab(text: 'Hero unlimited'),
    Tab(text: 'Cricket Packs'),
    Tab(text: 'Data'),
    Tab(text: 'Unlimited'),
    Tab(text: 'Popular'),
    Tab(text: 'Combo'),
    Tab(text: 'Talktime'),
    Tab(text: 'VAS'),
    Tab(text: 'Roaming'),
    Tab(text: 'Plan Voucher'),
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
}