import 'package:flutter/material.dart';
import 'package:sfiasset/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
Future<void> SignOutProcess (BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routName, (route) => false);
}