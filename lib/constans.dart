import 'package:flutter/material.dart';
import 'package:sfiasset/size_config.dart';

import 'app_localizations.dart';


const kPrimaryColor = Color(0xFFFF1744);
const kPrimaryLightColor = Color(0xffff616f);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xffff616f), Color(0xFFFF1744)],
);
const kBackgroundColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xffffffff), Color(0xFFFCB7C4)],
);

const kSecondaryColor = Color(0xFFC4001D);
const kTextColor = Color(0xDD211F1F);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(18.0),
  color: Colors.black,
  fontWeight: FontWeight.bold,
  height: 1.5,
);

//For Error
// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "กรุณากรอก Email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

AppBar CustomAppBarHome() => AppBar(
  toolbarHeight: 80,
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: kBackgroundColor
    ),
  ),
  title: Padding(
    padding: const EdgeInsets.all(10),
    child: Image.asset(
      'assets/images/logo.png',
      height: getProportionateScreenHeight(50),
      width: getProportionateScreenWidth(100),
      fit: BoxFit.fill,
    ),
  ),
  centerTitle: true,
);
AppBar CustomAppBarButtom(String title,Function press) => AppBar(
  actions: [
  PopupMenuButton(itemBuilder: (BuildContext context) {
    return [
      PopupMenuItem(
        child: ListTile(
          isThreeLine: false,
          iconColor: kPrimaryColor,

          leading: const Icon(Icons.create),
          title:  Text('แจ้งทำบัตรใหม่',style: TextStyle(fontSize: getProportionateScreenWidth(12),color: kPrimaryColor),),
          onTap: () {
            press();
          },
        ),
      ),
    ];
  })
  ],
  flexibleSpace: Container(
    decoration: const BoxDecoration(
        gradient: kBackgroundColor
    ),
  ),
  title: Align(
    alignment: Alignment.centerRight,
    child: Text(
      title,
      style: TextStyle(
          color: kTextColor,
          fontWeight: FontWeight.bold,
          fontSize: getProportionateScreenWidth(18.0)),
    ),
  ),
  centerTitle: false,
);

AppBar CustomAppBarMenu(String title) => AppBar(
flexibleSpace: Container(
  decoration: const BoxDecoration(
    gradient: kBackgroundColor
  ),
),
  title: Align(
    alignment: Alignment.centerRight,
    child: Text(
        title,
        style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(18.0)),
      ),
  ),


  centerTitle: false,
);

String ConverDate(BuildContext context,String date) {
  String convertTxt;
  if (date != "null") {
    print("ช่องว่าง ${date.split(' ').length}");
    if (date.split(' ').length > 5) {
      convertTxt =
      "${date.split(' ')[0]} ${AppLocalizations.of(context).translate("day")} "
          "${date.split(' ')[2]} ${AppLocalizations.of(context).translate("hour")}"
          " ${date.split(' ')[4]} ${AppLocalizations.of(context).translate("minute")}";
    }else if (date.split(' ').length > 4  ) {
      if(date.split(' ')[3] == "Mn") {
        convertTxt =
        "${date.split(' ')[0]} ${AppLocalizations.of(context).translate(
            "day")} "
            "${date.split(' ')[2]} ${AppLocalizations.of(context).translate(
            "minute")}";
      }else {
        convertTxt =
        "${date.split(' ')[0]} ${AppLocalizations.of(context).translate(
            "day")} "
            "${date.split(' ')[2]} ${AppLocalizations.of(context).translate(
            "hour")}";
      }
    } else {
      if (date.contains("Day")) {
        convertTxt = "${date.split(' ')[0]} ${AppLocalizations.of(context).translate("day")}";
      } else {
        convertTxt = "${date.split(' ')[0]} ${AppLocalizations.of(context).translate("hour")}";
      }
    }
  } else {
    convertTxt = "0 ${AppLocalizations.of(context).translate("day")}";
  }

  return convertTxt;
}

