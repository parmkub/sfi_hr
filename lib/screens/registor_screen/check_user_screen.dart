import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/screens/registor_screen/components/body_check_user.dart';

import '../../constans.dart';

class CheckUserSceen extends StatefulWidget {
  const CheckUserSceen({super.key});
  static String routName = "/check_user_screen";

  @override
  State<CheckUserSceen> createState() => _CheckUserSceenState();
}

class _CheckUserSceenState extends State<CheckUserSceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu(AppLocalizations.of(context).translate('register')),
      body: BodyCheck()
    );
  }
}
