import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/emp_card/components/body_card.dart';


class EmpCardScreen extends StatefulWidget {
  const EmpCardScreen({Key? key}) : super(key: key);
  static String routName = "/emp_card";

  @override
  State<EmpCardScreen> createState() => _EmpCardScreenState();
}

class _EmpCardScreenState extends State<EmpCardScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu(AppLocalizations.of(context).translate('empCard')),
      body: const BodyCard(),
    );
  }
}
