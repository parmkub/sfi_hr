import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/appeal_screen/components/body.dart';

class AppealScreen extends StatelessWidget {
  const AppealScreen({Key? key}) : super(key: key);
  static String routName = "/appeal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarMenu(AppLocalizations.of(context).translate('Appeal')),
      body: const Center(
        child: BodyAppeal(),
      ),
    );
  }
}
