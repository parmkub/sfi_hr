import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';

import 'componanents/body.dart';

class UserManualScreen extends StatefulWidget {
  const UserManualScreen({Key? key}) : super(key: key);
  static String routName = "/user_manual";

  @override
  State<UserManualScreen> createState() => _UserManualScreenState();
}

class _UserManualScreenState extends State<UserManualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu(AppLocalizations.of(context).translate('userManual')),
      body:  const BodyUserManual(blogType: 'manual',),
    );
  }
}
