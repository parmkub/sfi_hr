// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/size_config.dart';

Card CustomDrawerMenu(
    BuildContext context, String menu, var icon, Function press) {
  return Card(
    child: ListTile(
      leading: Icon(
        icon,
        color: kSecondaryColor,
        size: getProportionateScreenWidth(20.0),
      ),
      title: Text(
        menu,
        style: TextStyle(
            color: kTextColor, fontSize: getProportionateScreenHeight(16.0)),
      ),
      onTap: () {
        press();
      },
    ),
  );
}

SizedBox CustomHolidayCard(BuildContext context, String menu, String valude,
    var icon, Function press) {
  return SizedBox(
    child: Card(
      elevation: 5,
      child: ListTile(
        leading: SizedBox(
          child: Image.asset(icon),
          height: 80,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              menu,
              style: TextStyle(
                color: kTextColor,
                fontSize: getProportionateScreenHeight(16.0),
              ),
            ),
            valude == "null"
                ? Text(
                    "0 Day",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenHeight(16.0),
                    ),
                  )
                : Text(
                    valude,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenHeight(16.0),
                    ),
                  ),
          ],
        ),
        onTap: () {
          press();
        },
      ),
    ),
  );
}
