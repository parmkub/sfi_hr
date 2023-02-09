import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double? screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight!;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double? screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth!;
}

Container showImageDrawerHearder(String image) {
  return Container(
    child: CircleAvatar(
      backgroundImage: NetworkImage(
          "http://10.1.1.2/inet_application/images/users/$image.jpg"),
    ),
  );
}

Widget showProgress(){
  return Center(child: CircularProgressIndicator(),);
}

Text showTitleH2(String title) => Text(
  title,style: TextStyle(fontSize: getProportionateScreenWidth(10.0),color: kPrimaryColor,fontWeight: FontWeight.bold),
);
