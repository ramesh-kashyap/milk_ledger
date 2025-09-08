import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({Key? key}) : super(key: key);

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  int _selectedIndex = 0;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 45, left: 25, right: 25, bottom: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, size: 20, color: black171),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CommonTextFieldWidget.TextFormField2(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child:
                          SvgPicture.asset(Images.search, color: Colors.green),
                    ),
                    keyboardType: TextInputType.text,
                    hintText: "Search",
                    controller: searchController,
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 1, color: greyEDE),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: Get.height,
                    decoration: BoxDecoration(
                      color: whiteF8F,
                      boxShadow: [
                        BoxShadow(
                          color: black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 16,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 0;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 0
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "Featured",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "Featured",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 1
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "Recharge \nand Pay \nBills",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "Recharge \nand Pay \nBills",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 2;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 2
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "Loan &\nCredit\nCard",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "Loan &\nCredit\nCard",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 3;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 3
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "Travel",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "Travel",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 4;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 4
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "Stocks &\nIPO",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "Stocks &\nIPO",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 5;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 5
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "Movies &\nEvents",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "Movies &\nEvents",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 6;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 6
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "Mini Apps\nStore",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "Mini Apps\nStore",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 7;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 7
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "Wallet",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "Wallet",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 8;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 8
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "Insurance",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "Insurance",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 9;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 9
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "Games",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "Games",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 10;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 10
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "DigiWallet\nBank",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "DigiWallet\nBank",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = 11;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // height: 50,
                              child: _selectedIndex == 11
                                  ? CommonTextWidget.InterBold(
                                      color: Colors.green,
                                      fontSize: 14,
                                      text: "City\nTransit",
                                      textAlign: TextAlign.center)
                                  : CommonTextWidget.InterRegular(
                                      color: black171,
                                      fontSize: 14,
                                      text: "City\nTransit",
                                      textAlign: TextAlign.center),
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 5,
                          childAspectRatio:
                              MediaQuery.of(context).size.aspectRatio * 2 / 1.6,
                        ),
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        itemCount: Lists.allServicesList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: white,
                                      spreadRadius: 0,
                                      offset: Offset(0, 0),
                                      blurRadius: 12,
                                    ),
                                  ],
                                  color: white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: index == 9
                                      ? Image.asset(
                                          Lists.allServicesList[index]["image"])
                                      : SvgPicture.asset(
                                          Lists.allServicesList[index]["image"],
                                          color: Colors.green,
                                        ),
                                ),
                              ),
                              SizedBox(height: 10),
                              CommonTextWidget.InterSemiBold(
                                  color: black171,
                                  text: Lists.allServicesList[index]["text"],
                                  fontSize: 12,
                                  textAlign: TextAlign.center),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
