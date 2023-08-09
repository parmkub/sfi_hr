import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/registor_screen/components/body.dart';

class RegistorScreen extends StatelessWidget {
  final String username;
  final String empCode;
  final String name;
  const RegistorScreen(
      {super.key,
      required this.username,
      required this.empCode,
      required this.name});
  static String routName = "/registor_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu(AppLocalizations.of(context).translate('register')),
      body: Body(username: username,empCode: empCode,name: name,),
    );
  }
}
