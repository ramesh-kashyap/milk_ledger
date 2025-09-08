import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/FastagScreen/enter_vehical_number_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectYourFastagScreen extends StatelessWidget {
   SelectYourFastagScreen({Key? key}) : super(key: key);
   final TextEditingController searchController = TextEditingController();

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
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CommonTextWidget.InterBold(
                  text: "Select your FASTag Issure Bank",
                  fontSize: 22,
                  color: black171,
                ),
                SizedBox(height: 15),
                CommonTextFieldWidget.TextFormField2(
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child:SvgPicture.asset(Images.search, color: Colors.green),
                  ),
                  keyboardType: TextInputType.text,
                  hintText: "Search Bank",
                  controller: searchController,
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.selectYourFastagList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: (){
                        Get.to(()=>EnterVeheicalNumberScreen());
                      },
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: greyE5E, width: 1),
                          borderRadius: BorderRadius.circular(16),
                          color: white,
                        ),
                        child: ListTile(
                          leading: Image.asset(
                              Lists.selectYourFastagList[index]["image"],
                              height: 45,
                              width: 45),
                          title: CommonTextWidget.InterSemiBold(
                            text: Lists.selectYourFastagList[index]
                            ["text"],
                            fontSize: 16,
                            color: black171,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
