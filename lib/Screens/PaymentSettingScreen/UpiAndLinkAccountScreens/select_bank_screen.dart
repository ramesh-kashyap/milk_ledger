import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectBankScreen extends StatelessWidget {
  SelectBankScreen({Key? key}) : super(key: key);

  final TextEditingController searchBankController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
        title: CommonTextWidget.InterSemiBold(
          text: "Select Your Bank",
          fontSize: 18,
          color: black171,
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextFieldWidget.TextFormField2(
                  controller: searchBankController,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child:SvgPicture.asset(Images.search, color: Colors.green),
                  ),
                  keyboardType: TextInputType.text,
                  hintText: "Search",
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextWidget.InterSemiBold(
                  text: "Popular banks",
                  fontSize: 20,
                  color: black171,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0,
                        offset: Offset(0, 0),
                        color: black.withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) => GridView.count(
                      padding: EdgeInsets.only(top: 15, left: 2, right: 2),
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio * 3.5 /2,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        Lists.popularBanksList.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              Image.asset(
                                  Lists.popularBanksList[index]["image"],
                                  height: 55,
                                  width: 55),
                              SizedBox(height: 5),
                              CommonTextWidget.InterMedium(
                                text: Lists.popularBanksList[index]["text"],
                                fontSize: 13,
                                color: black171,
                                textAlign: TextAlign.center
                              ),
                            ],
                          ),
                        ),
                      ).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextWidget.InterSemiBold(
                  text: "All Other Banks",
                  fontSize: 20,
                  color: black171,
                ),
              ),
              SizedBox(height: 18),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: Lists.allOtherBanksList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Image.asset(
                              Lists.allOtherBanksList[index]["image"],
                              height: 45,
                              width: 45,
                            ),
                            SizedBox(width: 10),
                            CommonTextWidget.InterMedium(
                              text: Lists.allOtherBanksList[index]["text"],
                              fontSize: 14,
                              color: black171,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(thickness: 1, color: greyF3F),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
