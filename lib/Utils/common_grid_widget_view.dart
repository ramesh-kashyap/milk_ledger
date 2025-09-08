import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonGridWidget {
  static grid(context, list, onTap) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 15,
        childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2/ 1.9,
      ),
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 22),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: list[index]["onTap"],
              child: Container(
                height: 60,
                width: 60,
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
                  padding:  EdgeInsets.all(15),
                  child:SvgPicture.asset(
                    list[index]["image"],
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            CommonTextWidget.InterSemiBold(
              color: black171,
              text: list[index]["text"],
              fontSize: 12,
              textAlign: TextAlign.center
            ),
          ],
        );
      },
    );
  }

  static grid1(context, list, onTap) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 15,
        childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2/ 1.9,
      ),
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 22),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: 60,
              width: 60,
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
                padding:  EdgeInsets.all(15),
                child: Image.asset(
                  list[index]["image"],
                  height: 60,
                  width: 60,
                ),
              ),
            ),
            SizedBox(height: 10),
            CommonTextWidget.InterSemiBold(
                color: black171,
                text: list[index]["text"],
                fontSize: 12,
                textAlign: TextAlign.center
            ),
          ],
        );
      },
    );
  }

  static grid2(context, list, onTap) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 15,
        childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2/ 1.6,
      ),
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 22),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: 60,
              width: 60,
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
              child: Image.asset(
                list[index]["image"],
              ),
            ),
            SizedBox(height: 10),
            CommonTextWidget.InterSemiBold(
                color: black171,
                text: list[index]["text"],
                fontSize: 12,
                textAlign: TextAlign.center
            ),
          ],
        );
      },
    );
  }
}
