// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constans.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Muli",
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme());
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 30,
      vertical: 16,
    ),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Color(0xFFFF1744),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
   /* textTheme: TextTheme(
      headline6: TextStyle(
        color: Color(0XFF8B8B8B),
        fontSize: 18.0,
      ),
    ),*/ systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
}
