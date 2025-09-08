import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/digiwallet_ticket_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/DigiwalletTicketScreens/bus_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/DigiwalletTicketScreens/flight_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/DigiwalletTicketScreens/hotel_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/DigiwalletTicketScreens/offer_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/DigiwalletTicketScreens/train_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DigiwalletTicketTabScreen extends StatelessWidget {
  DigiwalletTicketTabScreen({Key? key}) : super(key: key);

  final DigiwalletTicketTabController digiwalletTicketTabController =
      Get.put(DigiwalletTicketTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.green,
                  blue866,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 60, left: 22, right: 22),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back, size: 20, color: white),
                      ),
                      SizedBox(width: 22),
                      CommonTextWidget.InterSemiBold(
                        text: "DigiWallet Ticket",
                        fontSize: 18,
                        color: white,
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  TabBar(
                    isScrollable: true,
                    tabs: digiwalletTicketTabController.myTabs,
                    unselectedLabelColor: white,
                    labelStyle:
                        TextStyle(fontFamily: "InterSemiBold", fontSize: 14),
                    unselectedLabelStyle:
                        TextStyle(fontFamily: "InterSemiBold", fontSize: 14),
                    labelColor: white,
                    controller: digiwalletTicketTabController.controller,
                    indicatorColor: white,
                    indicatorWeight: 5,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: digiwalletTicketTabController.controller,
              children: [
                FlightScreen(),
                TrainScreen(),
                BusScreen(),
                FlightScreen(),
                Scaffold(),
                OfferScreen(),
                HotelScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
