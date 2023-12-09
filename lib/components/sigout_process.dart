import 'package:flutter/material.dart';
import 'package:sfiasset/screens/menu_main_screen/menu_main.dart';
import 'package:sfiasset/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
Future<void> SignOutProcess (BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  // ignore: use_build_context_synchronously
  Navigator.pushNamedAndRemoveUntil(context, MenuMainScreen.routName, (route) => false);
}